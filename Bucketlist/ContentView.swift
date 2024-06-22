import SwiftUI
import Lottie

struct ContentView: View {
    @Binding var latestAchievement: String
    @State private var fruits: [String] {
        didSet {
            UserDefaults.standard.set(fruits, forKey: "Buckets")
        }
    }
    @State private var completedFruits: [String] {
        didSet {
            UserDefaults.standard.set(completedFruits, forKey: "CompletedBuckets")
        }
    }
    @State private var newFruit = ""
    @State private var isAddingFruit = false
    @State private var showingPopup = false
    @State private var showingCelebration = false
    @State private var showingActionSheet = false
    @State private var selectedFruit: String?

    init(latestAchievement: Binding<String>) {
        self._latestAchievement = latestAchievement
        if let savedFruits = UserDefaults.standard.object(forKey: "Buckets") as? [String] {
            _fruits = State(initialValue: savedFruits)
        } else {
            _fruits = State(initialValue: ["content1", "content2", "content3", "content4"])
        }
        
        if let savedCompletedFruits = UserDefaults.standard.object(forKey: "CompletedBuckets") as? [String] {
            _completedFruits = State(initialValue: savedCompletedFruits)
        } else {
            _completedFruits = State(initialValue: [])
        }
    }

    var body: some View {
        NavigationView {
            let titles = ["BucketList", "완료된 항목"]
            let data = [fruits, completedFruits]

            VStack {
                List {
                    ForEach(data.indices, id: \.self) { index in
                        Section(header: Text(titles[index]).font(.title),
                                footer: HStack { Spacer(); Text("\(data[index].count)건") }
                        ) {
                            ForEach(data[index], id: \.self) { item in
                                HStack {
                                    if index == 0 {
                                        CustomCheckbox(isOn: Binding(
                                            get: { false },
                                            set: { isCompleted in
                                                if isCompleted {
                                                    moveItemToCompleted(item: item)
                                                    showingCelebration = true
                                                }
                                            }
                                        )) {
                                            Text(item)
                                        }
                                    } else {
                                        CustomCheckbox(isOn: Binding(
                                            get: { true },
                                            set: { isCompleted in
                                                if !isCompleted {
                                                    moveItemToBucketlist(item: item)
                                                }
                                            }
                                        )) {
                                            Text(item)
                                                .strikethrough()
                                        }
                                    }
                                    Spacer()
                                    Button(action: {
                                        selectedFruit = item
                                        showingActionSheet = true
                                    }) {
                                        Image(systemName: "ellipsis")
                                            .foregroundColor(.gray)
                                    }
                                    .actionSheet(isPresented: $showingActionSheet) {
                                        ActionSheet(
                                            title: Text(selectedFruit ?? ""),
                                            buttons: [
                                                .default(Text("수정")) {
                                                    // 수정 로직을 추가하세요.
                                                },
                                                .destructive(Text("삭제")) {
                                                    if index == 0 {
                                                        if let index = fruits.firstIndex(of: selectedFruit!) {
                                                            fruits.remove(at: index)
                                                        }
                                                    } else {
                                                        if let index = completedFruits.firstIndex(of: selectedFruit!) {
                                                            completedFruits.remove(at: index)
                                                        }
                                                    }
                                                },
                                                .cancel()
                                            ]
                                        )
                                    }
                                }
                            }
                        }
                    }
                }
//                .popup(isPresented: $showingPopup) {
//                    AddList(newFruit: $newFruit, onAdd: addNewFruit)
//                }
                .overlay(
                    Group {
                        if showingCelebration {
                            ZStack {
                                Color.black.opacity(0.4).edgesIgnoringSafeArea(.all)
                                
                                LottieView(name: "confetti", loopMode: .loop)
                                    .frame(width: 300, height: 300)
                                    .background(Color.clear)
                                
                                VStack {
                                    Text("축하합니다!")
                                        .font(.headline)
                                        .padding()
                                        .background(Color.white)
                                        .cornerRadius(10)
                                        .shadow(radius: 10)
                                    
                                    Button(action: {
                                        showingCelebration = false
                                    }) {
                                        Text("닫기")
                                            .foregroundColor(.white)
                                            .padding()
                                            .background(Color.blue)
                                            .cornerRadius(10)
                                    }
                                }
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(Color.clear)
                            }
                        }
                    }
                )
                .listStyle(DefaultListStyle())
            }
            .overlay(
                VStack {
                    Spacer()
                    HStack {
                        Button(action: {
                            showingPopup.toggle()
                            if !showingPopup {
                                newFruit = ""
                            }
                        }) {
                            Image(systemName: "plus")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .clipShape(Circle())
                                .shadow(radius: 10)
                        }
                        .padding(.bottom, 20)
                    }
                    .frame(maxWidth: .infinity)
                }
            )
        }
        .navigationBarHidden(true)
    }

    private func addNewFruit() {
        if !newFruit.isEmpty {
            fruits.append(newFruit)
            newFruit = ""
            showingPopup = false
        }
    }

    private func moveItemToCompleted(item: String) {
        if let index = fruits.firstIndex(of: item) {
            fruits.remove(at: index)
            completedFruits.append(item)
            latestAchievement = item // Update the latest achievement
        }
    }
    
    private func moveItemToBucketlist(item: String) {
        if let index = completedFruits.firstIndex(of: item) {
            completedFruits.remove(at: index)
            fruits.append(item)
        }
    }
}

struct CustomCheckbox<Label>: View where Label: View {
    @Binding var isOn: Bool
    var label: () -> Label

    var body: some View {
        Button(action: {
            isOn.toggle()
        }) {
            HStack {
                Image(systemName: isOn ? "checkmark.square" : "square")
                label()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(latestAchievement: .constant(""))
    }
}

struct AddList: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var newFruit: String
    var onAdd: () -> Void

    var body: some View {
        VStack {
            TextField("Enter new item", text: $newFruit)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .background(Color.white) // 추가된 코드: 백그라운드 컬러를 흰색으로 지정하여 텍스트 입력이 가능하도록 함
            
            Button(action: {
                onAdd()
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Add")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()
            
            Spacer()
        }
        .padding()
        .background(Color.white) // 추가된 코드: 백그라운드 컬러를 흰색으로 지정하여 텍스트 입력이 가능하도록 함
    }
}


//문제 발생

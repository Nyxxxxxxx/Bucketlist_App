import SwiftUI
import Lottie

struct Main: View {
    @State private var selectedSegment = 0
    @State private var bucketListItems = [Item(name: "First Mission", completed: false), Item(name: "Second Mission", completed: false), Item(name: "Third Mission", completed: false)]
    @State private var completedItems = [Item(name: "Completed Mission 1", completed: true), Item(name: "Completed Mission 2", completed: true)]

    @State private var showingSheet = false
    @State private var newItem = ""
    @State private var showingCelebration = false

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                Picker("Segments", selection: $selectedSegment) {
                    Text("Bucketlist").tag(0)
                    Text("Completed").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                
                List {
                    Section {
                        ForEach(currentItems.indices, id: \.self) { index in
                            HStack {
                                CheckBoxView(isChecked: currentItems[index].completed, toggleCompletion: {
                                    toggleCompletion(for: index)
                                    if !currentItems[index].completed {  // 아이템이 완료되면 축하 이효과 표시
                                                                            showingCelebration = true
                                                                        }
                                })
                                VStack(alignment: .leading) {
                                    Text(currentItems[index].name)
                                        .fontWeight(.bold)
                                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt.")
                                        .font(.footnote)
                                        .foregroundColor(.gray)
                                }
                            }
                            .padding(.vertical, 8)
                        }
                        .onDelete(perform: deleteItem)
                    }
                }
                .background(Color.white)
            }
            .navigationTitle(selectedSegment == 0 ? "Bucketlist" : "Completed")
            .overlay(
                VStack {
                    Spacer()
                    if selectedSegment == 0 {
                        FloatingActionButton(action: {
                            showingSheet = true
                        })
                    }
                }
                .padding(.bottom, 20)
            )
            .sheet(isPresented: $showingSheet) {
                AddItemView(newItem: $newItem, onAdd: {
                    if !newItem.isEmpty {
                        bucketListItems.append(Item(name: newItem, completed: false))
                        newItem = ""
                        showingSheet = false
                    }
                }, onCancel: {
                    showingSheet = false  // Close sheet when cancelled
                })
                
            }
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
        }
    }

    private func toggleCompletion(for index: Int) {
        let item = selectedSegment == 0 ? bucketListItems.remove(at: index) : completedItems.remove(at: index)
        if selectedSegment == 0 {
            completedItems.append(item.withCompleted(true))
        } else {
            bucketListItems.append(item.withCompleted(false))
        }
    }

    private func deleteItem(at offsets: IndexSet) {
        if selectedSegment == 0 {
            bucketListItems.remove(atOffsets: offsets)
        } else {
            completedItems.remove(atOffsets: offsets)
        }
    }

    var currentItems: [Item] {
        selectedSegment == 0 ? bucketListItems : completedItems
    }
}

struct CheckBoxView: View {
    var isChecked: Bool
    let toggleCompletion: () -> Void

    var body: some View {
        Image(systemName: isChecked ? "checkmark.square.fill" : "square")
            .resizable()
            .frame(width: 24, height: 24)
            .onTapGesture(perform: toggleCompletion)
    }
}

struct FloatingActionButton: View {
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: "plus")
                .resizable()
                .frame(width: 30, height: 30)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(Circle())
                .shadow(radius: 10)
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }
}

struct AddItemView: View {
    @Binding var newItem: String
    var onAdd: () -> Void
    var onCancel: () -> Void

    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter new mission", text: $newItem)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button("Add", action: onAdd)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                
                Spacer()
            }
            .padding()
            .navigationTitle("Add New Mission")
            .navigationBarItems(trailing: Button("Cancel", action: onCancel))
        }
    }
}

struct Item: Identifiable {
    var id = UUID()
    var name: String
    var completed: Bool

    func withCompleted(_ completed: Bool) -> Item {
        return Item(id: self.id, name: self.name, completed: completed)
    }
}

struct Main_Previews: PreviewProvider {
    static var previews: some View {
        Main()
    }
}

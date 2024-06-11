import SwiftUI

struct GetName: View {
    @State private var selectedLanguage: String = "English"
    @State private var name: String = ""
    @State private var navigateToGetBirth = false
    
    var languages = ["English", "Korean"]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                Image("memo")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 200, height: 200)
                    .clipped()
                    .cornerRadius(5)
                    .shadow(color: Color.black.opacity(0.15), radius: 10, x: 5, y: 5)
                
                HStack {
                                    Spacer()
                                    VStack(alignment: .center) {
                                        Text("Name")
                                            .font(.headline)
                                        TextField("", text: $name)
                                            .textFieldStyle(RoundedBorderTextFieldStyle())
                                            .padding(.vertical, 10)
                                    }
                                    Spacer()
                                }
                                .padding(.horizontal)

//                VStack(alignment: .leading) {
//                    Text("Birthdate")
//                        .font(.headline)
//                    DatePicker("", selection: $birthdate, displayedComponents: .date)
//                        .datePickerStyle(CompactDatePickerStyle())
//                        .padding(.vertical, 5)
//                }
//                .padding(.horizontal)
                
                Button(action: {saveData()
                    navigateToGetBirth = true}) {
                    Text("Next")
                        .fontWeight(.bold)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
                NavigationLink(
                    destination: GetBirth(),
                    isActive: $navigateToGetBirth,
                    label: {
                        EmptyView()
                    }
                )
            }
            .navigationTitle("Name")
        }
    }
    
    func saveData() {
        let userDefaults = UserDefaults.standard
        userDefaults.set(name, forKey: "username")
    }
}

struct GetName_Previews: PreviewProvider {
    static var previews: some View {
        GetName()
    }
}

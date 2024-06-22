import SwiftUI



struct GetName: View {
    @State private var selectedLanguage: String = "English"
    @State private var name: String = ""
    @State private var navigateToGetBirth = false
    
    var languages = ["English", "Korean"]
    
    var body: some View {
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
                                        Text("What is your Name?")
                                            .font(.headline)
                                        TextField("", text: $name)
                                            .textFieldStyle(RoundedBorderTextFieldStyle())
                                            .padding(.top, 20)
                                            .font(.system(size: 30)) //박스 크기 조절
                                            
                                    }
                                    Spacer()
                                }
                                .padding(.horizontal)
                
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
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
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

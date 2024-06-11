import SwiftUI

struct Info: View {
    @State private var selectedLanguage: String = "English"
    @State private var name: String = ""
    @State private var navigateToGetName = false
    
    var languages = ["English", "Korean"]
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                Image("memo")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 200, height: 200)
                    .clipped()
                    .cornerRadius(5)
                    .shadow(color: Color.black.opacity(0.15), radius: 10, x: 5, y: 5)
                
                VStack(alignment: .leading) {
                    Text("Language")
                        .font(.headline)
                        .font(.system(size: 24))
                    Picker("Language", selection: $selectedLanguage) {
                        ForEach(languages, id: \.self) { language in
                            Text(language)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .padding(.vertical, 5)
                }
                .padding(.horizontal)
                
                Button(action: {
                    saveData()
                    navigateToGetName = true
                }) {
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
                    destination: GetName(),
                    isActive: $navigateToGetName,
                    label: {
                        EmptyView()
                    }
                )
            }
            .navigationTitle("Information")
            .navigationDestination(isPresented: $navigateToGetName) {
                GetName()
            }
        }
    }
    
    func saveData() {
        let userDefaults = UserDefaults.standard
        userDefaults.set(selectedLanguage, forKey: "language")
    }
}

struct Info_Previews: PreviewProvider {
    static var previews: some View {
        Info()
    }
}

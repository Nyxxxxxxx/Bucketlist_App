import SwiftUI

struct GetBirth: View {
    @State private var selectedLanguage: String = "English"
    @State private var name: String = ""
    @State private var birthdate: Date = Date()
    @State private var age: Int = 0
    
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
                
                VStack {
                    Text("Birthdate")
                        .font(.headline)
                        .multilineTextAlignment(.center)
                    
                    DatePicker("", selection: $birthdate, displayedComponents: .date)
                        .datePickerStyle(CompactDatePickerStyle())
                        .labelsHidden()
                        .padding(.vertical, 5)
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                }
                .padding(.horizontal)
                
                Button(action: {
                    saveBirth()
                    calculateAge()
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
                .navigationTitle("Birthday")
            }
            .padding()
            .onAppear(perform: calculateAge)
        }
    }
    
    func saveBirth() {
        let userDefaults = UserDefaults.standard
        userDefaults.set(birthdate, forKey: "birthdate")
    }
    
    func calculateAge() {
        let calendar = Calendar.current
        let now = Date()
        let ageComponents = calendar.dateComponents([.year], from: birthdate, to: now)
        age = ageComponents.year ?? 0
        
        let userDefaults = UserDefaults.standard
        userDefaults.set(age, forKey: "age")
    }
}

struct GetBirth_Previews: PreviewProvider {
    static var previews: some View {
        GetBirth()
    }
}

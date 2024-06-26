import SwiftUI
//컨셉 : 파란색 : 항해?
//수정사항 : 1. Hall of Fame에 지금있는 Product가 Last Achievement로 내려가야 한다.
// 2. 디자인 파란색으로 모두 바꾸기
// 3. Hall of Fame 디자인 하기 / 이쁘게..!
// 4. 클릭하면 Road Map에 추가되기
// 5. 세팅 마지막에 추가하기

struct Home: View {
    @State private var username: String = ""
    @State private var age: Int = 0
    @State private var latestAchievement: String = ""
    @State private var navigateToAchievement = false

    var body: some View {
        NavigationView {
            VStack {
                Text("Hello,")
                    .font(.title)
                    .bold()
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 0))
                
                Text(username)
                    .font(.title)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(EdgeInsets(top: 0, leading: 15, bottom: 40, trailing: 0))

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        Spacer() // 왼쪽에 여백 추가
                            .frame(width: 1)
                        
                        NavigationLink(destination: Main()) {
                            ZStack {
                                Image("note")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 170, height: 200)
                                    .clipped()
                                    .cornerRadius(5)
                                    .shadow(color: Color.black.opacity(0.15), radius: 10, x: 5, y: 5)
                                    .padding(.vertical, 10)
                                
                                VStack {
                                    Image("pin")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(.red)
                                        .rotationEffect(.degrees(30))
                                        .padding(.top, -65)
                                    
                                    VStack {
                                        HStack {
                                            Image(systemName: "checkmark.square")
                                                .imageScale(.large)
                                                .foregroundColor(.black)
                                            Text("Bucketlist")
                                                .font(.headline)
                                                .foregroundColor(.black)
                                        }
                                        .padding(.top, 10)
                                    }
                                }.padding()
                            }
                        }
                        
                        NavigationLink(destination: RoadMap()) {
                            ZStack {
                                Image("note")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 170, height: 200)
                                    .clipped()
                                    .cornerRadius(5)
                                    .shadow(color: Color.black.opacity(0.15), radius: 10, x: 5, y: 5)
                                    .padding(.vertical, 10)
                                
                                VStack {
                                    Image("pin")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(.red)
                                        .rotationEffect(.degrees(30))
                                        .padding(.top, -34)
                                    
                                    Image("road")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 60, height: 60)
                                        .foregroundColor(.red)
                                        .padding(.top, 5)
                                    
                                    VStack {
                                        Text("RoadMap")
                                            .font(.headline)
                                            .foregroundColor(.black)
                                    }
                                }.padding()
                            }
                        }
                        
                        Spacer() // 오른쪽에도 여백 추가
                            .frame(width: 10)
                    }
                }
                .frame(height: 220) // 높이를 늘려서 그림자가 보이도록 함
                .padding()
                
                // 명예의 전당 페이지
                VStack {
                    Text("Latest Achievment")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                    
                    NavigationLink(destination: CityTourView()){
                        ProductRow(product: productSamples[0])
                            .scaleEffect(0.85)
                    }
                    
                }
                Text("Hall of Fame")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                ZStack {
                                Rectangle()
                                    .fill(Color.white.opacity(0.9))
                                    .frame(width: 350, height: 60)
                                    .cornerRadius(10)
                                
                            }
                            .overlay(
                                Text(latestAchievement.isEmpty ? "No achievements yet." : latestAchievement)
                                    .foregroundColor(.black)
                                    .padding()
                            )
                        }
            .navigationBarItems(trailing: Button(action: {
                print("This service will be open lately")
            }) {
                Image(systemName: "person.circle")
                    .imageScale(.large)
                    .padding()
                    .foregroundColor(.black.opacity(0.6))
            })
            .onAppear {
                loadUserData()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    private func loadUserData() {
        let userDefaults = UserDefaults.standard
        username = userDefaults.string(forKey: "username") ?? "Guest"
        age = userDefaults.integer(forKey: "age")
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

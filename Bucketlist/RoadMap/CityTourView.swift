import SwiftUI

struct CityTourView: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image("city")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                    .opacity(0.7)
                
                VStack(alignment: .leading) {
                    Spacer()
                    
                    // 텍스트를 특정 위치에 배치
                    
                    VStack {
                        Text("City Tour")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .position(x: geometry.size.width * 0.25, y: geometry.size.height * 0.2)
                        // 좌표 설정
                        
                        Text("Location: NewYork")
                            .fontWeight(.medium)
                            .position(x: geometry.size.width * 0.25, y: geometry.size.height * 0.1) // 좌표 설정
                    }
                        
                        Text("Achieve Duration: 3 months")
                        .fontWeight(.medium)
                            .position(x: geometry.size.width * 0.35, y: geometry.size.height * 0.1)
                    
                    
                    Spacer()
                    
                    Button(action: {
                        // 예약 동작
                    }) {
                        Text("Get Certification")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .position(x: geometry.size.width * 0.5, y: geometry.size.height * 0.2) // 버튼 위치 설정
                }
            }
        }
    }
}

//struct CityTourView_Previews: PreviewProvider {
//    static var previews: some View {
//        CityTourView()
//    }
//}

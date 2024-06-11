////
////  AddList.swift
////  Bucketlist
////
////  Created by 김세민 on 5/11/24.
////
//
//import SwiftUI
//
//struct AddList: View {
//    @State private var inputText = ""
//    
//    var body: some View {
//    Text("내용을 입력해주세요")
//        .font(.system(size: 20))
//        .bold() // 볼드체
//        .kerning(2) // 자간 조정
//        .padding() // 텍스트 주변에 패딩 추가
//        
//    TextField("여기에 입력하세요", text: $inputText) // 텍스트 입력창
//        .textFieldStyle(RoundedBorderTextFieldStyle()) // 입력창 스타일
//        .padding() // 입력창 주변에 패딩 추가
//      }
//    
//}
//
//struct AddList_Previews: PreviewProvider {
//    static var previews: some View {
//        Color.gray.colorInvert()
//          .popup(isPresented: .constant(true)) { AddList() }
//          .edgesIgnoringSafeArea(.vertical)   }
//}

//
//  ProductRow.swift
//  Bucketlist
//
//  Created by 김세민 on 5/5/24.
//

import SwiftUI

struct ProductRow: View {
    var body: some View {
        HStack{
            productImage
            productDescription
        }
        .frame(height: 150)
        .background(Color.primary.colorInvert())
        .cornerRadius(6)
        .shadow(color: Color.primary.opacity(0.33), radius: 1, x: 2, y: 2)
        .padding(.vertical, 8)
    }
    let product: Product
}

private extension ProductRow{
    // 프로퍼티
    var productImage: some View{
        Image("Complete")
            .resizable()
            .scaledToFill()
            .frame(width: 140)
            .clipped()
    }
    
    var productDescription: some View{
        VStack(alignment : .leading){
            Text(product.name)
                .font(.headline)
                .fontWeight(.medium)
                .padding(.bottom, 6)
            
            Text(product.description)
                .font(.footnote)
                .foregroundColor(.secondary)
            
            Spacer()
        
            footerView
        }
        .padding([.leading, .bottom], 12)
        .padding([.top, .trailing])
    }
    
    var footerView: some View {
        HStack(spacing: 0){
            Text("@").font(.footnote) + Text("\(product.price)").font(.headline)
            Spacer()
            Image(systemName: "heart")
                .imageScale(.large)
                .foregroundColor(Color("peach"))
                .frame(width: 32, height: 32)
            
            Image(systemName: "cart") 
                .foregroundColor(Color("peach"))
                .frame(width: 32, height: 32)
        }
    }
}

//이 화면에만 나타나는 확인용도
struct  ProductRow_Previews: PreviewProvider{
    static var previews: some View{
        ProductRow(product: productSamples[0])
    }
}

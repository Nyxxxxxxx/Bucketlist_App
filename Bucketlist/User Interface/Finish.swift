//
//  Home.swift
//  Bucketlist
//
//  Created by 김세민 on 5/5/24.
//

import SwiftUI

struct Finish: View {
    var body: some View {
        VStack {
            ProductRow(product: productSamples[0])
            ProductRow(product: productSamples[1])
            ProductRow(product: productSamples[2])
        }
        
    }
}

#Preview {
    Finish()
}


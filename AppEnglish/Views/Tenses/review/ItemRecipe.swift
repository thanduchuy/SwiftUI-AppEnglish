//
//  ItemRecipe.swift
//  AppEnglish
//
//  Created by MacBook Pro on 5/13/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI

struct ItemRecipe: View {
    @State var width : CGFloat
    @Binding var data : [String]
    @State var arr = ["plus.circle","minus.circle","questionmark.circle"]
    var body : some View {
        VStack {
            VStack(alignment : .leading,spacing: 30) {
                ForEach(0..<arr.count) { index in
                    VStack(alignment : .leading,spacing: 10) {
                        Image(systemName: self.arr[index])
                            .renderingMode(.original)
                        if self.data.count > 0 {
                            Text("\(self.data[index])")
                                .fontWeight(.bold)
                        }
                    }
                }
            }.padding(.horizontal, 20)
            .padding(.vertical, 30)
            .background(Color.white)
            .cornerRadius(20)
            .padding(.top,25)
            Spacer()
        }.frame(width: self.width)
    }
}

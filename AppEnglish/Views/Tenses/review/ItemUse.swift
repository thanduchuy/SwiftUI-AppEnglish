//
//  ItemUse.swift
//  AppEnglish
//
//  Created by MacBook Pro on 5/13/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI

struct ItemUse: View {
    @State var width : CGFloat
    @Binding var data : [String]
    var body : some View {
        VStack {
            VStack(alignment : .leading,spacing: 30) {
            if self.data.count > 0 {
                ForEach(0..<data.count) { index in
                    HStack(spacing: 10) {
                        Image(systemName: "circle.fill")
                            .renderingMode(.original)
                            Text("\(self.data[index])")
                                .fontWeight(.bold)
                            Spacer()
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

//
//  ItemSignal.swift
//  AppEnglish
//
//  Created by MacBook Pro on 5/13/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI

struct ItemSignal: View {
    @State var width : CGFloat
    @Binding var data : String
    var body: some View {
        VStack {
            VStack(spacing: 30) {
                Image("smileys")
                    .frame(width: self.width-80)
                Text("\(data)")
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
            }.padding(.horizontal, 20)
                .padding(.vertical, 30)
                .background(Color.white)
                .cornerRadius(20)
                .padding(.top,25)
            Spacer()
        }.frame(width: self.width)
    }
}

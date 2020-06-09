//
//  ItemSentence.swift
//  AppEnglish
//
//  Created by MacBook Pro on 5/7/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI

struct ItemSentence: View {
    @Binding var selectQuestion : Int
    @Binding var index : Int
    @Binding var text : String
    var body: some View {
        Button(action: {
            if self.selectQuestion == self.index {
                self.selectQuestion = 100
            } else {
                self.selectQuestion = self.index
            }
        }) {
           VStack(spacing:0) {
                Text(text)
                   .foregroundColor(self.selectQuestion == index ? Color.yellow.opacity(0.8) :Color.black.opacity(0.8))
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .padding()
                Divider()
                    .frame(width: UIScreen.main.bounds.width-45, height: 5)
               .background(self.selectQuestion == index ? Color.yellow.opacity(0.8) :Color.gray.opacity(0.8))
            }.frame(width:  UIScreen.main.bounds.width-40)
           .overlay(
               RoundedRectangle(cornerRadius: 10)
                  .stroke(self.selectQuestion == index ? Color.yellow.opacity(0.8) :Color.gray.opacity(0.8), lineWidth: 3)
           )
        }
    }
}


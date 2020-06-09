//
//  TestWrappedLayout.swift
//  AppEnglish
//
//  Created by MacBook Pro on 5/8/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI

struct TestWrappedLayout: View {
    @State var platforms : [String]
    @Binding var checkVoice : [String]
    var body: some View {
        GeometryReader { geometry in
            self.generateContent(in: geometry)
        }
    }
    private func generateContent(in g: GeometryProxy) -> some View {
           var width = CGFloat.zero
           var height = CGFloat.zero

           return ZStack(alignment: .topLeading) {
            ForEach(0..<self.platforms.count, id: \.self) { index in
                self.item(for: self.platforms[index],check: index < self.checkVoice.count ? self.checkVoice[index] : "" )
                       .padding([.horizontal, .vertical], 4)
                       .alignmentGuide(.leading, computeValue: { d in
                           if (abs(width - d.width) > g.size.width)
                           {
                               width = 0
                               height -= d.height
                           }
                           let result = width
                           if self.platforms[index] == self.platforms.last! {
                               width = 0 //last item
                           } else {
                               width -= d.width
                           }
                           return result
                       })
                       .alignmentGuide(.top, computeValue: {d in
                           let result = height
                           if self.platforms[index] == self.platforms.last! {
                               height = 0 // last item
                           }
                           return result
                       })
               }
           }
       }
    func checkText(_ text: String ,_ ch : String) -> Bool {
        return removeSpecialChar(text: text).lowercased().contains(removeSpecialChar(text: ch).lowercased())
    }
    func item(for text: String,check ch: String) -> some View {
           Text(text)
               .padding(.all, 5)
               .font(.system(size: 40, weight: .bold, design: .serif))
            .background(checkText(text,ch) ? Color.yellow : Color.black)
               .foregroundColor(checkText(text,ch) ? Color.black : Color.yellow)
               .cornerRadius(5)
       }
}

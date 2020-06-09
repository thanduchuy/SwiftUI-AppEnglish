//
//  WrapperTenseQuestion.swift
//  AppEnglish
//
//  Created by MacBook Pro on 5/18/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI

struct WrapperTenseQuestion: View {
    @Binding var platforms : [String]
     @Binding var answer : [String]
    var body: some View {
        GeometryReader { geometry in
            self.generateContent(in: geometry)
        }
    }

    private func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero

        return ZStack(alignment: .topLeading) {
            ForEach(self.platforms, id: \.self) { platform in
                self.item(for: platform)
                    .padding([.horizontal, .vertical], 4)
                    .alignmentGuide(.leading, computeValue: { d in
                        if (abs(width - d.width) > g.size.width)
                        {
                            width = 0
                            height -= d.height
                        }
                        let result = width
                        if platform == self.platforms.last! {
                            width = 0 //last item
                        } else {
                            width -= d.width
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: {d in
                        let result = height
                        if platform == self.platforms.last! {
                            height = 0 // last item
                        }
                        return result
                    })
            }
        }
    }

    func item(for text: String) -> some View {
        Text(text)
            .padding(.all, 5)
             .font(.system(size: 25, weight: .bold, design: .serif))
            .font(.body)
            .background(Color.yellow.opacity(0.8))
            .foregroundColor(Color.black)
            .cornerRadius(5)
            .onTapGesture {
                playSound(sound: "unpick", type: "mp3")
                self.platforms = self.platforms.filter { (item) -> Bool in
                    item != text
                }
                self.answer.append(text)
            }
    }
}


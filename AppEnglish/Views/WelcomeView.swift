//
//  WelcomeView.swift
//  EnglishApp
//
//  Created by MacBook Pro on 4/24/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI

struct WelcomeView: View {
    @Binding var isActive : Bool
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 40) {
                Spacer()
                HStack {
                    Spacer()
                    Text("Ứng dụng học \nTiếng Anh")
                        .font(.system(size: 45, weight: .bold, design: .monospaced))
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.center)
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                    Spacer()
                }.padding(.top)
                Image("english")
                Text("Người bạn đồng hành trong việc nâng cao kỹ năng giao tiếp và sử dụng Tiếng Anh")
                    .font(.system(size: 20, weight: .regular, design: .rounded))
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                Spacer()
                
            }.padding()
                .frame(height: UIScreen.main.bounds.height-150)
                .background(RoundedCorners(color: .yellow, tl: 0, tr: 0, bl: 45, br: 45))
                .edgesIgnoringSafeArea(.all)
            Button(action: {
                self.isActive.toggle()
            }) {
                Text("Bắt đầu ngay !!!")
                    .font(.system(size: 20, weight: .bold, design: .monospaced))
                    .foregroundColor(Color.white)
                    .padding()
            }.padding(.horizontal)
                .background(Color.black)
                .cornerRadius(50)
                .offset(y: -72)
            Spacer()
        }
    }
}


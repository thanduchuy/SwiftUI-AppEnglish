//
//  ItemQuestions.swift
//  AppEnglish
//
//  Created by MacBook Pro on 4/30/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI

struct ItemQuestions: View {
    @Binding var listQuestion : [String]
    @Binding var selectAnswer : Int
    @Binding var disBtn : Bool
    var body: some View {
        VStack(spacing : 10) {
            HStack {
                HStack{
                    Text("1")
                        .bold()
                        .padding()
                        .background(Color.white)
                        .clipShape(Circle())
                    Spacer()
                    Text("\(self.listQuestion[0])")
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .foregroundColor(self.selectAnswer == 1 ? .white : .black)
                }.padding()
                    .background(self.selectAnswer == 1 ? Color.black :  Color.yellow)
                    .cornerRadius(45)
                    .onTapGesture {
                        self.selectAnswer = 1
                }
                .disabled(disBtn)
                Spacer()
                HStack{
                    Text("\(self.listQuestion[1])")
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .foregroundColor(self.selectAnswer == 2 ? .white : .black)
                    Spacer()
                    Text("2")
                        .bold()
                        .padding()
                        .background(Color.white)
                        .clipShape(Circle())
                    
                }.padding()
                    .background(self.selectAnswer == 2 ? Color.black : Color.yellow )
                    .cornerRadius(45)
                    .onTapGesture {
                        self.selectAnswer = 2
                }
                .disabled(disBtn)
            }
            HStack {
                HStack{
                    Text("3")
                        .bold()
                        .padding()
                        .background(Color.white)
                        .clipShape(Circle())
                    Spacer()
                    Text("\(self.listQuestion[2])")
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .foregroundColor(self.selectAnswer == 3 ? .white : .black)
                }.padding()
                    .background(self.selectAnswer == 3 ? Color.black :  Color.yellow)
                    .cornerRadius(45)
                    .onTapGesture {
                        self.selectAnswer = 3
                }
                .disabled(disBtn)
                Spacer()
                HStack{
                    Text("\(self.listQuestion[3])")
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .foregroundColor(self.selectAnswer == 4 ? .white : .black)
                    Spacer()
                    Text("4")
                        .bold()
                        .padding()
                        .background(Color.white)
                        .clipShape(Circle())
                    
                }.padding()
                    .background(self.selectAnswer == 4 ? Color.black : Color.yellow )
                    .cornerRadius(45)
                    .onTapGesture {
                        self.selectAnswer = 4
                }
                .disabled(disBtn)
            }
        }
    }
}

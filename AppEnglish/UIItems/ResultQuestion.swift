//
//  ResultQuestion.swift
//  AppEnglish
//
//  Created by MacBook Pro on 4/30/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI

struct ResultQuestion: View {
    @Binding var index : Int
    @Binding var listQuestion : [String]
    @Binding var selectQuestion : Int
    @Binding var actionSheet : Bool
    @State var right : String
    @Binding var disBtn : Bool
    @State var questionVocabs : [String]
    @State var nextQuestion : String
    @State var count : Int
    func getAnswer(nameEN:String) -> [String] {
        var result = [nameEN]
        while result.count <= 3 {
            let index = Int.random(in: 0..<questionVocabs.count)
            if !result.contains(questionVocabs[index]) {
                result.append(questionVocabs[index])
            }
        }
        return result
    }
    var body: some View {
        VStack {
            if actionSheet {
                VStack(alignment: .leading, spacing: 15) {
                
                        HStack {
                            if self.listQuestion[self.selectQuestion-1] == self.right {
                                Text("Làm tốt lắm !")
                                    .foregroundColor(Color("textright"))
                                    .font(.system(size: 25, weight: .bold, design: .monospaced))
                            } else {
                                VStack(alignment: .leading, spacing: 10) {
                                    Text("Kết quả đúng :")
                                        .font(.system(size: 25, weight: .bold, design: .monospaced))
                                    Text("\(right)")
                                        .font(.system(size: 20, weight: .bold, design: .monospaced))
                                }.foregroundColor(Color("textfail"))
                            }
                            Spacer()
                        }
                        HStack {
                            Button(action: {
                                self.index = self.index < self.count ? self.index + 1 : self.index
                                self.listQuestion = self.getAnswer(nameEN: self.nextQuestion).shuffled()
                                self.actionSheet = false
                                self.disBtn = false
                                self.selectQuestion = 0
                            }) {
                                VStack(spacing: 0) {
                                    Text("TIẾP TỤC")
                                        .font(.system(size: 25, weight: .bold, design: .monospaced))
                                        .foregroundColor(.white)
                                        .padding(.vertical,10)
                                    Divider()
                                        .frame(width: UIScreen.main.bounds.width-40, height: 7)
                                        .background(self.listQuestion[self.selectQuestion-1] == self.right ? Color("textright") : Color("textfail"))
                                    
                                }.background(self.listQuestion[self.selectQuestion-1] == self.right ? Color.green.opacity(0.8) : Color.red.opacity(0.8))
                                    .cornerRadius(20)
                            }
                        }
                }.padding(.bottom,(UIApplication.shared.windows.last?.safeAreaInsets.bottom)!+10)
                    .padding(.horizontal)
                    .padding(.top,30)
                    .background(self.listQuestion[self.selectQuestion-1] == self.right ? Color("bgright") : Color("bgfail"))
            }
            
        }
    }
}


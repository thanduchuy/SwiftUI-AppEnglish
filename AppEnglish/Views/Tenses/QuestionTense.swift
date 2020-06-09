//
//  QuestionTense.swift
//  AppEnglish
//
//  Created by MacBook Pro on 5/17/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI

struct QuestionTense: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Tense.entity(), sortDescriptors: [NSSortDescriptor(keyPath:\Tense.id, ascending: true)]) var listTense : FetchedResults<Tense>
    var topic : String = ""
    @Binding var activeTense:Bool
    @State var activeView = false
    @State var list = [Tense]()
    @State var index = 0
    @State var selectAnswerRight = 0
    @State var questionRight = [String]()
    @State var answerWrite = [String]()
    @State var answerRight = [String]()
    @State var selectAnswerWrite = [String]()
    @State var activeResult = false
    @State var result = false
    @State var isRight = true
    @State var points = [Bool]()
    func getAnswerOfRightForm() -> [String] {
        var result = [String]()
        self.questionRight.forEach { (item) in
            if item.contains("/") {
                result = item.components(separatedBy: "/")
            }
        }
        return result
    }
    func clearQuestion() {
        questionRight = [String]()
        answerWrite = [String]()
        answerRight = [String]()
        selectAnswerRight = 0
        selectAnswerWrite = [String]()
    }
    func showAnser(str : String,isRight: Bool) -> String {
        var result = ""
        self.questionRight.forEach { (item) in
            if item.contains("/") {
                result+="\(str) "
            } else {
                result+="\(item) "
            }
        }
        if isRight {
            return result
        } else {
            return str
        }
    }
    func getAnswer(items:[String],listAnswer: [String]) -> [String] {
        var result = items
        while result.count < 9 {
            let index = Int.random(in: 0..<listAnswer.count)
            if !result.contains(listAnswer[index]) {
                result.append(listAnswer[index])
            }
        }
        return result
    }
    func getQuestion() {
        if self.list[self.index].typeTense == "Right Form" {
            self.questionRight = (self.list[self.index].question ?? "").components(separatedBy: "*")
            self.answerRight = self.getAnswerOfRightForm()
        } else {
            var temp = [String]()
            questionTense.forEach { (question) in
                if question.name == self.topic {
                    temp = question.answers
                }
            }
            self.answerWrite = getAnswer(items: (self.list[self.index].answer ?? "").components(separatedBy: " "), listAnswer:temp).shuffled()
        }
    }
    func reduceQuestionRightForm() -> String {
        var result = ""
        self.questionRight.forEach { (item) in
            if item.contains("/") {
                result+=" [ ... ] "
            } else {
                result+="\(item.replacingOccurrences(of: "*", with: " ")) "
            }
        }
        return result
    }
    var body: some View {
        VStack {
            if !list.isEmpty {
                ZStack(alignment: .top)  {
                    if self.list[self.index].typeTense == "Right Form" {
                        if !answerRight.isEmpty {
                            VStack {
                                VStack {
                                    VStack {
                                        Text("\(((self.index+1) * 100) / self.list.count) %")
                                            .font(.system(size: 35, weight: .regular, design: .rounded))
                                    }
                                    HStack(spacing: 10) {
                                        Spacer()
                                        Button(action: {
                                            withAnimation(.interpolatingSpring(mass: 1.0,stiffness: 100.0,damping: 10,initialVelocity: 0)) {
                                                if self.selectAnswerRight == 1 {
                                                    self.selectAnswerRight = 0
                                                } else {
                                                    self.selectAnswerRight = 1
                                                }
                                            }
                                        }) {
                                            Image(systemName: "arrow.left")
                                                .foregroundColor(Color.yellow)
                                                .padding()
                                                .background(Color.black)
                                                .clipShape(Circle())
                                        }
                                        Text("\(self.answerRight[self.selectAnswerRight])")
                                            .foregroundColor(.black)
                                            .font(.system(size: 50, weight: .bold, design: .monospaced))
                                            .multilineTextAlignment(.center)
                                            .lineLimit(nil)
                                            .fixedSize(horizontal: false, vertical: true)
                                        
                                        Button(action: {
                                            withAnimation(.interpolatingSpring(mass: 1.0,stiffness: 100.0,damping: 10,initialVelocity: 0)) {
                                                if self.selectAnswerRight == 1 {
                                                    self.selectAnswerRight = 0
                                                } else {
                                                    self.selectAnswerRight = 1
                                                }
                                            }
                                        }) {
                                            Image(systemName: "arrow.right")
                                                .foregroundColor(Color.yellow)
                                                .padding()
                                                .background(Color.black)
                                                .clipShape(Circle())
                                        }
                                        
                                        Spacer()
                                    }
                                    .offset(y: 35)
                                }.frame(height: 150)
                                    .padding(.top,(UIApplication.shared.windows.last?.safeAreaInsets.top)!+120)
                                    .background(RoundedCorners(color: Color("bgTenses"), tl: 0, tr: 0, bl: 250, br: 250))
                                    .edgesIgnoringSafeArea(.all)
                                VStack(spacing: 40) {
                                    Text("Chọn dạng đúng của từ :")
                                        .font(.system(size: 25, weight: .bold, design: .default))
                                        .foregroundColor(.yellow)
                                    Text("\(reduceQuestionRightForm())")
                                        .font(.system(size: 40, weight: .bold, design: .monospaced))
                                        .foregroundColor(Color.black)
                                        .multilineTextAlignment(.center)
                                        .lineLimit(nil)
                                        .fixedSize(horizontal: false, vertical: true)
                                    VStack {
                                        Text("Câu này có nghĩa là :")
                                            .font(.system(size: 20, weight: .bold, design: Font.Design.serif))
                                            .foregroundColor(.yellow)
                                        Text("\(self.list[self.index].translate ?? "")")
                                            .font(.system(size: 30, weight: .bold, design: .default))
                                            .multilineTextAlignment(.center)
                                            .lineLimit(nil)
                                            .fixedSize(horizontal: false, vertical: true)
                                    }
                                    Button(action: {
                                        self.result = self.answerRight[self.selectAnswerRight].contains(self.list[self.index].answer ?? "")
                                        if self.result {
                                            playSound(sound: "win", type: "mp3")
                                        } else {
                                            playSound(sound: "lose", type: "mp3")
                                        }
                                        self.points.append(self.result)
                                        self.isRight = true
                                        withAnimation(.interpolatingSpring(mass: 1.0,stiffness: 100.0,damping: 10,initialVelocity: 0)) {
                                            self.activeResult = true
                                        }
                                    }) {
                                        VStack {
                                            Text("Kiểm tra câu trả lời")
                                                .foregroundColor(.yellow)
                                                .font(.system(size: 20, weight: .bold, design: .monospaced))
                                            Divider()
                                                .frame(width: UIScreen.main.bounds.width-150, height: 7)
                                                .background(Color.yellow)
                                        }
                                    }
                                }
                                
                                Spacer()
                            }
                        }
                    } else {
                        VStack(spacing: 30) {
                            VStack {
                                Text("Tiến độ hiện tại")
                                    .font(.system(size: 20, weight: .regular, design: .rounded))
                                Text("\(((self.index+1) * 100) / self.list.count) %")
                                    .font(.system(size: 35, weight: .regular, design: .rounded))
                            }
                            HStack {
                                Spacer()
                                Text("Viết lại thành câu hoàn chỉnh.")
                                    .font(.system(size: 35, weight: .bold, design: .rounded))
                                Spacer()
                            }
                            VStack(spacing: 20) {
                                Text("\(self.list[self.index].question ?? "")")
                                    .font(.system(size: 25, weight: .bold, design: .monospaced))
                                    .multilineTextAlignment(.center)
                                    .lineLimit(nil)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .padding()
                                Divider()
                                    .frame(width: UIScreen.main.bounds.width-100, height: 7)
                                    .foregroundColor(Color.yellow)
                                    .background(Color.yellow)
                            }.frame(width: UIScreen.main.bounds.width-100)
                                .background(Color.white)
                                .cornerRadius(15)
                            WrapperTenseQuestion(platforms: self.$selectAnswerWrite,answer: self.$answerWrite).frame(height: 150)
                            VStack(spacing: 10) {
                                ForEach(splitAnserWrite(arr: self.answerWrite)) { item in
                                    HStack {
                                        ForEach(item.row , id:\.self ) { element in
                                            Text("\(element)")
                                                .font(.title)
                                                .padding()
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 10)
                                                        .stroke(Color.black, lineWidth: 5)
                                            ).background(Color.white)
                                                .onTapGesture {
                                                    playSound(sound: "pick", type: "mp3")
                                                    self.selectAnswerWrite.append(element)
                                                    self.answerWrite = self.answerWrite.filter { (item) -> Bool in
                                                        return item != element
                                                    }
                                            }
                                        }
                                    }
                                }
                            }
                            if self.selectAnswerWrite.count >  (self.list[self.index].answer ?? "").components(separatedBy: " ").count - 3 {
                                Button(action: {
                                    self.result = self.list[self.index].answer == self.selectAnswerWrite.joined(separator: " ").trimmingCharacters(in: .whitespacesAndNewlines)
                                    if self.result {
                                        playSound(sound: "win", type: "mp3")
                                    } else {
                                        playSound(sound: "lose", type: "mp3")
                                    }
                                    self.points.append(self.result)
                                    self.isRight = false
                                    self.activeResult = true
                                }) {
                                    VStack {
                                        Text("Kiểm tra câu trả lời")
                                            .foregroundColor(.yellow)
                                            .font(.system(size: 20, weight: .bold, design: .monospaced))
                                        Divider()
                                            .frame(width: UIScreen.main.bounds.width-150, height: 7)
                                            .background(Color.yellow)
                                    }
                                }
                            }
                            Spacer()
                        }.padding(.top,(UIApplication.shared.windows.last?.safeAreaInsets.top)!+100)
                            .background(LinearGradient(gradient: Gradient(colors: [.yellow, .white, .black]), startPoint: .top, endPoint: .bottom))
                            .edgesIgnoringSafeArea(.all)
                    }
                    if self.activeResult {
                        VStack {
                            HStack {
                                VStack(alignment : .leading , spacing: 20)  {
                                    Text(self.result ? "Chúc mừng bạn":"Đáng tiếc thật")
                                    Text("Đáp Án Đúng là: ")
                                    Text("\(self.showAnser(str: self.list[self.index].answer ?? "",isRight: self.isRight))")
                                        .lineLimit(nil)
                                        .fixedSize(horizontal: false, vertical: true)
                                    
                                    NavigationLink(destination: ViewResult(activeVocab: self.$activeTense,point : self.$points ,nameTopic: self.topic),isActive: self.$activeView) {
                                        Button(action: {
                                            self.clearQuestion()
                                            if self.index+1 == self.list.count {
                                                self.activeView = true
                                            } else {
                                                self.index += 1
                                                self.getQuestion()
                                                self.result = false
                                                self.isRight = false
                                                self.activeResult = false
                                            }
                                        }) {
                                            Text("Câu hỏi tiếp theo")
                                                .padding()
                                                .foregroundColor(Color.black)
                                                .background(Color.yellow)
                                                .cornerRadius(50)
                                        }
                                    }
                                }
                                .padding(.horizontal)
                                Spacer()
                            }
                            Spacer()
                        }.frame(width : UIScreen.main.bounds.width,height: 220)
                            .padding(.top,(UIApplication.shared.windows.last?.safeAreaInsets.top)!+130)
                            .foregroundColor(.yellow)
                            .font(.system(size: 18, weight: .bold, design: .monospaced))
                            .background(Color.black)
                            .animation(.easeIn(duration: 1))
                            .edgesIgnoringSafeArea(.top)
                    }
                }
            }
        }.background(Color.black.opacity(0.01))
            .onAppear {
                playSound(sound: "go", type: "mp3")
                self.list = self.listTense.filter({ (Tense) -> Bool in
                    return Tense.category == self.topic
                }).shuffled()
                self.getQuestion()
        }
    }
}

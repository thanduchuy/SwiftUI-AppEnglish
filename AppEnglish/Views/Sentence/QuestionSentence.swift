//
//  QuestionSentence.swift
//  AppEnglish
//
//  Created by MacBook Pro on 5/3/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI
import AVFoundation
import Speech
struct QuestionSentence: View {
    @EnvironmentObject var swiftUISpeech:SwiftUISpeech
    @Binding var activeQuestion : Bool
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Entity.entity(), sortDescriptors: [NSSortDescriptor(keyPath:\Entity.id, ascending: true)]) var listSente : FetchedResults<Entity>
    @State var active : Bool = false
    @State var selectAnswer = 100
    @State var topic : String
    @State var listSentence = [Entity]()
    @State var index = 0
    @State var listAnswer = [String]()
    @State var activeResult = false
    @State var activeView = false
    @State var points = [Bool]()
    func filterSentence() -> [Entity] {
        return listSente.filter { (vocab) -> Bool in
            return vocab.category == topic
        }.shuffled()
    }
    func randomAnswer(arr : [String]) -> [String] {
        var result  = [listSentence[index].question ?? ""]
        while result.count <= 3 {
            let index = Int.random(in: 0..<arr.count)
            if !result.contains(arr[index]) {
                result.append(arr[index])
            }
        }
        return result.shuffled()
    }
    func levDis(_ l1: [String], _ l2: [String]) -> Int {
        var result : Double = 0
        for (index,_) in l1.enumerated() {
            if removeSpecialChar(text: l1[index]).lowercased().contains((index > l2.count - 1 ? "" : removeSpecialChar(text: l2[index]).lowercased())) {
                result += 1
            }
        }
        result = Double(result)/Double(l1.count)
        return Int(result * 100)
    }
    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                if self.active {
                    if index % 2 == 0 {
                        VStack(spacing : 20) {
                            Spacer()
                            VStack(spacing : 10) {
                                HStack(alignment:.lastTextBaseline,spacing: 0) {
                                    Text("\(self.index+1)")
                                        .font(.system(size: 50, weight: .bold, design: .monospaced))
                                    Text("/\(self.listSentence.count)")
                                        .font(.system(size: 35, weight: .bold, design: .monospaced))
                                }.foregroundColor(.yellow)
                                Divider()
                                    .frame(width: UIScreen.main.bounds.width-200, height: 7)
                                    .background(Color.yellow)
                            }
                            HStack(spacing: 50) {
                                Button(action: {
                                    let utterance = AVSpeechUtterance(string: self.listSentence[self.index].question ?? "")
                                    utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
                                    utterance.rate = 0.5
                                    
                                    let synthesizer = AVSpeechSynthesizer()
                                    synthesizer.speak(utterance)
                                }) {
                                    Image(systemName: "speaker.3")
                                        .frame(width: 80, height: 80)
                                        .foregroundColor(.black)
                                }.padding(5)
                                    .background(Color.yellow)
                                    .clipShape(Circle())
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 50)
                                            .stroke(Color.black, lineWidth: 5)
                                )
                                Button(action: {
                                    let utterance = AVSpeechUtterance(string: self.listSentence[self.index].question ?? "")
                                    utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
                                    utterance.rate = 0.3
                                    
                                    let synthesizer = AVSpeechSynthesizer()
                                    synthesizer.speak(utterance)
                                }) {
                                    Image(systemName: "speaker.1")
                                        .frame(width: 70, height: 70)
                                        .foregroundColor(.black)
                                }.padding(2)
                                    .background(Color.yellow)
                                    .clipShape(Circle())
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 50)
                                            .stroke(Color.black, lineWidth: 5)
                                )
                            }
                            Spacer()
                            VStack(spacing: 20) {
                                ForEach(0..<self.listAnswer.count , id: \.self) { item in
                                    ItemSentence(selectQuestion: self.$selectAnswer, index: Binding.constant(item), text: Binding.constant(self.listAnswer[item]))
                                }
                                if self.index+1 == self.listSente.count {
                                    NavigationLink(destination: ViewResult(activeVocab: self.$activeQuestion,point : self.$points ,nameTopic: self.topic),isActive: self.$activeView) {
                                        Button(action: {
                                            self.points.append(self.listSentence[self.index].question ?? "" == self.listAnswer[self.selectAnswer])
                                            self.activeView.toggle()
                                        }) {
                                            Text("Kiểm tra")
                                                .fontWeight(.bold)
                                                .font(.title)
                                                .foregroundColor(self.selectAnswer != 100 ? .yellow : .black)
                                                .padding()
                                                .padding(.horizontal)
                                                .overlay(
                                                    Capsule(style: .continuous)
                                                        .stroke(self.selectAnswer != 100 ? Color.yellow : Color.black, style: StrokeStyle(lineWidth: 5, dash: [10]))
                                            )
                                        }
                                    }
                                }
                                else {
                                    Button(action: {
                                        if self.listSentence[self.index].question ?? "" == self.listAnswer[self.selectAnswer] {
                                            playSound(sound: "win", type: "mp3")
                                        } else {
                                            playSound(sound: "lose", type: "mp3")
                                        }
                                        self.activeResult = true
                                    }) {
                                        Text("Kiểm tra")
                                            .fontWeight(.bold)
                                            .font(.title)
                                            .foregroundColor(self.selectAnswer != 100 ? .yellow : .black)
                                            .padding()
                                            .padding(.horizontal)
                                            .overlay(
                                                Capsule(style: .continuous)
                                                    .stroke(self.selectAnswer != 100 ? Color.yellow : Color.black, style: StrokeStyle(lineWidth: 5, dash: [10]))
                                        )
                                    }.padding(.top)
                                        .disabled(self.selectAnswer == 100)
                                }
                            }
                        }
                    } else {
                        VStack(spacing: 20) {
                            VStack(spacing : 10) {
                                HStack(alignment:.lastTextBaseline,spacing: 0) {
                                    Text("\(self.index+1)")
                                        .font(.system(size: 40, weight: .bold, design: .monospaced))
                                    Text("/\(self.listSentence.count)")
                                        .font(.system(size: 30, weight: .bold, design: .monospaced))
                                }.foregroundColor(.yellow)
                                Divider()
                                    .frame(width: UIScreen.main.bounds.width-200, height: 7)
                                    .background(Color.yellow)
                                Text("Hãy đọc đoạn hội thoại sau")
                                    .font(.system(size: 20, weight: .regular, design: .rounded))
                                    .foregroundColor(Color.yellow)
                                    .multilineTextAlignment(.center)
                                    .lineLimit(nil)
                                    .fixedSize(horizontal: false, vertical: true)
                            }.padding(.bottom)
                            TestWrappedLayout(platforms: (self.listSentence[self.index].question?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "").components(separatedBy: " "),checkVoice: Binding.constant(swiftUISpeech.outputText.components(separatedBy: " ")))
                                .padding(.top)
                            VStack{
                                Text("\(swiftUISpeech.outputText)")
                                    .font(.title)
                                    .bold()
                            }.frame(width: 300,height: 400)
                            
                            VStack {
                                swiftUISpeech.getButton()
                                Spacer()
                            }
                            VStack {
                                if self.levDis((self.listSentence[self.index].question?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "").components(separatedBy: " "),swiftUISpeech.outputText.components(separatedBy: " ")) > 50 {
                                    NavigationLink(destination: ViewResult(activeVocab: self.$activeQuestion,point : self.$points ,nameTopic: self.topic),isActive: self.$activeView) {
                                        Button(action: {
                                            if self.index+1 < self.listSentence.count {
                                                self.points.append(true)
                                                self.index += 1
                                                self.selectAnswer = 100
                                                questionSentence.forEach { (question) in
                                                    if question.name == self.topic {
                                                        self.listAnswer = self.randomAnswer(arr: question.answers)
                                                    }
                                                }
                                                self.swiftUISpeech.outputText = ""
                                                playSound(sound: "win", type: "mp3")
                                                self.activeResult = false
                                            } else {
                                                self.points.append(true)
                                                self.activeView.toggle()
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
                            }
                        }
                    }
                } else {
                    VStack {
                        Text("Loading...").bold()
                        ActivityIndicator(isAnimating: .constant(true), style: .large)
                    }
                    .frame(width: UIScreen.main.bounds.width / 2,
                           height: UIScreen.main.bounds.height / 5)
                        .background(Color.yellow.opacity(0.8))
                        .foregroundColor(Color.primary)
                        .cornerRadius(20)
                }
            }
            if self.activeResult && self.index+1 < self.listSentence.count {
                VStack {
                    Spacer()
                    HStack {
                        VStack(alignment : .leading , spacing: 10) {
                            Text(self.listSentence[self.index].question ?? "" == self.listAnswer[self.selectAnswer] ? "Chúc mừng bạn":"Đáng tiếc thật")
                            if self.listSentence[self.index].question ?? "" != self.listAnswer[self.selectAnswer] {
                                Text("Đáp Án Đúng là: ")
                                Text("\(self.listSentence[self.index].question ?? "")")
                            }
                            Text("Câu này có nghĩa là: ")
                            Text("\(self.listSentence[self.index].answer ?? "")")
                            Button(action: {
                                self.points.append(self.listSentence[self.index].question ?? "" == self.listAnswer[self.selectAnswer])
                                self.index += 1
                                self.selectAnswer = 100
                                questionSentence.forEach { (question) in
                                    if question.name == self.topic {
                                        self.listAnswer = self.randomAnswer(arr: question.answers)
                                    }
                                }
                                self.activeResult = false
                            }) {
                                Text("Câu hỏi tiếp theo")
                                    .padding()
                                    .foregroundColor(Color.black)
                                    .background(Color.yellow)
                                    .cornerRadius(50)
                            }
                        }
                        .padding(.leading)
                        Spacer()
                    }
                    Spacer()
                }.frame(width : UIScreen.main.bounds.width,height: 280)
                    .padding(.top,(UIApplication.shared.windows.last?.safeAreaInsets.top)!+60)
                    .foregroundColor(.yellow)
                    .font(.system(size: 18, weight: .bold, design: .monospaced))
                    .background(Color.black)
                    .animation(.easeIn(duration: 1))
                    .edgesIgnoringSafeArea(.top)
            }
        }.onAppear {
            playSound(sound: "go", type: "mp3")
            self.listSentence = self.filterSentence()
            questionSentence.forEach { (question) in
                if question.name == self.topic {
                    self.listAnswer = self.randomAnswer(arr: question.answers)
                    withAnimation(Animation.easeIn.delay(1)) {
                        self.active.toggle()
                    }
                }
            }
        }
    }
}

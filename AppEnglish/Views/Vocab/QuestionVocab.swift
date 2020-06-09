//
//  QuestionVocab.swift
//  AppEnglish
//
//  Created by MacBook Pro on 4/27/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI
import AVFoundation


struct QuestionVocab: View {
    @Binding var activeVocab: Bool
    @State var topic : String
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Vocab.entity(), sortDescriptors: [NSSortDescriptor(keyPath:\Vocab.id, ascending: true)]) var list : FetchedResults<Vocab>
    @FetchRequest(entity: Note.entity(), sortDescriptors: [NSSortDescriptor(keyPath:\Note.id, ascending: true)]) var listNote : FetchedResults<Note>
    @State var index = 0
    @State var image : Data = .init(count:0)
    @State var listAnswer = [String]()
    @State var listQuestion = [String]()
    @State var listVocab = [Vocab]()
    @State var active = false
    @State var selectAnswer = Int()
    @State var actionSheet = false
    @State var disBtn = false
    @State var point = [Bool]()
    @State var activeResult = false
    func addLastPoint(last: Bool) -> [Bool] {
        point.append(last)
        return point
    }
    func filterTopic() {
        listVocab = list.filter { (vocab) -> Bool in
            return vocab.category == topic
        }.shuffled()
    }
    func getAnswer(nameEN:String) -> [String] {
        var result = [nameEN]
        while result.count <= 3 {
            let index = Int.random(in: 0..<listAnswer.count)
            if !result.contains(listAnswer[index]) {
                result.append(listAnswer[index])
            }
        }
        return result
    }
    func checkNote(name:String) -> Bool {
        var temp = false
        listNote.forEach { (Note) in
            if Note.nameEN == name {
                temp = true
            }
        }
        return temp
    }
    func addNote(item: Vocab) {
        let new = Note(context: moc)
        new.nameEN = item.nameEN
        new.nameVN = item.nameVN
        new.category = item.category
        new.id = (self.listNote.last?.id ?? 0) + 1
        new.image = item.image
        new.spelling = item.spelling
        new.info = item.info
        do {
            try self.moc.save()
        } catch {
            print(error)
        }
    }
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                if self.active {
                    VStack(spacing: 15) {
                        HStack {
                            Image("start")
                                .resizable()
                                .frame(width: 50, height: 50)
                            Spacer()
                            Image("finish")
                                .resizable()
                                .frame(width: 50, height: 50)
                        }
                        Progress(width: Binding.constant(Float(UIScreen.main.bounds.width-60) * Float(Float(self.index+1) / Float(self.listVocab.count))))
                        Image(systemName: self.checkNote(name: self.listVocab[self.index].nameEN ?? "") ? "heart.circle.fill":"heart.circle")
                            .font(.system(size: 50))
                            .foregroundColor(Color("textfail"))
                            .onTapGesture {
                                if !self.checkNote(name: self.listVocab[self.index].nameEN ?? "") {
                                    self.addNote(item: self.listVocab[self.index])
                                }
                        }
                        Image(uiImage: UIImage(data: self.listVocab[self.index].image ?? self.image)!)
                            .renderingMode(.original)
                            .resizable()
                            .frame(height: 300)
                            .cornerRadius(10)
                            .border(Color.yellow, width: 2)
                        ItemQuestions(listQuestion: self.$listQuestion, selectAnswer: self.$selectAnswer , disBtn: self.$disBtn)
                        Spacer()
                        if self.index == self.listVocab.count - 1 {
                            NavigationLink(destination: ViewResult(activeVocab: self.$activeVocab,point : self.$point,nameTopic: self.topic),isActive: self.$activeResult) {
                                Button(action: {
                                    self.point.append(self.listVocab[self.index].nameEN == self.listQuestion[self.selectAnswer-1])
                                    self.activeResult.toggle()
                                }) {
                                    Text("Kiểm Tra")
                                        .font(.system(size: 18, weight: .bold, design: .rounded))
                                        .foregroundColor(self.selectAnswer != 0 ? .yellow : .black)
                                        .padding(.horizontal, UIScreen.main.bounds.width/3)
                                        .padding(.vertical)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 30)
                                                .stroke(self.selectAnswer != 0 ? Color.yellow : Color.black, lineWidth: 3)
                                    )
                                }
                            }
                        } else {
                            Button(action: {
                                withAnimation(Animation.easeIn(duration: 1)) {
                                    self.point.append(self.listVocab[self.index].nameEN == self.listQuestion[self.selectAnswer-1])
                                    self.actionSheet = true
                                    self.disBtn = true
                                    if self.listVocab[self.index].nameEN == self.listQuestion[self.selectAnswer-1] {
                                        playSound(sound: "win", type: "mp3")
                                    } else {
                                        playSound(sound: "lose", type: "mp3")
                                    }
                                    
                                }
                            }) {
                                Text("Kiểm Tra")
                                    .font(.system(size: 18, weight: .bold, design: .rounded))
                                    .foregroundColor(self.selectAnswer != 0 ? .yellow : .black)
                                    .padding(.horizontal, UIScreen.main.bounds.width/3)
                                    .padding(.vertical)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 30)
                                            .stroke(self.selectAnswer != 0 ? Color.yellow : Color.black, lineWidth: 3)
                                )
                            }.disabled(self.selectAnswer == 0)
                        }
                    }.padding()
                    if self.actionSheet && self.index < self.listVocab.count {
                        VStack {
                            Spacer()
                            ResultQuestion(index: self.$index,listQuestion: self.$listQuestion,selectQuestion: self.$selectAnswer ,actionSheet: self.$actionSheet, right: self.listVocab[self.index].nameEN ?? "",disBtn: self.$disBtn,questionVocabs: self.listAnswer,nextQuestion: self.listVocab[self.index+1].nameEN ?? "",count: self.list.count-1 )
                        }.edgesIgnoringSafeArea(.bottom)
                    }
                } else {
                    VStack {
                        Text("Loading...").bold()
                        ActivityIndicator(isAnimating: .constant(true), style: .large)
                    }
                    .frame(width: geometry.size.width / 2,
                           height: geometry.size.height / 5)
                        .background(Color.yellow.opacity(0.8))
                        .foregroundColor(Color.primary)
                        .cornerRadius(20)
                }
            }
        }
        .onAppear {
            playSound(sound: "go", type: "mp3")
            self.filterTopic()
            questionVocabs.forEach { (vocabs) in
                if vocabs.name == self.topic {
                    self.listAnswer = vocabs.answers
                    self.listQuestion = self.getAnswer(nameEN: self.listVocab[self.index].nameEN ?? "").shuffled()
                    withAnimation(Animation.easeOut.delay(1)) {
                        self.active.toggle()
                    }
                }
            }
        }
    }
}

//
//  MennuView.swift
//  AppEnglish
//
//  Created by MacBook Pro on 4/26/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI

struct MennuView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Note.entity(), sortDescriptors: [NSSortDescriptor(keyPath:\Note.id, ascending: true)]) var listVocab : FetchedResults<Note>
    @State var image: Data = .init(count: 0)
    @State var selectActivity : Int = 0
    @State var show = false
    @State var selectCourse = ""
    @State var activeVocab = false
    @State var activeSentence = false
    @State var activeTenses = false
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.opacity(0.1).edgesIgnoringSafeArea(.all)
                ZStack(alignment: .top) {
                    VStack(spacing: 0) {
                        Image("book")
                            .renderingMode(.original)
                            .resizable()
                            .offset(y: 55)
                    }.padding()
                        .frame(height: UIScreen.main.bounds.height-600)
                        .padding(.top, 50)
                        .background(RoundedCorners(color: .black, tl: 0, tr: 0, bl: 30, br: 30))
                        .foregroundColor(.yellow)
                        .edgesIgnoringSafeArea(.all)
                    VStack {
                        ScrollView(.horizontal, showsIndicators: false) {
                            if listVocab.count == 0 {
                                HStack(spacing: 10) {
                                    Image(systemName: "plus.circle.fill")
                                        .renderingMode(.original)
                                    Text("Hãy thêm những từ vựng để dễ ghi nhớ nào")
                                } .frame(height: 50)
                                                                       .padding(.horizontal)
                                                                       .background(Color.yellow)
                                                                   .clipShape(Capsule())
                                                                   .padding(.horizontal)
                            } else {
                                    HStack(spacing: 20) {
                                        ForEach(listVocab,id: \.self) { item in
                                            ZStack {
                                                Image(uiImage: UIImage(data: item.image ?? self.image)!)
                                                    .renderingMode(.original)
                                                    .resizable()
                                                    .frame(width: 65, height: 65)
                                                    .clipShape(Circle())
                                                Circle()
                                                    .trim(from: 0, to: 1)
                                                    .stroke(AngularGradient(gradient: .init(colors: [.yellow,.orange,.yellow]), center: .center),style: StrokeStyle(lineWidth: 4, dash: [self.selectActivity == Int(item.id) ? 7: 1]))
                                                    .frame(width: 74, height: 74)
                                                    .rotationEffect(.init(degrees: self.selectActivity == Int(item.id) ? 360:1))
                                            }.onTapGesture {
                                                withAnimation(Animation.default.speed(0.35).repeatForever(autoreverses: false)) {
                                                    self.selectActivity = Int(item.id)
                                                    self.show.toggle()
                                                }
                                                playSound(sound: "bell", type: "mp3")
                                            }
                                        }
                                    }.padding(.horizontal)
                                        .padding(.vertical, 10)
                            }
                        }
                        Spacer()
                        VStack(spacing: 20) {
                            Spacer()
                            HStack(spacing : 10) {
                                Button(action: {
                                    self.selectCourse = "tenses"
                                    audioPlayer?.stop()
                                }) {
                                    Text("Bài tập về thì")
                                        .font(.headline)
                                        .fontWeight(.regular)
                                        .padding()
                                        .frame(width: UIScreen.main.bounds.width-90)
                                        .foregroundColor(self.selectCourse == "tenses" ? Color.black : Color.yellow)
                                        .background(self.selectCourse == "tenses" ? Color.yellow : Color.black)
                                        .cornerRadius(100)
                                        .shadow(color: self.selectCourse == "tenses" ? Color.black.opacity(0.5): Color.yellow.opacity(0.5), radius: 10, x: 0, y: 5)
                                }
                                if self.selectCourse == "tenses" {
                                    NavigationLink(destination: CourseTenses(activeTenses: self.$activeTenses),isActive: self.$activeTenses) {
                                        Image("rocket")
                                            .renderingMode(.original)
                                            .resizable()
                                            .frame(width: 40, height: 40)
                                    }
                                }
                            }
                            HStack(spacing : 10) {
                                Button(action: {
                                    self.selectCourse = "vocab"
                                    audioPlayer?.stop()
                                }) {
                                    Text("Bài tập về từ vựng")
                                        .font(.headline)
                                        .fontWeight(.regular)
                                        .padding()
                                        .frame(width: UIScreen.main.bounds.width-90)
                                        .foregroundColor(self.selectCourse == "vocab" ? Color.black : Color.yellow)
                                        .background(self.selectCourse == "vocab" ? Color.yellow : Color.black)
                                        .cornerRadius(100)
                                        .shadow(color: self.selectCourse == "vocab" ? Color.black.opacity(0.5): Color.yellow.opacity(0.5), radius: 10, x: 0, y: 5)
                                }
                                if self.selectCourse == "vocab" {
                                    NavigationLink(destination: CourseVocab(activeVocab: self.$activeVocab),isActive: self.$activeVocab) {
                                        Image("rocket")
                                            .renderingMode(.original)
                                            .resizable()
                                            .frame(width: 40, height: 40)
                                    }
                                }
                            }
                            HStack(spacing : 10) {
                                Button(action: {
                                    self.selectCourse = "sentence"
                                    audioPlayer?.stop()
                                }) {
                                    Text("Bài tập về các câu thông dụng")
                                        .font(.headline)
                                        .fontWeight(.regular)
                                        .padding()
                                        .frame(width: UIScreen.main.bounds.width-90)
                                        .foregroundColor(self.selectCourse == "sentence" ? Color.black : Color.yellow)
                                        .background(self.selectCourse == "sentence" ? Color.yellow : Color.black)
                                        .cornerRadius(100)
                                        .shadow(color: self.selectCourse == "sentence" ? Color.black.opacity(0.5): Color.yellow.opacity(0.5), radius: 10, x: 0, y: 5)
                                }
                                if self.selectCourse == "sentence" {
                                    NavigationLink(destination: CourseSentence(activeSentence: self.$activeSentence),isActive: self.$activeSentence) {
                                        Image("rocket")
                                            .renderingMode(.original)
                                            .resizable()
                                            .frame(width: 40, height: 40)
                                    }
                                }
                            }
                            Image("abc")
                                .resizable()
                                .frame(height: 200)
                                .edgesIgnoringSafeArea(.all)
                                .offset(y: 50)
                                .background(RoundedCorners(color: .black, tl: 20, tr: 20, bl: 0, br: 0))
                        }
                        
                    }
                }
                if self.show {
                    ZStack(alignment: .topTrailing) {
                        Color.yellow.edgesIgnoringSafeArea(.all)
                        ZStack(alignment: .topLeading) {
                            GeometryReader { _ in
                                VStack(spacing: 20) {
                                    Text("\(self.listVocab[self.selectActivity-1].nameEN!) - \(self.listVocab[self.selectActivity-1].spelling!)")
                                        .font(.largeTitle)
                                        .fontWeight(.heavy)
                                    Text("\(self.listVocab[self.selectActivity-1].nameVN!)")
                                        .font(.title)
                                    Text("\(self.listVocab[self.selectActivity-1].info!)")
                                        .font(.caption)
                                        .fontWeight(.bold)
                                        .multilineTextAlignment(.center)
                                        .lineLimit(nil)
                                        .fixedSize(horizontal: false, vertical: true)
                                    Image(uiImage: UIImage(data: self.listVocab[self.selectActivity-1].image ?? self.image)!)
                                        .resizable()
                                        .frame(height: 300)
                                        .cornerRadius(10)
                                    Image(systemName: "trash.circle.fill")
                                     .font(.system(size: 50))
                                    .foregroundColor(Color("textfail"))
                                    .onTapGesture {
                                        self.show.toggle()
                                        self.moc.delete(self.listVocab[self.selectActivity-1])
                                        do {
                                                   try self.moc.save()
                                               } catch {
                                                   print(error)
                                        }
                                    }
                                }.padding()
                                    .foregroundColor(.black)
                            }
                            Loader(show: self.$show)
                        }
                    }.transition(.move(edge: .trailing))
                        .onTapGesture {
                            withAnimation(.default) {
                                self.show = false
                            }
                    }
                }
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .onAppear {
                playSound(sound: "background", type: "mp3")
            }
        }
    }
}

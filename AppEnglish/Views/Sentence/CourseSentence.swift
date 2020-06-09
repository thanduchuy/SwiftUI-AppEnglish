//
//  CourseSentence.swift
//  AppEnglish
//
//  Created by MacBook Pro on 5/2/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI

struct CourseSentence: View {
    @Binding var activeSentence : Bool
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Topic.entity(), sortDescriptors: [NSSortDescriptor(keyPath:\Topic.idTopic, ascending: true)]) var listTopic : FetchedResults<Topic>
    @State var activeQuestion = false
    @State var image : Data = .init(count :0)
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                HStack {
                    HStack {
                        Image(systemName: "arrowshape.turn.up.left.fill")
                            .resizable()
                            .frame(width: 25, height: 25)
                        Text("Go Back")
                            .fontWeight(.bold)
                    }.foregroundColor(.black)
                        .padding()
                        .background(Color.yellow)
                        .cornerRadius(100)
                        .onTapGesture {
                            self.activeSentence = false
                    }
                    Spacer()
                }
                VStack(spacing: 30) {
                    ForEach(self.listTopic.filter({ (Topic) -> Bool in
                        Topic.categoryTopic == "Sentence"
                    }),id: \.self) { item in
                        NavigationLink(destination: QuestionSentence(activeQuestion: self.$activeSentence,topic:item.nameTopic ?? "")) {
                            HStack {
                                if Int(truncatingIfNeeded: item.idTopic)%2 == 0 {
                                    
                                    HStack(spacing:0) {
                                        Image(uiImage: UIImage(data: item.imageTopic ?? self.image)!)
                                            .renderingMode(.original)
                                            .resizable()
                                            .frame(width: 50, height:50)
                                            .padding()
                                            .background(item.pointTopic > 50 ? Color.green.opacity(0.9) : Color.yellow.opacity(0.9))
                                        Text("\(item.nameTopic ?? "")")
                                            .font(.system(size: 20, weight: .regular, design: .rounded))
                                            .foregroundColor(Color.yellow)
                                            .multilineTextAlignment(.center)
                                            .lineLimit(nil)
                                            .fixedSize(horizontal: false, vertical: true)
                                            .padding(.horizontal)
                                    }.background(Color.black.opacity(0.8))
                                        .cornerRadius(40)
                                    Spacer()
                                }
                                if Int(truncatingIfNeeded: item.idTopic)%2 != 0 {
                                    Spacer()
                                    HStack(spacing:0) {
                                        Text("\(item.nameTopic ?? "")")
                                            .font(.system(size: 20, weight: .regular, design: .rounded))
                                            .foregroundColor(Color.yellow)
                                            .multilineTextAlignment(.center)
                                            .lineLimit(nil)
                                            .fixedSize(horizontal: false, vertical: true)
                                            .padding(.horizontal)
                                        Image(uiImage: UIImage(data: item.imageTopic ?? self.image)!)
                                            .renderingMode(.original)
                                            .resizable()
                                            .frame(width: 50, height:50)
                                            .padding()
                                            .background(item.pointTopic > 50 ? Color.green.opacity(0.9) : Color.yellow.opacity(0.9))
                                    }.background(Color.black.opacity(0.8))
                                        .cornerRadius(40)
                                }
                            }
                        }
                    }
                }
            }.padding()
                .padding(.top)
        }.navigationBarBackButtonHidden(true)
            .navigationBarTitle("")
            .navigationBarHidden(true)
    }
}

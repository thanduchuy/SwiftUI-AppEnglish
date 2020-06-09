//
//  CourseVocab.swift
//  AppEnglish
//
//  Created by MacBook Pro on 4/27/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI

struct CourseVocab: View {
    @Binding var activeVocab: Bool
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Topic.entity(), sortDescriptors: [NSSortDescriptor(keyPath:\Topic.idTopic, ascending: true)]) var listTopic : FetchedResults<Topic>
    @State var image : Data = .init(count :0)
    @State var spin = false
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
                            self.activeVocab = false
                    }
                    Spacer()
                }
                
                VStack {
                    ForEach(splitTopic(array: listTopic)) { item in
                        HStack(spacing: 40) {
                            Spacer()
                            ForEach(item.row , id:\.self ) { element in
                                NavigationLink(destination: QuestionVocab(activeVocab: self.$activeVocab,topic: element.nameTopic ?? "")) {
                                    HStack {
                                        VStack(spacing: 0) {
                                            Image(uiImage: UIImage(data: element.imageTopic ?? self.image)!)
                                                .renderingMode(.original)
                                                .resizable()
                                                .frame(width: 75, height:75)
                                            HStack {
                                                Text("\(element.nameTopic ?? "")")
                                            }
                                        }.foregroundColor(.black)
                                            .padding()
                                            .background(Color.white)
                                            .clipShape(Circle())
                                            .shadow(color: element.pointTopic == 0 ? Color.black.opacity(0.8) : element.pointTopic > 60 ? Color.green : Color.red, radius: 10, x: 0, y: 5)
                                    }
                                }
                                
                            }
                            Spacer()
                        }
                    }
                }
                Spacer()
            }
            .padding()
            .animation(.easeOut(duration: 2))
        }.navigationBarBackButtonHidden(true)
            .navigationBarTitle("")
            .navigationBarHidden(true)
    }
}


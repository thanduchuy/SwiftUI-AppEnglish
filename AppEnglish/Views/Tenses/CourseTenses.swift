//
//  CourseTenses.swift
//  AppEnglish
//
//  Created by MacBook Pro on 5/10/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI

struct CourseTenses: View {
    @Binding var activeTenses : Bool
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Topic.entity(), sortDescriptors: [NSSortDescriptor(keyPath:\Topic.idTopic, ascending: true)]) var listTopic : FetchedResults<Topic>
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
                            self.activeTenses = false
                    }
                    Spacer()
                }
                VStack(spacing : 20) {
                    ForEach(splitTwice(arr: self.listTopic.filter({ (Topic) -> Bool in
                        Topic.categoryTopic == "Tenses"
                    }))) { item in
                        
                        HStack {
                            ForEach(item.row,id: \.self) { element in
                                NavigationLink(destination: TensesReview(activeReview: self.$activeTenses,topic: element.nameTopic ?? "")) {
                                    VStack {
                                        Text("\(element.nameTopic ?? "")")
                                            .font(.system(size: 19, weight: .bold, design: .monospaced))
                                            .foregroundColor(Color.yellow)
                                            .multilineTextAlignment(.center)
                                            .lineLimit(nil)
                                            .fixedSize(horizontal: false, vertical: true)
                                            .padding(.top)
                                        Spacer()
                                        Image(uiImage: UIImage(data: element.imageTopic ?? self.image)!)
                                            .renderingMode(.original)
                                            .resizable()
                                            .frame(height:75)
                                            .padding()
                                            .background(element.pointTopic > 50 ? Color("textright"):Color.yellow.opacity(0.9))
                                    }.frame(height: UIScreen.main.bounds.width / 2)
                                        .foregroundColor(Color.yellow)
                                        .background(Color.black.opacity(0.9))
                                        .cornerRadius(10)
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


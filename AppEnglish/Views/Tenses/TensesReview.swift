//
//  TensesReview.swift
//  AppEnglish
//
//  Created by MacBook Pro on 5/13/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI

struct TensesReview: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: TheoryTense.entity(), sortDescriptors: [NSSortDescriptor(keyPath:\TheoryTense.id, ascending: true)]) var listInfo : FetchedResults<TheoryTense>
    @Binding var activeReview : Bool
    @State var topic : String
    @State var menu = 0
    @State var review : TheoryTense?
    @State var dataRecipe = [String]()
    @State var dataUse = [String]()
    @State var dataSignal = ""
        
    var body: some View {
        ZStack {
            Color("bgTenses")
                .edgesIgnoringSafeArea(.all)
            VStack {
                ZStack {
                    HStack {
                        Button(action: {
                            self.activeReview.toggle()
                        }) {
                            Image(systemName: "arrowshape.turn.up.left.2.fill")
                                .renderingMode(.original)
                            .padding()
                        }.background(Color.white)
                        .cornerRadius(10)
                            .padding(.trailing)
                        Text("\(self.topic)")
                            .font(.system(size: 20))
                                                Spacer()
                        NavigationLink(destination: QuestionTense(topic: self.topic,activeTense: self.$activeReview)) {
                            Image(systemName: "forward.end.fill")
                            .renderingMode(.original)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                             .padding(.trailing)
                        }
                    }
                    .padding(.horizontal)
                }
                HStack(spacing: 15) {
                    Button(action: {
                        self.menu = 0
                    }) {
                        Text("Công Thức")
                            .foregroundColor(self.menu == 0 ? .white : .black)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 20)
                    }
                    .background(self.menu == 0 ? Color.black : Color.white)
                    .clipShape(Capsule())
                    Button(action: {
                        self.menu = 1
                    }) {
                        Text("Cách Dùng")
                            .foregroundColor(self.menu == 1 ? .white : .black)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 20)
                    }
                    .background(self.menu == 1 ? Color.black : Color.white)
                    .clipShape(Capsule())
                    Button(action: {
                        self.menu = 2
                    }) {
                        Text("Dấu Hiệu")
                            .foregroundColor(self.menu == 2 ? .white : .black)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 20)
                    }
                    .background(self.menu == 2 ? Color.black : Color.white)
                    .clipShape(Capsule())
                }
                .padding(.top, 30)
                .disabled(true)
                GeometryReader { g in
                    Carousel(width: UIScreen.main.bounds.width, page: self.$menu, height: g.frame(in:.global).height, dataRecipe: self.$dataRecipe,dataUse: self.$dataUse,dataSignal: self.$dataSignal)
                }
            }.padding(.vertical)
        }.navigationBarBackButtonHidden(true)
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .onAppear {
                self.listInfo.forEach { (theory) in
                    if theory.name!.trimmingCharacters(in: .whitespacesAndNewlines) == self.topic.trimmingCharacters(in: .whitespacesAndNewlines) {
                        self.dataRecipe = convertArray(arr: theory.recipe ?? [NSString]())
                        self.dataUse = convertArray(arr: theory.use ?? [NSString]())
                        self.dataSignal = theory.signal ?? ""
                    }
                }
        }
    }
}

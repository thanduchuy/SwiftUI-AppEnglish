//
//  AdminSentence.swift
//  AppEnglish
//
//  Created by MacBook Pro on 5/5/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI

struct AdminSentence: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Entity.entity(), sortDescriptors: [NSSortDescriptor(keyPath:\Entity.id, ascending: true)]) var listSente : FetchedResults<Entity>
    @State var question = ""
    @State var answer = ""
    @State var category = ""
    var body: some View {
        ScrollView(.vertical, showsIndicators: true)  {
            VStack {
                ForEach(listSente.filter({ (Entity) -> Bool in
                    return Entity.category == "Phỏng vấn xin việc"
                }),id: \.self) { item in
                    VStack {
                        Text(item.question ?? "")
                    }
                }
                TextField("question", text: $question)
                TextField("answer", text: $answer)
                TextField("categoty", text: $category)
                Button(action: {
                    let newElement = Entity(context: self.moc)
                    newElement.question = self.question
                    newElement.answer = self.answer
                    newElement.category = self.category
                    do {
                        try self.moc.save()
                    } catch {
                        print(error)
                    }
                    self.question = ""
                    self.answer = ""
                }) {
                    Text("Add")
                }
            }.padding()
        }
    }
}

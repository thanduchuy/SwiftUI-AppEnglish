//
//  AdminTense.swift
//  AppEnglish
//
//  Created by MacBook Pro on 5/15/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI

struct AdminTense: View {
    @Environment(\.managedObjectContext) var moc
       @FetchRequest(entity: Tense.entity(), sortDescriptors: [NSSortDescriptor(keyPath:\Tense.id, ascending: true)]) var listTense : FetchedResults<Tense>
    @State var typeTense: String = ""
    @State var question: String = ""
    @State var translate: String = ""
    @State var answer: String = ""
    @State var category: String = ""
    func resetForm() {
        question = ""
        translate = ""
        answer = ""
    }
    func updateRightForm() {
        listTense.forEach { (Tense) in
            if Tense.typeTense == "Right Form" &&  Tense.category == "Present continuous tense" {
                moc.delete(Tense)
            }
        }
        do {
            try self.moc.save()
        } catch {
            print(error)
        }
    }
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                Text("\(listTense.count)")
                ForEach(listTense.filter({ (Tense) -> Bool in
                    return Tense.category == "Future perfect continuous tense"
                }) , id : \.self) { item in
                    Text("\(item.question ?? "")-- \(item.typeTense ?? "")")
                }
                TextField("type Tense ... ", text: self.$typeTense)
                TextField("question ... ", text: self.$question)
                TextField("translate ... ", text: self.$translate)
                TextField("answer ... ", text: self.$answer)
                TextField("category ... ", text: self.$category)
                Button(action: {
                    let new  = Tense(context: self.moc)
                    new.typeTense = self.typeTense
                    new.question = self.question
                    new.translate = self.translate
                    new.answer = self.answer
                    new.category = self.category
                    do {
                        try self.moc.save()
                    } catch {
                        print(error)
                    }
                    self.resetForm()
                }) {
                    Text("Add")
                }
                Spacer()
                Text("Updateaa").onTapGesture {
                    self.listTense.forEach { (Tense) in
                        if Tense.question?.filter({ (Character) -> Bool in
                            return Character == "/"
                        }).count ?? 0 > 2 {
                            Tense.typeTense = "Write"
                        }
                    }
                    do {
                        try self.moc.save()
                    } catch {
                        print(error)
                    }
                }
            }
        .padding()
        }
    }
}

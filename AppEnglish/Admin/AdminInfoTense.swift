//
//  AdminInfoTense.swift
//  AppEnglish
//
//  Created by MacBook Pro on 5/11/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI

struct AdminInfoTense: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: TheoryTense.entity(), sortDescriptors: [NSSortDescriptor(keyPath:\TheoryTense.id, ascending: true)]) var listInfo : FetchedResults<TheoryTense>
    @State var name: String = ""
    @State var use: String = ""
    @State var recipe: String = ""
    @State var signal: String = ""
    func resetData() {
        use = ""
        recipe = ""
        signal = ""
    }
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                ForEach(listInfo,id: \.id) { item in
                    VStack {
                            Text(item.name ?? "")
//                            ForEach(convertArray(arr: item.use ?? [NSString]()),id: \.self) { element in
//                                               Text(element)
//                            }
//                        ForEach(convertArray(arr: item.recipe ?? [NSString]()),id: \.self) { element in
//                                                                      Text(element)
//                                                   }
                    }
                }
                TextField("name", text: self.$name)
                TextField("use", text: self.$use)
                TextField("recipe", text: self.$recipe)
                TextField("signal", text: self.$signal)
                Button(action: {
                    let arrUse = self.use.components(separatedBy: "*")
                    let arrRecipe = self.recipe.components(separatedBy: "*")
                    let new = TheoryTense(context: self.moc)
                    new.id = (self.listInfo.last?.id ?? 0) + 1
                    new.name = self.name
                    new.signal = self.signal
                    new.use = arrUse as [NSString]
                    new.recipe = arrRecipe as [NSString]
                    do {
                        try self.moc.save()
                    } catch {
                        print(error)
                    }
                    self.resetData()
                }) {
                    Text("Add")
                }
            }
        }
    }
}


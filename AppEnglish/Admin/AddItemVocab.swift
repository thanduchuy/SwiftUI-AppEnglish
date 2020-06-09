//
//  AddItemVocab.swift
//  AppEnglish
//
//  Created by MacBook Pro on 4/26/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI

struct AddItemVocab: View {
     @Environment(\.managedObjectContext) var moc
     @FetchRequest(entity: Vocab.entity(), sortDescriptors: [NSSortDescriptor(keyPath:\Vocab.id, ascending: true)]) var listVocab : FetchedResults<Vocab>
     @State var image: Data = .init(count: 0)
     @State var nameEN = ""
     @State var nameVN = ""
     @State var info = ""
     @State var category = ""
     @State var selling = ""
     @State var imageData : Data = .init(count:0)
     @State var showPicker = false
     func resetForm() {
         nameEN = ""
         nameVN = ""
         info = ""
         category = ""
         imageData = .init(count:0)
         selling = ""
     }
     var body: some View {
         NavigationView {
             ScrollView(.vertical, showsIndicators: true) {
                ForEach(listVocab.filter({ (Vocab) -> Bool in
                    Vocab.category == "Furniture"
                }),id:\.self) { item in
                     VStack {
                         Text("\(item.nameEN ?? "") -- \(item.nameVN ?? "")")
                         Text("\(item.category ?? "") -- \(item.spelling ?? "")")
                         Button(action: {
                             self.moc.delete(item)
                             do {
                                 try self.moc.save()
                             } catch {
                                 print(error)
                             }
                         }) {
                             Text("remove")
                         }
                     }
                 }
                 VStack {
                     if imageData.count == 0 {
                         Image("english").resizable().frame(width: 100, height: 100).onTapGesture {
                             self.showPicker.toggle()
                         }
                     } else {
                         Image(uiImage: UIImage(data: self.imageData)!).resizable().frame(width: 100, height: 100).onTapGesture {
                             self.showPicker.toggle()
                         }
                     }
                     TextField("nameEN", text: self.$nameEN)
                     TextField("nameVN", text: self.$nameVN)
                     TextField("info", text: self.$info)
                     TextField("category", text: self.$category)
                     TextField("selling", text: self.$selling)
                     Button(action: {
                         
                         let vocab = Vocab(context: self.moc)
                         vocab.nameEN = self.nameEN
                         vocab.nameVN = self.nameVN
                         vocab.info = self.info
                         vocab.image = self.imageData
                         vocab.category = self.category
                         vocab.spelling = self.selling
                         vocab.id = (self.listVocab.last?.id ?? 0) + 1
                         do {
                             try self.moc.save()
                         } catch {
                             print(error)
                         }
                         self.resetForm()
                     }) {
                         Text("Add")
                     }
                 }.padding()
             }
         }.sheet(isPresented: self.$showPicker) {
             imagePicker(picker: self.$showPicker, imageData: self.$imageData)
         }
     }
   
}

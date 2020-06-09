//
//  AdminTopic.swift
//  AppEnglish
//
//  Created by MacBook Pro on 4/27/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI

struct AdminTopic: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Topic.entity(), sortDescriptors: [NSSortDescriptor(keyPath:\Topic.idTopic, ascending: true)]) var listVocab : FetchedResults<Topic>
    @State var image: Data = .init(count: 0)
    @State var name = ""
    @State var category = ""
    @State var imageData : Data = .init(count:0)
    @State var showPicker = false
    func resetForm() {
        name = ""
        imageData = .init(count:0)
    }
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: true) {
                ForEach(listVocab.filter { (topic) -> Bool in
                    return topic.categoryTopic != "Vocab" && topic.categoryTopic != "Sentence"
                },id:\.self) { item in
                    VStack {
                        Text("\(item.nameTopic ?? "")")
                        Text("\(item.pointTopic )")
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
                    TextField("nameEN", text: self.$name)
                    TextField("category", text: self.$category)
                    Text("Updateaa").onTapGesture {
                        self.listVocab.forEach { (Topic) in
                            if Topic.nameTopic == "Bày tỏ cảm súc" {
                                Topic.nameTopic = "Bày tỏ cảm xúc"
                            }
                        }
                        do {
                            try self.moc.save()
                        } catch {
                            print(error)
                        }
                    }
                    Button(action: {
                        
                        let topic = Topic(context: self.moc)
                        topic.nameTopic = self.name
                        topic.imageTopic = self.imageData
                        topic.categoryTopic = self.category
                        topic.idTopic = (self.listVocab.last?.idTopic ?? 0) + 1
                        topic.pointTopic = 0
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

//
//  ViewResult.swift
//  AppEnglish
//
//  Created by MacBook Pro on 5/1/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI

struct ViewResult: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Topic.entity(), sortDescriptors: [NSSortDescriptor(keyPath:\Topic.idTopic, ascending: true)]) var listTopic : FetchedResults<Topic>
    @Binding var activeVocab: Bool
    @Binding var point : [Bool]
    @State var split = [Point]()
    @State var nameTopic = ""
    
    func totalPoint() -> Float {
        return (Float(self.point.reduce(0) { (result, next) -> Int in
            return next ? result + 1 : result
        })/Float(point.count)) * Float(100)
    }
    func splitPoint(point: [Bool]) -> [Point] {
        var temp = point
        var result = [Point]()
        while temp.count > 0 {
            let newArray = Array(temp.prefix(4))
            temp = Array(temp.dropFirst(4))
            result.append(Point(id: (result.last?.id ?? 0) + 1,arr: newArray))
        }
        print(result)
        return result
    }
    var body: some View {
        VStack(spacing: 40) {
            Spacer()
            Image(self.totalPoint() > 60 ? "pass" : "fail")
                .resizable()
                .frame(width: 150, height: 150)
            Text(self.totalPoint() > 60 ?"Chúc mừng \nBạn đã vượt qua được bài kiểm tra":"Tiếc thật\nBạn đã không vượt qua bài kiểm tra")
                .font(.system(size: 25, weight: .bold, design: .monospaced))
                .foregroundColor(self.totalPoint() > 60 ? Color.green : Color.red)
                .padding(.vertical)
                .multilineTextAlignment(.center)
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
            VStack(spacing : 10) {
                ForEach(self.split) { item in
                    HStack(spacing : 15)  {
                        ForEach(item.arr , id: \.self) { el in
                            Image(systemName: "star.circle")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .foregroundColor(el ? Color("textright") : Color("textfail") )
                        }
                    }
                }
            }.padding()
                .background(Color("Color"))
                .cornerRadius(20)
            Button(action: {
                for index in 0..<self.listTopic.count {
                    if self.listTopic[index].nameTopic == self.nameTopic {
                        self.listTopic[index].pointTopic = Int64(self.totalPoint())
                    }
                }
                do {
                    try self.moc.save()
                } catch {
                    print(error)
                }
                audioPlayer?.stop()
                self.activeVocab.toggle()
            }) {
                Text("Quay Lại Trang Chủ")
                    .font(.system(size: 25, weight: .bold, design: .monospaced))
                    .foregroundColor(.white)
                    .padding(.vertical,20)
            }.frame(width: UIScreen.main.bounds.width-40)
                .background(Color.yellow)
                .cornerRadius(50)
            Spacer()
        }.padding()
            .background(LinearGradient(gradient: .init(colors: [Color.yellow,Color.black.opacity(0.7)]), startPoint: .top, endPoint: .bottom))
            .edgesIgnoringSafeArea(.all)
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .onAppear() {
                self.split = self.splitPoint(point: self.point)
                playSound(sound: "result", type: "mp3")
        }
    }
}


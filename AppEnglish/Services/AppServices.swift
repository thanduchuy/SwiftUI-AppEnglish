//
//  AppServices.swift
//  AppEnglish
//
//  Created by MacBook Pro on 4/27/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI

func splitTopic(array: FetchedResults<Topic>) -> [Type] {
    var rdm = true
    var temp = array.filter { (topic) -> Bool in
        return topic.categoryTopic == "Vocab"
    }
    var result = [Type]()
    while temp.count > 0 {
        let index = rdm || temp.count == 2 ? 2 : 1
        let newArray = Array(temp.prefix(index))
        temp = Array(temp.dropFirst(index))
        rdm.toggle()
        result.append(Type(id: (result.last?.id ?? 0)+1, row: newArray ))
    }
    return result
}
func splitTwice(arr: [Topic]) -> [Type] {
    var temp = arr
    var result = [Type]()
    if arr.count > 0 {
        while temp.count > 0 {
            let newArray = Array(temp.prefix(2))
            temp = Array(temp.dropFirst(2))
            result.append(Type(id: result.count+1, row: newArray))
        }
    }
    return result
}
func removeSpecialChar(text : String) -> String {
    return text.replacingOccurrences(of: "[^A-Za-z0-9]", with: "",options: [.regularExpression, .caseInsensitive]).lowercased()
}
func convertArray(arr: [NSString]) -> [String] {
    var result = [String]()
    arr.forEach { (item) in
        result.append(item as String)
    }
    return result
}
func splitAnserWrite(arr: [String]) -> [AnswerWrite] {
    var temp = arr
    var result = [AnswerWrite]()
    if arr.count > 0 {
        while temp.count > 0 {
            let newArray = Array(temp.prefix(3))
            temp = Array(temp.dropFirst(3))
            result.append(AnswerWrite(id: result.count+1, row: newArray))
        }
    }
    return result
}

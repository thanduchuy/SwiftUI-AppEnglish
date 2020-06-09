//
//  Tense+CoreDataProperties.swift
//  AppEnglish
//
//  Created by MacBook Pro on 5/17/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//
//

import Foundation
import CoreData


extension Tense {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tense> {
        return NSFetchRequest<Tense>(entityName: "Tense")
    }

    @NSManaged public var answer: String?
    @NSManaged public var category: String?
    @NSManaged public var id: Int64
    @NSManaged public var question: String?
    @NSManaged public var translate: String?
    @NSManaged public var typeTense: String?

}

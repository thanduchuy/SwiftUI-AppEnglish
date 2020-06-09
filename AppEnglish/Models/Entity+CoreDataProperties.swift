//
//  Entity+CoreDataProperties.swift
//  AppEnglish
//
//  Created by MacBook Pro on 5/5/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//
//

import Foundation
import CoreData


extension Entity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entity> {
        return NSFetchRequest<Entity>(entityName: "Sentence")
    }

    @NSManaged public var answer: String?
    @NSManaged public var category: String?
    @NSManaged public var id: Int64
    @NSManaged public var question: String?

}

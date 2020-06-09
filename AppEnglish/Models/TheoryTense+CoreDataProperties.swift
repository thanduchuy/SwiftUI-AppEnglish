//
//  TheoryTense+CoreDataProperties.swift
//  AppEnglish
//
//  Created by MacBook Pro on 5/11/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//
//

import Foundation
import CoreData


extension TheoryTense {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TheoryTense> {
        return NSFetchRequest<TheoryTense>(entityName: "TheoryTense")
    }

    @NSManaged public var name: String?
    @NSManaged public var use: [NSString]?
    @NSManaged public var recipe: [NSString]?
    @NSManaged public var signal: String?
    @NSManaged public var id: Int64

}

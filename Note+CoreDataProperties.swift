//
//  Note+CoreDataProperties.swift
//  AppEnglish
//
//  Created by MacBook Pro on 5/21/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var spelling: String?
    @NSManaged public var nameVN: String?
    @NSManaged public var nameEN: String?
    @NSManaged public var info: String?
    @NSManaged public var image: Data?
    @NSManaged public var id: Int64
    @NSManaged public var category: String?

}

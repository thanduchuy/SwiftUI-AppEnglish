//
//  Vocab+CoreDataProperties.swift
//  AppEnglish
//
//  Created by MacBook Pro on 5/5/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//
//

import Foundation
import CoreData


extension Vocab {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Vocab> {
        return NSFetchRequest<Vocab>(entityName: "Vocab")
    }

    @NSManaged public var category: String?
    @NSManaged public var id: Int64
    @NSManaged public var image: Data?
    @NSManaged public var info: String?
    @NSManaged public var nameEN: String?
    @NSManaged public var nameVN: String?
    @NSManaged public var spelling: String?

}

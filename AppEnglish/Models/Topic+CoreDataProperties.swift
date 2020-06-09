//
//  Topic+CoreDataProperties.swift
//  AppEnglish
//
//  Created by MacBook Pro on 5/5/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//
//

import Foundation
import CoreData


extension Topic {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Topic> {
        return NSFetchRequest<Topic>(entityName: "Topic")
    }

    @NSManaged public var categoryTopic: String?
    @NSManaged public var idTopic: Int64
    @NSManaged public var imageTopic: Data?
    @NSManaged public var nameTopic: String?
    @NSManaged public var pointTopic: Int64

}

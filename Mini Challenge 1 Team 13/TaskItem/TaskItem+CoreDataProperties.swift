//
//  TaskItem+CoreDataProperties.swift
//  Mini Challenge 1 Team 13
//
//  Created by Jonathan Valentino on 08/04/22.
//
//

import Foundation
import CoreData


extension TaskItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskItem> {
        return NSFetchRequest<TaskItem>(entityName: "TaskItem")
    }

    @NSManaged public var createdAt: Date?
    @NSManaged public var difficulty: Int16
    @NSManaged public var due: Date?
    @NSManaged public var status: String?
    @NSManaged public var task: String?

}

extension TaskItem : Identifiable {

}

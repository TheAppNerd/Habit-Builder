//
//  HabitCoreData+CoreDataProperties.swift
//  
//
//  Created by Alexander Thompson on 3/8/21.
//
//

import Foundation
import CoreData


extension HabitCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HabitCoreData> {
        return NSFetchRequest<HabitCoreData>(entityName: "HabitCoreData")
    }

    @NSManaged public var frequency: Int16
    @NSManaged public var habitColor: Data?
    @NSManaged public var habitDates: [Date]?
    @NSManaged public var habitName: String?
    @NSManaged public var years: NSSet?

}



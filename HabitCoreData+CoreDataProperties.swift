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

// MARK: Generated accessors for years
extension HabitCoreData {

    @objc(addYearsObject:)
    @NSManaged public func addToYears(_ value: Year)

    @objc(removeYearsObject:)
    @NSManaged public func removeFromYears(_ value: Year)

    @objc(addYears:)
    @NSManaged public func addToYears(_ values: NSSet)

    @objc(removeYears:)
    @NSManaged public func removeFromYears(_ values: NSSet)

}

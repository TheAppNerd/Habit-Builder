//
//  HabitData.swift
//  Habits
//
//  Created by Alexander Thompson on 29/4/21.
//

import UIKit


struct HabitArray {
    
    //no static vars for anything.
    static var array: [HabitData] = [] //turn this into coredata. remove habitarray struct entirely. 
    static var habitCreated: Bool? //replace this.
    static var startOfWeek: Date? //replace this.
}

struct HabitData {

    var habitName: String?
    var buttonColor: UIColor?
    var habitNumber: Int? //relates to celltag. replace this
    var weeklyFrequency: String?
    var colorTag: Int?
    
    //create new entities or use tranformable attributes?
    var year: [Int: [Int]] = [:]
    var chartDates: [Date] = []
    var habitDates = Set<Date>()
    
    //seperate class and user defaults for these
    var alarmBool: Bool?
    var reminderHour: Int?
    var reminderMinute: Int?
}



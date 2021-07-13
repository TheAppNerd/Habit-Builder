//
//  HabitData.swift
//  Habits
//
//  Created by Alexander Thompson on 29/4/21.
//

import UIKit


struct HabitArray {
    static var array: [HabitData] = []
    static var habitCreated: Bool?
    static var habitDates: [Set<Date>] = []
    
    static var startOfWeek: Date?
}

struct HabitData {

    var habitName: String?
    var habitNote: String?
    var buttonColor: UIColor?
    var dates = Set<Date>()
    var habitNumber: Int?
    var weeklyFrequency: String?
    var alarmBool: Bool?
    var reminderHour: Int?
    var reminderMinute: Int?
    var colorTag: Int?
    var dayBool: [Bool]?
    var year: [Int: [Int]] = [:]
    var chartDates: [Date] = []
}



//
//  HabitData.swift
//  Habits
//
//  Created by Alexander Thompson on 29/4/21.
//

import UIKit


struct HabitArray {
    static var Array: [HabitData] = []
    static var habitCreated: Bool?
    static var habitDates: [[Date]] = []
   
}

struct HabitData {
    
    var habitName: String?
    var habitNote: String?
    var streakCount: String?
    var completionCount: String?
    var buttonColor: UIColor?
    var currentDailyCount: Int?
    var progressCount: Float?
    var dates: [Date] = []

}

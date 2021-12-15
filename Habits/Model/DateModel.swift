//
//  DateModel.swift
//  Habits
//
//  Created by Alexander Thompson on 22/9/21.
//

import UIKit

class DateModel {
    
    
    static func getDayOfWeek() -> Int {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let weekDay = calendar.component(.weekday, from: today)

        return weekDay
    }
    
    static func getYear() -> Int {
        let today = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: today)
        
        return year
    }
    
    static func weeklyDateArray() -> [Date] {
        let calendar = Calendar.current
        var dateArray: [Date] = []
        guard let sunday = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date())) else { return [] }
        
        for index in 1...7 {
            guard let day = calendar.date(byAdding: .day, value: index, to: sunday) else { return [] }
            dateArray.append(day)
        }
        return dateArray
    }
    
    static func weeklyDayArray() -> [Int] {
        let calender = Calendar.current
        let dateArray = weeklyDateArray()
        var dayArray: [Int] = []
        
        for date in dateArray {
            let day = calender.component(.day, from: date)
            dayArray.append(day)
        }
        return dayArray
    }
}

//
//  UIDate + Ext.swift
//  Habits
//
//  Created by Alexander Thompson on 27/5/2022.
//

import UIKit

extension Date {
    
    ///Returns date as exact date at start of day to avoid duplicate dates.
        func startOfDay() -> Date {
        let calendarView = Calendar.current
        let startDate    = calendarView.startOfDay(for: self)
        return startDate
    }
    
    ///Returns date as day of the week diplayed as an int.
    func getDayOfWeek() -> Int {
        let calendar = Calendar.current
        let today    = calendar.startOfDay(for: self)
        let weekDay  = calendar.component(.weekday, from: today)
        
        return weekDay - 1
    }
    
    ///Returns year as an int.
    func getYear() -> Int {
        let calendar = Calendar.current
        let year     = calendar.component(.year, from: self)
        return year
    }
    
    ///Uses weeklyDateArray func to obtain day of the month from each date in the array. Eg/ 24th of the month returns 24.
    func weeklyDateArray() -> [Date] {
        let calendar = Calendar.current
        var dateArray: [Date] = []
        guard let sunday      = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return [] }
        
        for index in 0...6 {
            let value = index - 1
            guard let day     = calendar.date(byAdding: .day, value: value, to: sunday) else { return [] }
            dateArray.append(day)
        }
        return dateArray
    }
    
    
    func weeklyDayArray() -> [Int] {
        let calendar = Calendar.current
        let dateArray       = weeklyDateArray()
        var dayArray: [Int] = []
        
        for date in dateArray {
            let day         = calendar.component(.day, from: date)
            dayArray.append(day)
        }
        return dayArray
    }
    
    ///Takes the date habit was created and amount of habits completed and works out the average habits completed per week.
    func calculateAverageStreak(days daysCompleted: Int) -> String {
        
        let timeSinceCreated     = Date().timeIntervalSince(self)
        let week: Double         = 86400 * 7
        var totalWeeks           = timeSinceCreated / week
        if totalWeeks < 1 {
            totalWeeks = 1
        }
        
        let averagePerWeek       = Double(daysCompleted) / totalWeeks
        let averageString        = String(format: "%.1f", averagePerWeek)
        return averageString
    }
    
    
    func convertDateToString() -> String {
        let dateFormatter        = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        let dateString           = dateFormatter.string(from: self)
        return dateString
    }
    
    
   
}


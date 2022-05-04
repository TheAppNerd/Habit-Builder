//
//  DateModel.swift
//  Habits
//
//  Created by Alexander Thompson on 22/9/21.
//

import UIKit

class DateModel {
    
    //MARK: - Properties
    
    // TODO: remove static to let calendar work
    //    let calendar = Calendar.current
    
    ///Returns current date as day of the week diplayed as an int.
    static func getDayOfWeek() -> Int {
        let calendar = Calendar.current
        let today    = calendar.startOfDay(for: Date())
        let weekDay  = calendar.component(.weekday, from: today)
        
        return weekDay
    }
    
    ///Returns current year as an int.
    static func getYear() -> Int {
        let today    = Date()
        let calendar = Calendar.current
        let year     = calendar.component(.year, from: today)
        return year
    }
    
    
    ///Returns an array of dates for each date of this current week.
    static func weeklyDateArray() -> [Date] {
        let calendar          = Calendar.current
        var dateArray: [Date] = []
        guard let sunday      = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date())) else { return [] }
        
        for index in 0...6 {
            guard let day     = calendar.date(byAdding: .day, value: index, to: sunday) else { return [] }
            dateArray.append(day)
        }
        return dateArray
    }
    
    ///Uses weeklyDateArray func to obtain day of the month from each date in the array. Eg/ 24th of the month returns 24.
    static func weeklyDayArray() -> [Int] {
        let calender        = Calendar.current
        let dateArray       = weeklyDateArray()
        var dayArray: [Int] = []
        
        for date in dateArray {
            let day         = calender.component(.day, from: date)
            dayArray.append(day)
        }
        return dayArray
    }
    
    ///Takes the date habit was created and amount of habits completed and works out the average habits completed per week.
    static func calculateAverageStreak(with dateCreated: Date, days daysCompleted: Int) -> String {
        let dateFormatter        = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        let date                 = dateFormatter.string(from: dateCreated)
        
        let timeSinceCreated     = Date().timeIntervalSince(dateCreated)
        let week: Double         = 86400 * 7
        var totalWeeks           = timeSinceCreated / week
        if totalWeeks < 1 {
            totalWeeks = 1
        }
        
        let averagePerWeek       = Double(daysCompleted) / totalWeeks
        let averageString        = String(format: "%.1f", averagePerWeek)
        return averageString
    }
    
    static func convertDateToString(using dateCreated: Date) -> String {
        let dateFormatter        = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        let date                 = dateFormatter.string(from: dateCreated)
        return date
    }
}

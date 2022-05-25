//
//  DateModel.swift
//  Habits
//
//  Created by Alexander Thompson on 22/9/21.
//

import UIKit

struct DateModel {
    
    //MARK: - Properties
    

    let calendar = Calendar.current
    
    ///Returns current date as day of the week diplayed as an int.
    func getDayOfWeek() -> Int {
        let today    = calendar.startOfDay(for: Date())
        let weekDay  = calendar.component(.weekday, from: today)
        
        return weekDay
    }
    
    ///Returns current year as an int.
    func getYear() -> Int {
        let today    = Date()
        let year     = calendar.component(.year, from: today)
        return year
    }
    
    
    ///Returns an array of dates for each date of this current week.
    func weeklyDateArray() -> [Date] {
        var dateArray: [Date] = []
        guard let sunday      = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date())) else { return [] }
        
        for index in 0...6 {
            let value = index - 1
            guard let day     = calendar.date(byAdding: .day, value: value, to: sunday) else { return [] }
            dateArray.append(day)
        }
        return dateArray
    }
    
    ///Uses weeklyDateArray func to obtain day of the month from each date in the array. Eg/ 24th of the month returns 24.
    func weeklyDayArray() -> [Int] {
        let dateArray       = weeklyDateArray()
        var dayArray: [Int] = []
        
        for date in dateArray {
            let day         = calendar.component(.day, from: date)
            dayArray.append(day)
        }
        return dayArray
    }
    
    ///Takes the date habit was created and amount of habits completed and works out the average habits completed per week.
    func calculateAverageStreak(with dateCreated: Date, days daysCompleted: Int) -> String {
        
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
    
    func convertDateToString(using dateCreated: Date) -> String {
        let dateFormatter        = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        let date                 = dateFormatter.string(from: dateCreated)
        return date
    }
    
    
    ///Takes time from datepicker, converts it to string and splits hours and minutes into seperate strings for use in UserNotifications.
    func convertDatePickerTime(date: Date) -> [String] {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        let dateAsString = formatter.string(from: date)
        
        let date = formatter.date(from: dateAsString)
        formatter.dateFormat = "HH:mm"
        
        let twentyFourHourDate = formatter.string(from: date!)
        let time = twentyFourHourDate.components(separatedBy: ":")
        
        return time
    }
    
}

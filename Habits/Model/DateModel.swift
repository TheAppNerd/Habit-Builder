//
//  DateModel.swift
//  Habits
//
//  Created by Alexander Thompson on 22/9/21.
//

import UIKit

class DateModel {
    
    
    var calendarView = Calendar.current

    func getDayOfWeek() -> Int {
        let myCalendar = Calendar.current
        let today = myCalendar.startOfDay(for: Date())
        let weekDay = myCalendar.component(.weekday, from: today)

        return weekDay
    }
    
    func getYear() -> Int {
        let today = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: today)
        
        return year
    }
    
    
    func configureDays() -> [Date] { //this func works out the weeks dates.
        var dateArray: [Date] = []
        var dateComponents = DateComponents()
        var dailyDateComponents = DateComponents()
        var count = 0
        
            
        switch getDayOfWeek() {
        case 1:
            dateComponents.day = 0
        case 2:
            dateComponents.day = -1
        case 3:
            dateComponents.day = -2
        case 4:
            dateComponents.day = -3
        case 5:
            dateComponents.day = -4
        case 6:
            dateComponents.day = -5
        case 7:
            dateComponents.day = -6
        default:
            print("Error")
        }
        
        let startOfWeek = calendarView.date(byAdding: dateComponents, to: Date())!
        dateArray.append(startOfWeek)
        for date in dateArray {
        while dateArray.count <= 6 {
            count += 1
            dailyDateComponents.day = count
            dateArray.append(calendarView.date(byAdding: dailyDateComponents, to: date)!)
        }
        }
        return dateArray
    }
    
    
    func getDay(dateArray: [Date]) -> [Int] { //this func takes the weeks dates and converts them to just the months day
        var dayArray: [Int] = []
        let myCalendar = Calendar.current
        for date in dateArray {
        let day = myCalendar.component(.day, from: date)
        dayArray.append(day)
        }
        return dayArray
    }
    
}

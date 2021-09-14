//
//  DateFuncs.swift
//  Habits
//
//  Created by Alexander Thompson on 14/9/21.
//

import UIKit

struct DateFuncs {
    
//    func getStartofWeek() -> Date {
//        let today       = Date()
//        let gregorian   = Calendar(identifier: .gregorian)
//        let sunday      = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: today))
//
//        return gregorian.date(byAdding: .day, value: 1, to: sunday!)!
//    }
    
   static func startOfDay(date: Date) -> Date {
        let calendarView = Calendar(identifier: .gregorian)
        let startDate = calendarView.startOfDay(for: date)
        return startDate
    }
}

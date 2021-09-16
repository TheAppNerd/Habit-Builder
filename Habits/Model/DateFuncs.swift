//
//  DateFuncs.swift
//  Habits
//
//  Created by Alexander Thompson on 14/9/21.
//

import UIKit

struct DateFuncs {
    
    
    //make this a date extension?
    
   static func startOfDay(date: Date) -> Date {
        let calendarView = Calendar(identifier: .gregorian)
        let startDate    = calendarView.startOfDay(for: date)
        return startDate
    }
}

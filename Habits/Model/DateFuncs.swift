//
//  DateFuncs.swift
//  Habits
//
//  Created by Alexander Thompson on 14/9/21.
//

import UIKit

struct DateFuncs {
    
    static func startOfDay(date: Date) -> Date {
        let calendarView = Calendar.current
        let startDate    = calendarView.startOfDay(for: date)
        return startDate
    }
    
    
    static func timeChanged(datePicker: DatePicker) -> [String] {
        let formatter          = DateFormatter()
        formatter.dateFormat   = "h:mm a"
        let dateAsString       = formatter.string(from: datePicker.date)
        
        let date               = formatter.date(from: dateAsString)
        formatter.dateFormat   = "HH:mm"
        
        let twentyFourHourDate = formatter.string(from: date!)
        return twentyFourHourDate.components(separatedBy: ":")
    }


static func setupDatePickerDate(hour: Int, minute: Int) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:mm"
    guard let date = dateFormatter.date(from: "\(hour):\(minute)") else { return Date()}
    return date
}
}

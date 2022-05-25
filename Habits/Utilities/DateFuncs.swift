//
//  DateFuncs.swift
//  Habits
//
//  Created by Alexander Thompson on 14/9/21.
//

import UIKit

struct DateFuncs {
   
    ///Returns date as exact date at start of day to avoid duplicate dates.
        func startOfDay(date: Date) -> Date {
        let calendarView = Calendar.current
        let startDate    = calendarView.startOfDay(for: date)
        return startDate
    }
    
    ///Takes time from date picker and seperates hours and minutes in order to set user notification.
        func timeChanged(datePicker: DatePicker) -> [String] {
        let formatter          = DateFormatter()
        formatter.dateFormat   = "h:mm a"
        let dateAsString       = formatter.string(from: datePicker.date)
        
        let date               = formatter.date(from: dateAsString)
        formatter.dateFormat   = "HH:mm"
        
        let twentyFourHourDate = formatter.string(from: date!)
        return twentyFourHourDate.components(separatedBy: ":")
    }
    
    ///Used to pull previous alarm time saved in core data and reapply it to the date picker.
        func setupDatePickerDate(hour: Int, minute: Int) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        guard let date = dateFormatter.date(from: "\(hour):\(minute)") else { return Date()}
        return date
    }
}

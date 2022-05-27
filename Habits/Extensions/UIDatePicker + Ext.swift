//
//  UIDatePicker + Ext.swift
//  Habits
//
//  Created by Alexander Thompson on 27/5/2022.
//

import UIKit

extension UIDatePicker {
    
    ///Takes time from date picker and seperates hours and minutes in order to set user notification.
        func timeChanged() -> [String] {
        let formatter          = DateFormatter()
        formatter.dateFormat   = "h:mm a"
        let dateAsString       = formatter.string(from: self.date)
        
        let date               = formatter.date(from: dateAsString)
        formatter.dateFormat   = "HH:mm"
        
        let twentyFourHourDate = formatter.string(from: date!)
        return twentyFourHourDate.components(separatedBy: ":")
    }
    
    ///Used to pull previous alarm time saved in core data and reapply it to the date picker.
        func setupDatePickerDate(hour: Int, minute: Int) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
            if let date = dateFormatter.date(from: "\(hour):\(minute)") {
            self.date = date
            }
    }
    
    ///Takes time from datepicker, converts it to string and splits hours and minutes into seperate strings for use in UserNotifications.
    func convertDatePickerTime() -> [String] {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        let dateString = formatter.string(from: self.date)
        
        let date = formatter.date(from: dateString)
        formatter.dateFormat = "HH:mm"
        
        let twentyFourHourDate = formatter.string(from: date!)
        let time = twentyFourHourDate.components(separatedBy: ":")
        
        return time
    }
}


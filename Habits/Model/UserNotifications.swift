//
//  UserNotifications.swift
//  Habits
//
//  Created by Alexander Thompson on 17/5/21.
//

import UIKit
import UserNotifications

class UserNotifications {
    
    
     func requestUserAuthorisation() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
        }
    }
    
    
    static func removeNotifications(title: String) {
        let center = UNUserNotificationCenter.current()
        for num in 1...7 {
            center.removePendingNotificationRequests(withIdentifiers: ["\(title)\(num)"])
        }
        
    }
    

    static func scheduleNotifications(alarmItem: AlarmItem) {
        let center  = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        let dayArray = HabitEntityFuncs().convertStringArraytoBoolArray(alarmItem: alarmItem)
        content.title              = alarmItem.title
        content.body               = "Time to \(alarmItem.title). You can do it"
        content.categoryIdentifier = "alarm"
        content.sound              = UNNotificationSound.default
        
        for (index, bool) in dayArray.enumerated() {
            if bool == true {
            var dateComponents         = DateComponents()
            dateComponents.weekday     = index + 1
            dateComponents.hour        = alarmItem.hour
            dateComponents.minute      = alarmItem.minute
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            
            let request = UNNotificationRequest(identifier: "\(alarmItem.title)\(index)", content: content, trigger: trigger)
            
            center.add(request)
        }
    }
    }
    

    
    func confirmRegisteredNotifications(segment: UISegmentedControl) { // made this func in new habit vc. should use this one and find way to present alert if denied. (input view to present?)
        let center = UNUserNotificationCenter.current()
        center.getNotificationSettings { (settings) in
            switch settings.authorizationStatus {
            case .authorized, .provisional:
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            case .denied:
                DispatchQueue.main.async {
                    segment.selectedSegmentIndex = 0
                }
                
            case .notDetermined:
                self.requestUserAuthorisation()
            case .ephemeral:
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            @unknown default:
                break
            }
        }
    }
    
}




//
//  UserNotifications.swift
//  Habits
//
//  Created by Alexander Thompson on 17/5/21.
//

import Foundation
import UserNotifications

class UserNotifications {
    
    func requestUserAuthorisation(sender: DateSwitch) {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("access granted")
            } else {
//                DispatchQueue.main.async {
//                    sender.isOn = false
                print("access denied")
                //present alert to allow in settings?
                }
               
            }
    }
    }
    
    func scheduleNotification(title: String, body: String, time: String) {
        let center = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.categoryIdentifier = "alarm"
        content.sound = UNNotificationSound.default
        
        var dateComponents = DateComponents()
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: title, content: content, trigger: trigger)
        center.add(request)
        
    }


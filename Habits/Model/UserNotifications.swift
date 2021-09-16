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
        center.removePendingNotificationRequests(withIdentifiers: [title])
    }
    
    
    static func scheduleNotification(title: String, day: Int ,hour: Int, minute: Int) {
        let center  = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        content.title              = title
        content.body               = "Time to \(title). You can do it"
        content.categoryIdentifier = "alarm"
        content.sound              = UNNotificationSound.default
        
        var dateComponents         = DateComponents()
        dateComponents.weekday     = day
        dateComponents.hour        = hour
        dateComponents.minute      = minute
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: title, content: content, trigger: trigger)
        
        center.add(request)
        print("center: \(center)")
    }
   
    
    func confirmRegisteredNotifications() -> String { // made this func in new habit vc. should use this one and find way to present alert if denied. (input view to present?)
        var str = ""
        let center = UNUserNotificationCenter.current()
        center.getNotificationSettings { (settings) in
            switch settings.authorizationStatus {
            case .authorized, .provisional:
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
                str = "authorised"
            case .denied:
                str = "denied"
                
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
        return str
    }
    
}




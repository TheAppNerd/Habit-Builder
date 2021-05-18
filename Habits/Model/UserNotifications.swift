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
    
    
    func scheduleNotification(title: String, body: String, hour: Int, minute: Int) {
        let center = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.categoryIdentifier = "alarm"
        content.sound = UNNotificationSound.default
        
        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: title, content: content, trigger: trigger)
        center.add(request)
    }

    
    func confirmRegisteredNotifications() {
        let center = UNUserNotificationCenter.current()
        center.getNotificationSettings { (settings) in
            switch settings.authorizationStatus {
            case .authorized, .provisional:
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            case .denied:
                print("Denied")
            case .notDetermined:
                self.requestUserAuthorisation()
            case .ephemeral:
                print("")
            @unknown default:
                break
            }
        }
        
    }
}

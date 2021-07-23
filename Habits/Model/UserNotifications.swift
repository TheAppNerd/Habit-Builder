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
    
    
    func scheduleNotification(title: String, hour: Int, minute: Int, onOrOff: Bool) {
        let center = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        content.title = title
       // content.body = body //update this for habit count left
        content.categoryIdentifier = "alarm"
        content.sound = UNNotificationSound.default
        
        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: title, content: content, trigger: trigger)
        if onOrOff == true {
        center.add(request)
        } else {
            center.removePendingNotificationRequests(withIdentifiers: [title])
        }
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

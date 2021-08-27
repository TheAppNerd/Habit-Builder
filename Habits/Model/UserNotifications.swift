//
//  UserNotifications.swift
//  Habits
//
//  Created by Alexander Thompson on 17/5/21.
//

import UIKit
import UserNotifications

class UserNotifications {
    
    //build functionality where if user declines authorisation, if they try to turn alarms on again they get a prompt to allow in settings. (Can I link to settings with button press in alert?)
    
    
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
        let center = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = "Time to \(title). You can do it"
        content.categoryIdentifier = "alarm"
        content.sound = UNNotificationSound.default
        
        var dateComponents = DateComponents()
        dateComponents.weekday = day
        dateComponents.hour = hour
        dateComponents.minute = minute
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: title, content: content, trigger: trigger)
        
        center.add(request)
    print("center: \(center)")
        }
    //add in error code
    //if habit deleted does it cancel all notifications? test
    

    
    func confirmRegisteredNotifications() -> String {
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
                print("")
            @unknown default:
                break
            }
        }
        return str
    }
    
}
    
    


//
//  UserNotifications.swift
//  Habits
//
//  Created by Alexander Thompson on 17/5/21.
//

import UIKit
import UserNotifications

struct UserNotifications {

    /// Sends a request to the user to authosise user notifications in this app.
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

    /// Removes all notifications for a habit when this is called. The 1...7 is to ensure notifications are cancelled for each day of the week.
    func removeNotifications(title: String) {
        let center = UNUserNotificationCenter.current()
        for num in 1...7 {
            center.removePendingNotificationRequests(withIdentifiers: ["\(title)\(num)"])
        }
    }

    /// Implements notifications for single habit using day array to confirm which days of the week the user has selected for the alarm.
    func scheduleNotifications(alarmItem: AlarmItem) {
        let dayArray               = CoreDataMethods.shared.convertStringArraytoBoolArray(alarmItem: alarmItem)
        let center                 = UNUserNotificationCenter.current()
        let content                = UNMutableNotificationContent()
        content.title              = alarmItem.title
        content.body               = "Time to \(alarmItem.title). You can do it!"
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

    /// Checks whether user has authorised user notifications and reacts accordingly.
    func confirmRegisteredNotifications(segment: UISegmentedControl) {
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

    /// Checks if user has allowed UserNotifications in app. If not, alarm pops up to notify user and direct them to settings to change this. Will then change Segment contro back to alarm off position until user allows UserNotifications.
    func dateSegmentChanged(segment: UISegmentedControl, vc: UIViewController) {
        let current = UNUserNotificationCenter.current()
        current.getNotificationSettings { (settings) in
            if settings.authorizationStatus == .authorized {
                DispatchQueue.main.async {
                    segment.selectedSegmentIndex = 1
                }
            }
            if settings.authorizationStatus == .denied {
                let deniedAlert = UIAlertController(title: Labels.notificationDeniedTitle, message: Labels.notificationDeniedMessage, preferredStyle: .alert)
                deniedAlert.addAction(UIAlertAction(title: "App Settings", style: .default, handler: { _ in
                    if let appSettings = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(appSettings) {
                        UIApplication.shared.open(appSettings)
                    }
                }))
                deniedAlert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                DispatchQueue.main.async {
                    vc.present(deniedAlert, animated: true) {
                        segment.selectedSegmentIndex = 0
                    }
                }
            }
        }
    }

}

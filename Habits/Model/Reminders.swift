//
//  Reminders.swift
//  Habits
//
//  Created by Alexander Thompson on 10/5/21.
//

import EventKit

class Reminders {
    
    let store = EKEventStore()
    
    
    
    func askForPermission(permission: @escaping () -> Void) {
        store.requestAccess(to: .reminder) { (granted, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if granted {
                self.permissionGranted()
            }
    }
    }
    
    func permissionGranted() {
        guard let calendar = store.defaultCalendarForNewReminders() else { return }
        let newReminder = EKReminder(eventStore: store)
        newReminder.calendar = calendar
        newReminder.title = "Test Reminder"
    }
    
}

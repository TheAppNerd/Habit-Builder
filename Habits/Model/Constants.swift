//
//  Constants.swift
//  Habits
//
//  Created by Alexander Thompson on 14/9/21.
//

import UIKit

enum Labels {
    static let HabitVCTitle         = "Habits"
    static let tableViewFooterLabel = "Add a new habit"
    static let AddHabitVCTitle      = "Add Habit"
    static let deleteAlertTitle     = "Delete Habit?"
    static let deleteAlartMessage   = "Are you sure you want to delete this? It cannot be recovered."
    static let notificationDeniedTitle = "Permission Denied"
    static let notificationDeniedMessage = "To enable notifications please activate them in the settings for this app"
}


enum SFSymbols {
    static let menuButton           = UIImage(systemName: "sidebar.leading")
    static let addHabitButton       = UIImage(systemName: "plus.app")
    static let checkMark            = UIImage(systemName: "checkmark")
    static let bell                 = UIImage(systemName: "bell.fill")
    static let bellSlash            = UIImage(systemName: "bell.slash.fill")
    static let trash                = UIImage(systemName: "trash.fill")
    static let trashSlash           = UIImage(systemName: "trash.slash.fill")
}


enum Colors {
    static let tertiaryWithAlpha    = UIColor.tertiarySystemBackground.withAlphaComponent(0.5)
}

enum GradientColors {
    
}



//
//  Constants.swift
//  Habits
//
//  Created by Alexander Thompson on 14/9/21.
//

import UIKit

enum Labels {
    static let HabitVCTitle              = "Habits"
    static let tableViewFooterLabel      = "Add a new habit"
    static let AddHabitVCTitle           = "Add Habit"
    static let deleteAlertTitle          = "Delete Habit?"
    static let deleteAlartMessage        = "Are you sure you want to delete this? It cannot be recovered."
    static let placeholder               = "Eg. Workout, meditate, etc"
    static let notificationDeniedTitle   = "Permission Denied"
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
    static let flame                = UIImage(systemName: "flame.fill")
    static let chart                = UIImage(systemName: "chart.bar.xaxis")
    static let minus                = UIImage(systemName: "minus")
    static let plus                 = UIImage(systemName: "plus")
}


enum Colors {
    static let tertiaryWithAlpha    = UIColor.tertiarySystemBackground.withAlphaComponent(0.5)
}

enum GradientColors {
    static let clearGradient        = [UIColor.clear.cgColor, UIColor.clear.cgColor]
}


enum SocialMedia {
    static let linkedInUsername     = "alexander-thompson-847a6486"
    static let linkedInURL          = "https://www.linkedin.com/in/\(SocialMedia.linkedInUsername)"
    
    static let instagramUsername    = "alexthompsondevelopment"
    static let instagramURL         = "https://instagram.com/\(SocialMedia.instagramUsername)"
    
    static let githubUsername       = "AlexThompsonDevelopment"
    static let githubURL            = "https://github.com/\(SocialMedia.githubUsername)"
   
    static let fSCalendarURL        = "https://github.com/WenchaoD/FSCalendar"
    static let flatIconURL          = "https://www.flaticon.com"
    static let appBreweryURL        = "https://www.appbrewery.co"
    static let seanAllenURL         = "https://seanallen.co"
}



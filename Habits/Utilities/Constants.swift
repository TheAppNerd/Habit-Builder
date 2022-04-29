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
    static let placeholder               = "  Eg. Workout, meditate, etc"
    static let notificationDeniedTitle   = "Permission Denied"
    static let notificationDeniedMessage = "To enable notifications please activate them in the settings for this app"
    static let daysArray                 = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    static let monthArray                = ["01","02","03","04","05","06","07","08","09","10","11","12",]
}


enum SFSymbols {
    static let boldConfig = UIImage.SymbolConfiguration(weight: .bold)
    
    static let menuButton           = UIImage(systemName: "sidebar.leading")
    static let addHabitButton       = UIImage(systemName: "plus.app")
    static let quoteButton          = UIImage(systemName: "quote.bubble")
    static let checkMark            = UIImage(systemName: "checkmark", withConfiguration: boldConfig)
    static let bell                 = UIImage(systemName: "bell.fill")
    static let bellSlash            = UIImage(systemName: "bell.slash.fill")
    static let trash                = UIImage(systemName: "trash.fill")
    static let trashSlash           = UIImage(systemName: "trash.slash.fill")
    static let flame                = UIImage(systemName: "flame.fill")
    static let chart                = UIImage(systemName: "chart.bar.xaxis")
}

enum GradientColors {
    static let clearGradient        = [UIColor.clear.cgColor, UIColor.clear.cgColor]
}


enum BackgroundColors {
    static let mainBackGround       = UIColor.systemBackground
    static let secondaryBackground  = UIColor.secondarySystemBackground
}


enum SocialMedia {
    static let privacyPolicyURL     = "https://www.termsfeed.com/live/4dfe5dc3-2370-4ce3-ab06-78c6d5e19e39"
    static let linkedInUsername     = "Alexander-Thompson-847a6486"
    static let linkedInURL          = "https://www.linkedin.com/in/\(SocialMedia.linkedInUsername)"
    
    static let instagramUsername    = "AlexThompsonDevelopment"
    static let instagramURL         = "https://instagram.com/\(SocialMedia.instagramUsername)"
    
    static let githubUsername       = "AlexThompsonDevelopment"
    static let githubURL            = "https://github.com/\(SocialMedia.githubUsername)"
    
    static let fSCalendarURL        = "https://github.com/WenchaoD/FSCalendar"
    static let flatIconURL          = "https://www.flaticon.com"
    static let appBreweryURL        = "https://www.appbrewery.co"
    static let seanAllenURL         = "https://seanallen.co"
    
    static let appLink              = "https://apps.apple.com/au/app/habit-builder/id1614197639"
}


enum feedback {
    static let emailAddress         = "Alex@appNerd.com.au"
    static let feedbackSubject      = "Habit Builder Feedback"
}

enum icons {
    static let iconArray = ["bicycle", "blender", "deadline", "desktopcomputer", "dumbbell", "guitar", "hammer", "jogging", "kettlebell", "meditation", "notebook", "painting", "pills", "plantpot", "reading", "refund", "shower", "taoism", "tea", "tooth", "vegetable", "washingmachine", "water", "watermelon", "alarmclock", "music", "pillow", "laughing"]
}

enum menuPage {
    
    static let menuTitles = [ "Share App", "Leave Rating", "Contact Us", "How it Works", "Privacy", "About App", "Dark Mode", "App Settings"]
    
    static let menuImages = [ "square.and.arrow.up", "heart.text.square", "envelope", "questionmark.circle", "hand.raised", "note.text", "moon.circle", "gearshape"]
    
}

enum helpPage {
    static let imageNames = ["addHabitScreen", "homeScreen", "detailsScreen", "sideMenuScreen", "quoteScreen", "darkModeScreen"]
    
    static let helpText = [
        """
Create a habit you want
to work on and set reminders
to stay on track.

""",
        """
Tap a date to mark off a habit
or select the background to
load the habits details.

""",
        """
Tap a date on the calendar to mark off
a habit or tap edit in the top right of
the screen to update any habit details.

""",
        """
Share, review, edit and
get detailed information
about the app.

""",
        """
Browse through quotes from famous
figures throughout history.

""",
        """
Alternate between
light & dark mode.

"""
        ]
}


//
//  EmailFeedback.swift
//  Habits
//
//  Created by Alexander Thompson on 7/12/21.
//

import UIKit

struct EmailFeedback {
    
    func newEmail() {
        //move to constants
        let address = "AlexThompsonDevelopment@gmail.com"
        let subject = "Habit Builder Feedback"
        
        let appVersion = UIApplication.appVersion
        let systemVersion = UIDevice.current.systemVersion
        let locale = Locale.current
        let modelNumber = UIDevice().modelIdentifier()
        
        
        let body = """



Habit Builder Version: \(appVersion ?? "Unable to Locate")
iOS Version: \(systemVersion)
Device: \(modelNumber)
Location: \(locale)

"""
        
        var components = URLComponents()
        components.scheme = "mailto"
        components.path = address
        components.queryItems = [
            URLQueryItem(name: "subject", value: subject),
            URLQueryItem(name: "body", value: body)
        ]
        
        guard let url = components.url else {
            print("Failed to create mailto URL")
            return
        }
        UIApplication.shared.open(url)
    }
}




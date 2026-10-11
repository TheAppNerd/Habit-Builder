//
//  EmailFeedback.swift
//  Habits
//
//  Created by Alexander Thompson on 7/12/21.
//

import UIKit

struct EmailFeedback {

    // MARK: - Properties

    let address           = Feedback.emailAddress
    let subject           = Feedback.feedbackSubject
    let appVersion        = UIApplication.appVersion
    let systemVersion     = UIDevice.current.systemVersion
    let locale            = Locale.current
    let modelNumber       = UIDevice().modelIdentifier()

    // MARK: - Functions

    /// Generates a feedback email in users primary email service on their device. Automatically provided information on app version, system version, device type and location to assist with bug fixing.
    ///
    /// - Warning: If user has no email functionality set up, func wont work.
    func newEmail() {
        let body              = """

    Aussie News Version: \(appVersion ?? "Unable to Locate")
    iOS Version: \(systemVersion)
    Device: \(modelNumber)
    Location: \(locale)

    """
        var components        = URLComponents()
        components.scheme     = "mailto"
        components.path       = address
        components.queryItems = [
            URLQueryItem(name: "subject", value: subject),
            URLQueryItem(name: "body", value: body)
        ]

        guard let url         = components.url else {
            print("Failed to create mailto URL")
            return
        }
        UIApplication.shared.open(url)
    }
}




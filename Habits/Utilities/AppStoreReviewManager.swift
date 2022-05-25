//
//  AppStoreReviewManager.swift
//  Habits
//
//  Created by Alexander Thompson on 14/3/2022.
//

import StoreKit

enum AppStoreManagerReview {
    
    ///Requests user to review app if they haven't already.
    static func requestReviewIfAppropriate() {
        if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
            SKStoreReviewController.requestReview(in: scene)
        }
    }
    
    ///Adds a counter to homeVC which will request user review app every 10 times which func is called.
    static func reviewCount() {
        let defaults = UserDefaults.standard
        var retrievedCount = defaults.integer(forKey: "reviewCount") as Int
        retrievedCount += 1

        if retrievedCount.isMultiple(of: 10) {
            AppStoreManagerReview.requestReviewIfAppropriate()
        }
        defaults.set(retrievedCount, forKey: "reviewCount")
    }
}

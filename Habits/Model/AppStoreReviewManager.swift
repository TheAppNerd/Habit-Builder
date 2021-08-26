//
//  AppStoreReviewManager.swift
//  Habits
//
//  Created by Alexander Thompson on 24/8/21.
//

import StoreKit

//use this as popup if user hasnt reviewed app yet. every 10-15 times app opened?
//link to app sotre page for proper review

enum AppStoreReviewManager {
    static func requestReviewIfAppropriate() {
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
        SKStoreReviewController.requestReview(in: scene)
        } else {
        //error message to user here
        }
    }
}


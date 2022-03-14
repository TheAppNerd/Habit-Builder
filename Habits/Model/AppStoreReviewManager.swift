//
//  AppStoreReviewManager.swift
//  Habits
//
//  Created by Alexander Thompson on 14/3/2022.
//

import StoreKit

enum AppStoreManagerReview {
    
    static func requestReviewIfAppropriate() {
        if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
            SKStoreReviewController.requestReview(in: scene)
        }
    }
}

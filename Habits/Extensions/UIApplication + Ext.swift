//
//  UIApplication + Ext.swift
//  Habits
//
//  Created by Alexander Thompson on 3/8/21.
//

import UIKit

extension UIApplication {
    
    /// Returns current app version.
    static var appVersion: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
}

//
//  UIApplication + Ext.swift
//  Habits
//
//  Created by Alexander Thompson on 3/8/21.
//

import UIKit

extension UIApplication {
    static var appVersion: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
}

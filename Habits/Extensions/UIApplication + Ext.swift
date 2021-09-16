//
//  UIApplication + Ext.swift
//  Habits
//
//  Created by Alexander Thompson on 3/8/21.
//

import Foundation
import UIKit


//use this on about page 
extension UIApplication {
    static var appVersion: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
}

//
//  DarkMode.swift
//  Habits
//
//  Created by Alexander Thompson on 13/9/21.
//

import UIKit

struct DarkMode {
    /// Loads the saved dark mode status of the app from UserDefaults.
    ///
    /// ```
    /// window?.overrideUserInterfaceStyle = DarkMode().selectedDarkMode()
    /// ```
    /// - Returns: UserInterfaceStyle dark mode scheme
        func selectedDarkMode() -> UIUserInterfaceStyle {
        let defaults = UserDefaults.standard
        
        guard let selectedDarkMode = defaults.object(forKey: "darkMode") as? String else { return UITraitCollection.current.userInterfaceStyle}
        
        switch selectedDarkMode {
        case "Device":
            return UITraitCollection.current.userInterfaceStyle
        case "Light":
            return UIUserInterfaceStyle.light
        case "Dark":
            return UIUserInterfaceStyle.dark
        default:
            return UITraitCollection.current.userInterfaceStyle
        }
    }
}



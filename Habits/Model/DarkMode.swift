//
//  DarkMode.swift
//  Habits
//
//  Created by Alexander Thompson on 13/9/21.
//

import UIKit

struct DarkMode {
    
    static func selectedDarkMode() -> UIUserInterfaceStyle {
        let defaults = UserDefaults.standard
        
        guard let selectedDarkMode = defaults.object(forKey: "darkMode") as? String else { return UITraitCollection.current.userInterfaceStyle}
        
        switch selectedDarkMode {
        case "Automatic": return UITraitCollection.current.userInterfaceStyle
        case "Light": return UIUserInterfaceStyle.light
        case "Dark": return UIUserInterfaceStyle.dark
        default: return UITraitCollection.current.userInterfaceStyle
        }
    }
    }
    


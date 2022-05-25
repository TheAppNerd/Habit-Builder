//
//  Gradients.swift
//  Habits
//
//  Created by Alexander Thompson on 12/8/21.
//

import UIKit

struct Gradients {
    
    let pinkGradient = [UIColor(red: 241/255.0, green: 167/255.0, blue: 241/255.0, alpha: 1.0).cgColor, UIColor(red: 250/255.0, green: 208/255.0, blue: 196/255.0, alpha: 1.0).cgColor]

    let orangeGradient = [UIColor(red: 251/255.0, green: 123/255.0, blue: 162/255.0, alpha: 1).cgColor, UIColor(red: 252/255.0, green: 224/255.0, blue: 67/255.0, alpha: 1).cgColor]

    let limeGradient = [UIColor(red: 25/255.0, green: 161/255.0, blue: 134/255.0, alpha: 1).cgColor, UIColor(red: 242/255.0, green: 207/255.0, blue: 67/255.0, alpha: 1).cgColor]

    let lightBlueGradient = [UIColor(red: 62/255.0, green: 173/255.0, blue: 207/255.0, alpha: 1).cgColor, UIColor(red: 171/255.0, green: 233/255.0, blue: 205/255.0, alpha: 1).cgColor]

    let redGradient = [UIColor(red: 200/255.0, green: 31/255.0, blue: 112/255.0, alpha: 1.0).cgColor, UIColor(red: 209/255.0, green: 149/255.0, blue: 146/255.0, alpha: 1.0).cgColor]

    let darkBlueGradient = [UIColor(red: 20/255.0, green: 85/255.0, blue: 123/255.0, alpha: 1.0).cgColor, UIColor(red: 127/255.0, green: 206/255.0, blue: 197/255.0, alpha: 1.0).cgColor]
    
    let purpleGradient = [UIColor(red: 114/255.0, green: 42/255.0, blue: 230/255.0, alpha: 1.0).cgColor, UIColor(red: 228/255.0, green: 181/255.0, blue: 203/255.0, alpha: 1.0).cgColor]
    
}

enum gradients {
    static let array = [Gradients().pinkGradient, Gradients().orangeGradient, Gradients().limeGradient, Gradients().lightBlueGradient, Gradients().redGradient, Gradients().darkBlueGradient, Gradients().purpleGradient]
}



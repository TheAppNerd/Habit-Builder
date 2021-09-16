//
//  Gradients.swift
//  Habits
//
//  Created by Alexander Thompson on 12/8/21.
//

import UIKit
//create an enum here to be able to select which color grade yuou want

struct Gradients {

    let blueGradient = [UIColor(red: 4/255.0, green: 187/255.0, blue: 255/255.0, alpha: 1.0).cgColor, UIColor(red: 80/255.0, green: 94/255.0, blue: 255/255.0, alpha: 1.0).cgColor]

    let orangeGradient = [UIColor(red: 255/255.0, green: 220/255.0, blue: 0/255.0, alpha: 1).cgColor, UIColor(red: 253/255.0, green: 94/255.0, blue: 0/255.0, alpha: 1).cgColor]

    let pinkGradient = [UIColor(red: 255/255.0, green: 159/255.0, blue: 140/255.0, alpha: 1).cgColor, UIColor(red: 253/255.0, green: 76/255.0, blue: 134/255.0, alpha: 1).cgColor]

    let greenGradient = [UIColor(red: 148/255.0, green: 251/255.0, blue: 171/255.0, alpha: 1).cgColor, UIColor(red: 31/255.0, green: 196/255.0, blue: 159/255.0, alpha: 1).cgColor]

    let purpleGradient = [UIColor(red: 250/255.0, green: 125/255.0, blue: 255/255.0, alpha: 1.0).cgColor, UIColor(red: 176/255.0, green: 64/255.0, blue: 255/255.0, alpha: 1.0).cgColor]

    let redGradient = [UIColor(red: 237/255.0, green: 33/255.0, blue: 58/255.0, alpha: 1.0).cgColor, UIColor(red: 147/255.0, green: 41/255.0, blue: 30/255.0, alpha: 1.0).cgColor]
    
    let darkGreenGradient = [UIColor(red: 23/255.0, green: 177/255.0, blue: 105/255.0, alpha: 1.0).cgColor, UIColor(red: 0/255.0, green: 106/255.0, blue: 78/255.0, alpha: 1.0).cgColor]
    
}

struct GradientArray {
    
    static let array = [Gradients().blueGradient, Gradients().greenGradient, Gradients().orangeGradient, Gradients().pinkGradient, Gradients().purpleGradient, Gradients().redGradient, Gradients().darkGreenGradient]
    
}

    




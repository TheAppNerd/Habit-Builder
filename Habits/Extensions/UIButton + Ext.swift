//
//  UIButton + Ext.swift
//  Habits
//
//  Created by Alexander Thompson on 15/7/21.
//

import UIKit

extension UIButton {
    
    func addGradient(colorOne: UIColor, colorTwo: UIColor) {
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradient.locations = [0.0, 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.0)
        
        layer.insertSublayer(gradient, at: 0)
    }

    
    
    
}

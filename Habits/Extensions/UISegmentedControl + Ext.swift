//
//  UISegmentedControl + Ext.swift
//  Habits
//
//  Created by Alexander Thompson on 21/1/22.
//

import UIKit

extension UISegmentedControl {
    
    /// Add a gradient to segmented controller.
    func setGradientColors() {
        let clearColor            = [UIColor.clear.cgColor, UIColor.clear.cgColor]
        let rectangleGradient     = UIImage(systemName: "rectangle.fill")?.addTintGradient(colors: Gradients.array[5])
        let rectangle             = UIImage(systemName: "rectangle.fill")?.addTintGradient(colors: clearColor)
        
        setBackgroundImage(rectangle, for: .normal, barMetrics: .default)
        setBackgroundImage(rectangleGradient, for: .selected, barMetrics: .default)
    }
}

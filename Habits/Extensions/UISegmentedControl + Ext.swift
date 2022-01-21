//
//  UISegmentedControl + Ext.swift
//  Habits
//
//  Created by Alexander Thompson on 21/1/22.
//

import UIKit

extension UISegmentedControl {
    
    func setGradientColors() {
        
        let rectangleGradient     = UIImage(systemName: "rectangle.fill")?.addTintGradient(colors: GradientArray.array[5])
        let rectangle = UIImage(systemName: "rectangle.fill")?.addTintGradient(colors: [UIColor.clear.cgColor, UIColor.clear.cgColor])
        
        setBackgroundImage(rectangle, for: .normal, barMetrics: .default)
        setBackgroundImage(rectangleGradient, for: .selected, barMetrics: .default)
    }
    
    
}

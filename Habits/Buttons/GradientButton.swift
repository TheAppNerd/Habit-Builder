//
//  GradientButton.swift
//  Habits
//
//  Created by Alexander Thompson on 14/8/21.
//

import UIKit

class GradientButton: UIButton {
    
    var colors = [CGColor]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(colors: [CGColor]) {
        self.init(frame: .zero)
        self.colors = colors
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
       layoutGradient()
    }
    
    func layoutGradient() {
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.startPoint = CGPoint(x: 1, y: 0)
        gradientLayer.frame = self.bounds
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        gradientLayer.colors = colors
        gradientLayer.cornerRadius = self.layer.cornerRadius
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
}

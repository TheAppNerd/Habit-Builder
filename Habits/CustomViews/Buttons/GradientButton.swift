//
//  GradientButton.swift
//  Habits
//
//  Created by Alexander Thompson on 14/8/21.
//

import UIKit

class GradientButton: UIButton {
    
    // MARK: - Properties
    
    var colors = [CGColor]()
    let gradientLayer: CAGradientLayer = CAGradientLayer()
    
    // MARK: - Class Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
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
    
    // MARK: - Methods
    
    private func layoutGradient() {
        gradientLayer.startPoint   = CGPoint(x: 1, y: 0)
        gradientLayer.frame        = self.bounds
        gradientLayer.endPoint     = CGPoint(x: 0, y: 1)
        gradientLayer.colors       = colors
        gradientLayer.cornerRadius = self.layer.cornerRadius
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
}

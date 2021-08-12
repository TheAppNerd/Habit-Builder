//
//  ColorButton.swift
//  Habits
//
//  Created by Alexander Thompson on 27/4/21.
//

import UIKit

class ColorButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(backgroundColor: UIColor) {
        self.init(frame: .zero)
        self.backgroundColor = backgroundColor
        
    }
    
    private func configure() {
       self.layer.borderWidth = 1
//        self.layer.borderColor = UIColor.white.cgColor
        self.clipsToBounds = true
        
        
        translatesAutoresizingMaskIntoConstraints = false
        
    }
}

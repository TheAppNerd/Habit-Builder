//
//  HabitProgressView.swift
//  Habits
//
//  Created by Alexander Thompson on 27/4/21.
//

import UIKit

class HabitProgressView: UIProgressView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(color: UIColor) {
        self.init(frame: .zero)
        self.progressTintColor = color
        
    }
    
    
    private func configure() {
        self.trackTintColor = .systemFill
        self.layer.cornerRadius = self.frame.height / 2
    }
    
}

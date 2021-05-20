//
//  DayButton.swift
//  Habits
//
//  Created by Alexander Thompson on 19/5/21.
//

import UIKit

class DayButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
        //self.layer.cornerRadius = self.bounds.size.width / 2
        self.clipsToBounds = true
        self.backgroundColor = .clear
        //self.frame.size = CGSize(width: 20, height: 20)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}

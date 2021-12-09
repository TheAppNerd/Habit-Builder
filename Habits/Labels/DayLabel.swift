//
//  dayLabel.swift
//  Habits
//
//  Created by Alexander Thompson on 18/5/21.
//

import UIKit

class DayLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(text: String) {
        self.init(frame: .zero)
        self.text = text
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        textColor                 = .white
        textAlignment             = .center
        font                      = .systemFont(ofSize: 18, weight: .bold)
        adjustsFontSizeToFitWidth = true
        layer.masksToBounds       = true
        layer.cornerRadius        = 5
        
    }
    
}

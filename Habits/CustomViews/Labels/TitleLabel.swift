//
//  TitleLabel.swift
//  Habits
//
//  Created by Alexander Thompson on 26/4/21.
//

import UIKit

class TitleLabel: UILabel {
    
    // MARK: - Class Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    convenience init(textAlignment: NSTextAlignment, fontSize: CGFloat) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font          = UIFont.systemFont(ofSize: fontSize, weight: .bold)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        adjustsFontSizeToFitWidth = true
        textColor                 = .white
        minimumScaleFactor        = 0.8
        lineBreakMode             = .byTruncatingTail
        layer.borderColor         = UIColor.white.cgColor
        layer.cornerRadius        = 10
    }
    
}

//
//  TitleLabel.swift
//  Habits
//
//  Created by Alexander Thompson on 26/4/21.
//

import UIKit

class TitleLabel: UILabel {

    //MARK: - Class Funcs
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
    
    //MARK: - Functions
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        textColor                 = .white
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor        = 0.9
        lineBreakMode             = .byTruncatingTail
    }
    
}

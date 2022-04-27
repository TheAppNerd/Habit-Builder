//
//  BodyLabel.swift
//  Habits
//
//  Created by Alexander Thompson on 26/4/21.
//

import UIKit

class BodyLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    convenience init(textInput: String, textAlignment: NSTextAlignment, fontSize: CGFloat) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
        self.text          = textInput
        self.font          = UIFont.systemFont(ofSize: fontSize, weight: .bold)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        textColor                         = .label
        font                              = UIFont.preferredFont(forTextStyle: .body)
        adjustsFontSizeToFitWidth         = true
        adjustsFontForContentSizeCategory = true
        minimumScaleFactor                = 0.75
        lineBreakMode                     = .byWordWrapping
        adjustsFontSizeToFitWidth         = true
        translatesAutoresizingMaskIntoConstraints = false
    }
}

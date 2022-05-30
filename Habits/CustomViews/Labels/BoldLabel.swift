//
//  BoldLabel.swift
//  Habits
//
//  Created by Alexander Thompson on 27/5/2022.
//

import UIKit

class BoldLabel: UILabel {

    // MARK: - Class Methods

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        textAlignment   = .center
        font            = UIFont.systemFont(ofSize: 18, weight: .bold)
        textColor       = .label
        backgroundColor = .clear
        
    }
}

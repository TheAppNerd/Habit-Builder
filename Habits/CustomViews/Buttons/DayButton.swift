//
//  DayButton.swift
//  Habits
//
//  Created by Alexander Thompson on 19/5/21.
//

import UIKit

class DayButton: UIButton {

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
        setTitleColor(.white, for: .normal)
        clipsToBounds     = true
        backgroundColor   = .clear
        titleLabel?.font  = UIFont.systemFont(ofSize: 18, weight: .bold)
        tintColor         = .white
        layer.borderColor = UIColor.white.cgColor
        backgroundColor   = .clear
        layer.borderWidth = 2
    }

}

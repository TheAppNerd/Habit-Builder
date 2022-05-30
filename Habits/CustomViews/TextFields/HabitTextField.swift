//
//  HabitTextField.swift
//  Habits
//
//  Created by Alexander Thompson on 28/4/21.
//

import UIKit

class HabitTextField: UITextField {

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
        textColor                 = .label
        tintColor                 = .label
        textAlignment             = .left
        font                      = UIFont.preferredFont(forTextStyle: .title2)
        adjustsFontSizeToFitWidth = true
        minimumFontSize           = 12
        layer.cornerRadius        = 10
        backgroundColor           = BackgroundColors.secondaryBackground
        autocorrectionType        = .no
        returnKeyType             = .done
        clearButtonMode           = .whileEditing
        placeholder               = Labels.placeholder
        layer.borderColor         = UIColor.red.cgColor
        text                      = ""
        leftView                  = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        leftViewMode              = .always
    }

}

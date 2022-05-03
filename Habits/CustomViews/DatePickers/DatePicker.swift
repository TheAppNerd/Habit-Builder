//
//  DatePicker.swift
//  Habits
//
//  Created by Alexander Thompson on 10/5/21.
//

import UIKit

class DatePicker: UIDatePicker {
    
    //MARK: - Class Funcs
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Functions
    
    private func configure() {
        datePickerMode                            = .time
        preferredDatePickerStyle                  = .wheels
        translatesAutoresizingMaskIntoConstraints = false
    }
}
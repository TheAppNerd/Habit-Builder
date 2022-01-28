//
//  FSCalendarView.swift
//  Habits
//
//  Created by Alexander Thompson on 15/9/21.
//

import UIKit
import FSCalendar

class FSCalendarView: FSCalendar {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
       setCurrentPage(Date(), animated: false)
       allowsMultipleSelection        = true
       appearance.headerTitleColor    = .label
       appearance.weekdayTextColor    = .label
       appearance.titleDefaultColor   = .secondaryLabel
       appearance.titleSelectionColor = .label
       placeholderType                = .none
        appearance.todayColor = .purple
        appearance.borderRadius = 0.5
        
        }
    }


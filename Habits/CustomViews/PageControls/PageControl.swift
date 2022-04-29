//
//  PageControl.swift
//  Habits
//
//  Created by Alexander Thompson on 27/5/21.
//

import UIKit

class PageControl: UIPageControl {
    
    
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
        translatesAutoresizingMaskIntoConstraints = false
        numberOfPages                 = 6
        pageIndicatorTintColor        = .secondaryLabel
        currentPageIndicatorTintColor = .label
        backgroundColor               = BackgroundColors.secondaryBackground
    }
}

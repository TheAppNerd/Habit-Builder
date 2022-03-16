//
//  PageControl.swift
//  Habits
//
//  Created by Alexander Thompson on 27/5/21.
//

import UIKit

class PageControl: UIPageControl {
    
    
//MARK: - Initialisers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Funcs
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        numberOfPages                 = 4
        pageIndicatorTintColor        = .secondaryLabel
        currentPageIndicatorTintColor = .label
        backgroundColor               = BackgroundColors.secondaryBackground
    }
}

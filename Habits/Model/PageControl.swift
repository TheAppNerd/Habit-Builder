//
//  PageControl.swift
//  Habits
//
//  Created by Alexander Thompson on 27/5/21.
//

import UIKit

//does this need to be seperate?

class PageControl: UIPageControl {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.numberOfPages = 3
        self.pageIndicatorTintColor = .secondaryLabel
        self.currentPageIndicatorTintColor = .label
        self.backgroundColor = .secondarySystemBackground
    }
}

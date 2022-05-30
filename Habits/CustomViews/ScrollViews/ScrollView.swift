//
//  ScrollView.swift
//  Habits
//
//  Created by Alexander Thompson on 27/5/21.
//

import UIKit

class ScrollView: UIScrollView {

    //MARK: - Class Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    
    private func configure() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.isPagingEnabled = true
    }
}

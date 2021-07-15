//
//  DividerView.swift
//  Habits
//
//  Created by Alexander Thompson on 20/5/21.
//

import UIKit

class DividerView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .tertiarySystemBackground
        self.layer.cornerRadius = 10
        
    }
    
    

}

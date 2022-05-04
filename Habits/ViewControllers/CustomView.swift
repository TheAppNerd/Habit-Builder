//
//  CustomView.swift
//  Habits
//
//  Created by Alexander Thompson on 4/5/2022.
//

import UIKit

class CustomView: UIView {

    var label = UILabel()
    var labelTwo = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure() {
        label.text = "Randiom"
        labelTwo.text = ""
        
        
        
    }
    
    
}



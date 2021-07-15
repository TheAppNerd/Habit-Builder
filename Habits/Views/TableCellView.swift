//
//  TableCellView.swift
//  Habits
//
//  Created by Alexander Thompson on 27/4/21.
//

import UIKit

class TableCellView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        self.backgroundColor = .tertiarySystemBackground
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.systemGray2.cgColor
        
        translatesAutoresizingMaskIntoConstraints = false
        
        
    }
}

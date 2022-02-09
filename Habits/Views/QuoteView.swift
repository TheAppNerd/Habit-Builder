//
//  QuoteView.swift
//  Habits
//
//  Created by Alexander Thompson on 9/2/22.
//

import UIKit

class QuoteView: UIView {
    
    let quoteLabel = UILabel()
    let nameLabel  = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        self.frame.size = .init(width: 40, height: 40)
        quoteLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        quoteLabel.text = "test"
        nameLabel.text = "test"
        
        let padding: CGFloat = 5
        self.addSubviews(quoteLabel, nameLabel)
        
        NSLayoutConstraint.activate([
            quoteLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            quoteLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            quoteLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            quoteLabel.bottomAnchor.constraint(equalTo: nameLabel.topAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: quoteLabel.bottomAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            nameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding)
        
        ])
        
        
        
        self.layer.cornerRadius = 10
        self.backgroundColor = .systemGreen
    }
    
}

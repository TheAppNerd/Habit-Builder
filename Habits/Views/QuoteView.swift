//
//  QuoteView.swift
//  Habits
//
//  Created by Alexander Thompson on 9/2/22.
//

import UIKit

class QuoteView: UITableViewHeaderFooterView {
    
    let quoteView = UIView()
    let quoteLabel = UILabel()
    let nameLabel  = UILabel()
    let quoteButton = UIButton()
    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func quoteButtonPressed(sender: UIButton) {
        sender.bounceAnimation()
    }
    
    private func configure() {
        quoteView.translatesAutoresizingMaskIntoConstraints = false
        
        quoteLabel.translatesAutoresizingMaskIntoConstraints = false
        quoteLabel.font = UIFont.italicSystemFont(ofSize: 16)
        quoteLabel.numberOfLines = 3
        quoteLabel.adjustsFontSizeToFitWidth = true
        quoteLabel.textAlignment = .center
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.textAlignment = .right
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.font = UIFont.systemFont(ofSize: 12)
        
        quoteButton.translatesAutoresizingMaskIntoConstraints = false
        quoteButton.setImage(UIImage(systemName: "arrow.clockwise"), for: .normal)
        quoteButton.addTarget(self, action: #selector(quoteButtonPressed), for: .touchUpInside)
        
        quoteView.layer.cornerRadius = 10
        
        let padding: CGFloat = 5
        self.addSubviews(quoteView, quoteLabel, nameLabel, quoteButton)
        
        NSLayoutConstraint.activate([
            
            quoteView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            quoteView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            quoteView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            quoteView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            
            quoteLabel.topAnchor.constraint(equalTo: quoteView.topAnchor, constant: padding),
            quoteLabel.leadingAnchor.constraint(equalTo: quoteView.leadingAnchor, constant: padding),
            quoteLabel.trailingAnchor.constraint(equalTo: quoteButton.leadingAnchor, constant: -padding),
            quoteLabel.bottomAnchor.constraint(equalTo: nameLabel.topAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: quoteLabel.bottomAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: quoteView.leadingAnchor, constant: padding),
            nameLabel.trailingAnchor.constraint(equalTo: quoteButton.leadingAnchor, constant: -padding),
            nameLabel.bottomAnchor.constraint(equalTo: quoteView.bottomAnchor, constant: -padding),
            
            quoteButton.topAnchor.constraint(equalTo: quoteView.topAnchor, constant: 10),
            quoteButton.leadingAnchor.constraint(equalTo: quoteLabel.trailingAnchor, constant: padding),
            quoteButton.trailingAnchor.constraint(equalTo: quoteView.trailingAnchor, constant: -10),
            quoteButton.bottomAnchor.constraint(equalTo: quoteView.bottomAnchor, constant: -10),
            quoteButton.widthAnchor.constraint(equalTo: quoteButton.heightAnchor)
            
            
        ])
    
    }
    
}

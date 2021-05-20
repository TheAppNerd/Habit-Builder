//
//  EmptyStateView.swift
//  Habits
//
//  Created by Alexander Thompson on 20/5/21.
//

import UIKit

class EmptyStateView: UIView {

    let message = TitleLabel(textAlignment: .center, fontSize: 12)
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        addSubview(message)
        addSubview(imageView)
        message.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        
        message.numberOfLines = 4
        message.text = "There are no habits here yet. Add some to get started"
        imageView.image = UIImage(systemName: "paperplane")
        
        NSLayoutConstraint.activate([
        
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 100),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            
            message.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            message.widthAnchor.constraint(equalToConstant: 100),
            message.heightAnchor.constraint(equalToConstant: 100),
            message.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
    }
    
    
    
    
    
    
    
}

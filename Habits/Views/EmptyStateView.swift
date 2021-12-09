//
//  EmptyStateView.swift
//  Habits
//
//  Created by Alexander Thompson on 20/5/21.
//

import UIKit


class EmptyStateView: UIView {

    let message = TitleLabel(textAlignment: .center, fontSize: 16)
    let imageView = UIImageView()
    let addHabitButton = GradientButton(colors: Gradients().pinkGradient)
    let howToUseButton = GradientButton(colors: Gradients().purpleGradient)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        addSubviews(message, imageView, addHabitButton, howToUseButton)
        
        
        
        message.numberOfLines             = 0
        message.text                      = """
                There are no habits here yet.
                Press the Add Habit button
                to get started or press
                How To Use for a guide on how to use this app.
                """
        
        message.textColor                 = .label
        imageView.image                   = UIImage(named: "habitIcon")
        imageView.layer.masksToBounds     = true
        imageView.layer.cornerRadius      = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        addHabitButton.layer.cornerRadius = 10
        addHabitButton.setTitle("Add Habit", for: .normal)
       
        howToUseButton.layer.cornerRadius = 10
        howToUseButton.setTitle("How to Use", for: .normal)
      
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -150),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            
            message.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            message.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            message.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 50),
            message.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -50),
          
            addHabitButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            addHabitButton.topAnchor.constraint(equalTo: message.bottomAnchor, constant: 40),
            addHabitButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 50),
            addHabitButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -50),
            addHabitButton.heightAnchor.constraint(equalToConstant: 50),
            
            howToUseButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            howToUseButton.topAnchor.constraint(equalTo: addHabitButton.bottomAnchor, constant: 10),
            howToUseButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 50),
            howToUseButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -50),
            howToUseButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

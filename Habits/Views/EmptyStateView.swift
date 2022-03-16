//
//  EmptyStateView.swift
//  Habits
//
//  Created by Alexander Thompson on 20/5/21.
//

import UIKit


class EmptyStateView: UIView {

    let message = TitleLabel(textAlignment: .center, fontSize: 20)
    let secondaryMessage = TitleLabel(textAlignment: .center, fontSize: 16)
    let imageView = UIImageView()
    let addHabitButton = GradientButton(colors: Gradients().lightBlueGradient)
    let howToUseButton = GradientButton(colors: Gradients().purpleGradient)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        addSubviews(message, secondaryMessage, imageView, addHabitButton, howToUseButton)
        
        //move to constants
        
        message.text = "Welcome to Habit Builder!"
                
        secondaryMessage.text = "There are no habits here yet"
                
        
        message.textColor                 = .label
        secondaryMessage.textColor        = .secondaryLabel
        imageView.image                   = UIImage(named: "IconClear")
        imageView.layer.masksToBounds     = true
        imageView.layer.cornerRadius      = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        addHabitButton.layer.cornerRadius = 10
        addHabitButton.setImage(UIImage(systemName: "plus.app"), for: .normal)
        addHabitButton.setTitle(" Add Habit", for: .normal)
        addHabitButton.tintColor = .white
       
        howToUseButton.layer.cornerRadius = 10
        howToUseButton.setImage(UIImage(systemName: "map.fill"), for: .normal)
        howToUseButton.setTitle(" How to Use", for: .normal)
        howToUseButton.tintColor = .white

        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -150),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            
            message.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            message.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 30),
            message.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 50),
            message.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -50),
            
            secondaryMessage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            secondaryMessage.topAnchor.constraint(equalTo: message.bottomAnchor, constant: 20),
            secondaryMessage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 50),
            secondaryMessage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -50),
          
            addHabitButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            addHabitButton.topAnchor.constraint(equalTo: secondaryMessage.bottomAnchor, constant: 40),
            addHabitButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 50),
            addHabitButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -50),
            addHabitButton.heightAnchor.constraint(equalToConstant: 50),
            
            howToUseButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            howToUseButton.topAnchor.constraint(equalTo: addHabitButton.bottomAnchor, constant: 10),
            howToUseButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 50),
            howToUseButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -50),
            howToUseButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}

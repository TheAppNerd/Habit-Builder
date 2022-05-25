//
//  EmptyStateView.swift
//  Habits
//
//  Created by Alexander Thompson on 20/5/21.
//

import UIKit


class EmptyStateView: UIView {
    
    //MARK: - Properties
    let message = TitleLabel(textAlignment: .center, fontSize: 20)
    let secondaryMessage = TitleLabel(textAlignment: .center, fontSize: 16)
    let imageView = UIImageView()
    let addHabitButton = GradientButton(colors: Gradients().lightBlueGradient)
    let howToUseButton = GradientButton(colors: Gradients().purpleGradient)
    
    //MARK: - Class Funcs
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        layoutUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Functions
    
    private func configure() {
        message.text                      = Labels.emptyPrimaryLabel
        message.textColor                 = .label
        
        secondaryMessage.text             = Labels.emptySecondaryMessage
        secondaryMessage.textColor        = .secondaryLabel
        
        imageView.image                   = icons.clearIcon
        imageView.layer.masksToBounds     = true
        imageView.layer.cornerRadius      = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        addHabitButton.layer.cornerRadius = 10
        addHabitButton.setImage(SFSymbols.addHabitButton, for: .normal)
        addHabitButton.setTitle(Labels.emptyAddHabit, for: .normal)
        addHabitButton.tintColor = .white
       
        howToUseButton.layer.cornerRadius = 10
        howToUseButton.setImage(SFSymbols.map, for: .normal)
        howToUseButton.setTitle(Labels.emptyHowToUse, for: .normal)
        howToUseButton.tintColor = .white
    }
    
    
    private func layoutUI() {
        addSubviews(message, secondaryMessage, imageView, addHabitButton, howToUseButton)
        
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

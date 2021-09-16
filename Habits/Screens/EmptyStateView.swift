//
//  EmptyStateView.swift
//  Habits
//
//  Created by Alexander Thompson on 20/5/21.
//

import UIKit


class EmptyStateView: UIView {

    let message = TitleLabel(textInput: "", textAlignment: .center, fontSize: 16)
    let imageView = UIImageView()
    let addHabitButton = GradientButton(colors: Gradients().blueGradient)
    let howToUseButton = GradientButton(colors: Gradients().darkGreenGradient)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        addSubviews(message, imageView, addHabitButton, howToUseButton)
        
        message.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addHabitButton.translatesAutoresizingMaskIntoConstraints = false
        howToUseButton.translatesAutoresizingMaskIntoConstraints = false
        
        message.numberOfLines = 0
        message.text = """
                There are no habits here yet.
                Press the Add Habit button
                to get started or press
                How To Use for a guide on how to use this app.
                """
        message.textColor = .label
        imageView.image = UIImage(named: "habitIcon")
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10
        
        
        addHabitButton.layer.cornerRadius = 10
        howToUseButton.layer.cornerRadius = 10
        
        addHabitButton.setTitle("Add Habit", for: .normal)
        addHabitButton.addTarget(self, action: #selector(addHabitPressed), for: .touchUpInside)
        
        howToUseButton.setTitle("How to Use", for: .normal)
        howToUseButton.addTarget(self, action: #selector(howToUsePressed), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
        
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -150),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            
            message.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            message.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            message.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 50),
            message.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -50),
          
            addHabitButton.topAnchor.constraint(equalTo: message.bottomAnchor, constant: 40),
            addHabitButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            addHabitButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 50),
            addHabitButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -50),
            addHabitButton.heightAnchor.constraint(equalToConstant: 50),
            
            howToUseButton.topAnchor.constraint(equalTo: addHabitButton.bottomAnchor, constant: 10),
            howToUseButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            howToUseButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 50),
            howToUseButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -50),
            howToUseButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    
    
    //change both of these to delegate funcs instead
    
    @objc func addHabitPressed(sender: GradientButton) {
        sender.bounceAnimation()
            (self.superview?.next as? UIViewController)?.navigationController!.pushViewController(NewHabitVC(), animated: true)
    }
    
    @objc func howToUsePressed(sender: GradientButton) {
        sender.bounceAnimation()
        (superview?.next as? UIViewController)?.navigationController!.pushViewController(HelpScreenViewController(), animated: true)
    }
    
    
    
    
}

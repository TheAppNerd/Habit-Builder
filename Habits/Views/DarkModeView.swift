//
//  DarkModeView.swift
//  Habits
//
//  Created by Alexander Thompson on 23/8/21.
//

import UIKit

class DarkModeView: UIView {

    let lightLabel = UILabel()
    let adaptiveButton = UIButton()
    let lightButton = UIButton()
    let darkButton = UIButton()
     let doneButton = GradientButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        let buttonArray = [adaptiveButton, lightButton, darkButton, doneButton]
        
        self.backgroundColor = .systemBackground
        self.layer.cornerRadius = 10
        lightLabel.translatesAutoresizingMaskIntoConstraints = false
        
        doneButton.colors = Gradients().blueGradient
        
        for button in buttonArray {
            button.translatesAutoresizingMaskIntoConstraints = false
            button.layer.cornerRadius = 10
        }
        
        lightLabel.text = "Light/Dark Mode"
        lightLabel.textAlignment = .center
        adaptiveButton.setTitle("Automatic", for: .normal)
        lightButton.setTitle("Light", for: .normal)
        darkButton.setTitle("Dark", for: .normal)
        doneButton.setTitle("Done", for: .normal)
        
        self.addSubviews(lightLabel, adaptiveButton, lightButton, darkButton, doneButton)
        
        let padding: CGFloat = 10
        NSLayoutConstraint.activate([
        
            lightLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            lightLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            lightLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            lightLabel.bottomAnchor.constraint(equalTo: adaptiveButton.topAnchor, constant: -padding),
            
            adaptiveButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            adaptiveButton.topAnchor.constraint(equalTo: lightLabel.bottomAnchor, constant: padding),
            adaptiveButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            adaptiveButton.bottomAnchor.constraint(equalTo: lightButton.topAnchor, constant: -padding),
            
            lightButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            lightButton.topAnchor.constraint(equalTo: adaptiveButton.bottomAnchor, constant: padding),
            lightButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            lightButton.bottomAnchor.constraint(equalTo: darkButton.topAnchor, constant: -padding),
            
            darkButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            darkButton.topAnchor.constraint(equalTo: lightButton.bottomAnchor, constant: padding),
            darkButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            darkButton.bottomAnchor.constraint(equalTo: doneButton.topAnchor, constant: -padding),
            
            doneButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            doneButton.topAnchor.constraint(equalTo: darkButton.bottomAnchor, constant: padding),
            doneButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            doneButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding),
        
        ])
        
    }
    
  
    
    
    
    
}

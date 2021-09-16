//
//  DarkModeView.swift
//  Habits
//
//  Created by Alexander Thompson on 23/8/21.
//

import UIKit

class DarkModeView: UIView {

    let lightLabel      = UILabel()
    let automaticButton = UIButton()
    let lightButton     = UIButton()
    let darkButton      = UIButton()
    let doneButton      = GradientButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.backgroundColor    = .tertiarySystemBackground
        self.layer.cornerRadius = 10
        
        let buttonArray         = [automaticButton, lightButton, darkButton, doneButton]
        for button in buttonArray {
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitleColor(.label, for: .normal)
            button.layer.cornerRadius = 10
            button.backgroundColor    = .secondarySystemBackground
            button.layer.borderColor  = UIColor.label.cgColor
        }
        
        lightLabel.translatesAutoresizingMaskIntoConstraints = false
        lightLabel.text          = "Light / Dark Mode"
        lightLabel.textAlignment = .center
        lightLabel.font          = UIFont.systemFont(ofSize: 18, weight: .bold)
        
        automaticButton.setTitle("Automatic", for: .normal)
        lightButton.setTitle("Light", for: .normal)
        darkButton.setTitle("Dark", for: .normal)
        doneButton.setTitle("Done", for: .normal)
        doneButton.colors = Gradients().blueGradient
        
        self.addSubviews(lightLabel, automaticButton, lightButton, darkButton, doneButton)
        
        let padding: CGFloat = 10
        NSLayoutConstraint.activate([
        
            lightLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            lightLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            lightLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            lightLabel.bottomAnchor.constraint(equalTo: automaticButton.topAnchor, constant: -padding),
            
            automaticButton.topAnchor.constraint(equalTo: lightLabel.bottomAnchor, constant: padding),
            automaticButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            automaticButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            automaticButton.bottomAnchor.constraint(equalTo: lightButton.topAnchor, constant: -padding),
            
            lightButton.topAnchor.constraint(equalTo: automaticButton.bottomAnchor, constant: padding),
            lightButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            lightButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            lightButton.bottomAnchor.constraint(equalTo: darkButton.topAnchor, constant: -padding),
            
            darkButton.topAnchor.constraint(equalTo: lightButton.bottomAnchor, constant: padding),
            darkButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            darkButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            darkButton.bottomAnchor.constraint(equalTo: doneButton.topAnchor, constant: -padding),
            
            doneButton.topAnchor.constraint(equalTo: darkButton.bottomAnchor, constant: padding),
            doneButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            doneButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            doneButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding),
        ])
    }
}

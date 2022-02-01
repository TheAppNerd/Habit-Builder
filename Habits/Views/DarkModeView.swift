//
//  DarkModeView.swift
//  Habits
//
//  Created by Alexander Thompson on 23/8/21.
//

import UIKit

class DarkModeView: UIView {

    let lightLabel      = UILabel()
    let deviceButton    = GradientButton()
    let lightButton     = GradientButton()
    let darkButton      = GradientButton()
    let doneButton      = GradientButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor    = .secondarySystemBackground
        self.layer.cornerRadius = 10
        
        let buttonArray         = [deviceButton, lightButton, darkButton, doneButton]
        for button in buttonArray {
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitleColor(.label, for: .normal)
            button.layer.cornerRadius = 5
            button.backgroundColor    = .systemBackground
            
        }
        
        lightLabel.translatesAutoresizingMaskIntoConstraints = false
        lightLabel.textAlignment = .center
        lightLabel.font          = UIFont.systemFont(ofSize: 18, weight: .bold)
        lightLabel.attributedText = NSAttributedString(string: "Dark Mode", attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
        
        deviceButton.setTitle("Device", for: .normal)
        deviceButton.setImage(UIImage(systemName: "iphone"), for: .normal)
        lightButton.setTitle("Light", for: .normal)
        lightButton.setImage(UIImage(systemName: "sun.max"), for: .normal)
        darkButton.setTitle("Dark", for: .normal)
        darkButton.setImage(UIImage(systemName: "moon"), for: .normal)
        doneButton.setTitle("Done", for: .normal)
        doneButton.colors = Gradients().darkBlueGradient
        
        self.addSubviews(lightLabel, deviceButton, lightButton, darkButton, doneButton)
        
        let padding: CGFloat = 10
        NSLayoutConstraint.activate([
        
            lightLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            lightLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            lightLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            lightLabel.bottomAnchor.constraint(equalTo: deviceButton.topAnchor, constant: -padding),
            
            deviceButton.topAnchor.constraint(equalTo: lightLabel.bottomAnchor, constant: padding),
            deviceButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            deviceButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            deviceButton.bottomAnchor.constraint(equalTo: lightButton.topAnchor, constant: -padding),
            
            lightButton.topAnchor.constraint(equalTo: deviceButton.bottomAnchor, constant: padding),
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

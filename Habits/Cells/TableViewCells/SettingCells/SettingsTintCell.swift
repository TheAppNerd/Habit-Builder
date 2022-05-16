//
//  SettingsTintCell.swift
//  Habits
//
//  Created by Alexander Thompson on 16/5/2022.
//

import UIKit

class SettingsTintCell: UITableViewCell {
    
    //MARK: - Properties
    
    static let reuseID = "SettingsTintCell"
    let settingsImageButton = GradientButton()
    let settingsLabel = UILabel()
    let settingsStack = UIStackView()
    var buttonArray: [UIButton] = []

    
    //MARK: - Class Funcs
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        settingsImageButton.addGradient(colors: gradients.array[1])
    }
    
    //MARK: - Functions
    
    private func configure() {
        settingsImageButton.translatesAutoresizingMaskIntoConstraints = false
        settingsImageButton.layer.cornerRadius = 10
        settingsImageButton.setImage(UIImage(systemName: "paintbrush"), for: .normal)
        
        
        settingsLabel.translatesAutoresizingMaskIntoConstraints = false
        settingsLabel.textAlignment = .left
        settingsLabel.text = "System Tint"
        settingsLabel.textColor = .label
 
        settingsStack.translatesAutoresizingMaskIntoConstraints = false
        settingsStack.alignment = .fill
        settingsStack.axis = .horizontal
        settingsStack.distribution = .fillEqually
        settingsStack.spacing = 5
        
        let colorArray: [UIColor] = [.systemRed, .systemBlue, .systemGreen, .systemPurple, .systemYellow, .systemOrange]
        
        for index in 0...5 {
            let button = UIButton()
            button.backgroundColor = colorArray[index]
            button.layer.cornerRadius = 10
            button.layer.borderColor = UIColor.label.cgColor
            button.layer.borderWidth = 0
            settingsStack.addArrangedSubview(button)
            buttonArray.append(button)
        }
        
    }
    
    
    private func layoutUI() {
        addSubviews(settingsImageButton, settingsLabel, settingsStack)
        let padding: CGFloat = 10
        NSLayoutConstraint.activate([
            settingsImageButton.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            settingsImageButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            settingsImageButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding),
            settingsImageButton.widthAnchor.constraint(equalTo: settingsImageButton.heightAnchor),
                
                settingsLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
                settingsLabel.leadingAnchor.constraint(equalTo: settingsImageButton.trailingAnchor, constant: padding),
                settingsLabel.trailingAnchor.constraint(equalTo: settingsStack.leadingAnchor, constant: -padding),
                settingsLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding),
                
                settingsStack.topAnchor.constraint(equalTo: self.topAnchor, constant: padding * 2),
                settingsStack.leadingAnchor.constraint(equalTo: settingsLabel.trailingAnchor, constant: padding),
                settingsStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
                settingsStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding * 2),
                settingsStack.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5)
        ])

    }
}

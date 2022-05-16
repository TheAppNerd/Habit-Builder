//
//  SettingIconsCell.swift
//  Habits
//
//  Created by Alexander Thompson on 16/5/2022.
//

import UIKit

class SettingIconsCell: UITableViewCell {
    
    //MARK: - Properties
    
    static let reuseID = "SettingIconsCell"
    let settingsImageButton = GradientButton()
    let settingsLabel = UILabel()
    let settingStack = UIStackView()
    var buttonArray: [UIButton] = []
    
    //MARK: - Class Funcs
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        configureStacks()
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        settingsImageButton.addGradient(colors: gradients.array[3])
    }
    
    //MARK: - Functions
    
    private func configure() {
        settingsImageButton.translatesAutoresizingMaskIntoConstraints = false
        settingsImageButton.layer.cornerRadius = 10
        settingsImageButton.setImage(UIImage(systemName: "apps.iphone"), for: .normal)
        
        settingsLabel.translatesAutoresizingMaskIntoConstraints = false
        settingsLabel.textAlignment = .left
        settingsLabel.textColor = .label
        settingsLabel.text = "Icon"
    }
    
    private func configureStacks() {
        settingStack.translatesAutoresizingMaskIntoConstraints = false
        settingStack.spacing = 5
        settingStack.axis = .vertical
        settingStack.distribution = .fillEqually
        settingStack.alignment = .fill
        
        for _ in 0...2 {
            let stackView = UIStackView()
            stackView.axis = .horizontal
            stackView.spacing = 5
            stackView.alignment = .fill
            stackView.distribution = .fillEqually
            
            for _ in 0...6 {
                let button = UIButton()
                button.layer.borderWidth = 0
                button.backgroundColor = .systemGreen
                button.layer.borderColor = UIColor.label.cgColor
                button.layer.cornerRadius = 10
                buttonArray.append(button)
                stackView.addArrangedSubview(button)
            }
            settingStack.addArrangedSubview(stackView)
        }
        
    }
    
    
    private func layoutUI() {
        addSubviews(settingsImageButton, settingsLabel, settingStack)
        let padding: CGFloat = 10
        NSLayoutConstraint.activate([
            settingsImageButton.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            settingsImageButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            settingsImageButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -120),
            settingsImageButton.widthAnchor.constraint(equalTo: settingsImageButton.heightAnchor),
                
                settingsLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
                settingsLabel.leadingAnchor.constraint(equalTo: settingsImageButton.trailingAnchor, constant: padding),
                settingsLabel.trailingAnchor.constraint(equalTo: settingStack.leadingAnchor, constant: -padding),
                settingsLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.3),
                
                settingStack.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
                settingStack.leadingAnchor.constraint(equalTo: settingsLabel.trailingAnchor, constant: padding),
                settingStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
                settingStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding),
                settingStack.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5),
        ])
    }
    
    
}

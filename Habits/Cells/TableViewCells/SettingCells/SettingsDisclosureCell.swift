//
//  SettingIconsCell.swift
//  Habits
//
//  Created by Alexander Thompson on 16/5/2022.
//

import UIKit

class SettingsDisclosureCell: UITableViewCell {
    
    //MARK: - Properties
    
    static let reuseID = "SettingDisclosureCell"
    let settingsImageButton = GradientButton()
    let settingsLabel = UILabel()
    var colors: [CGColor] = []
    
    enum settingType {
        case tint
        case theme
        case icon
    }
    
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
        settingsImageButton.addGradient(colors: colors)
    }
    
    //MARK: - Functions
    
    private func configure() {
        settingsImageButton.translatesAutoresizingMaskIntoConstraints = false
        settingsImageButton.layer.cornerRadius = 10
        
        
        settingsLabel.translatesAutoresizingMaskIntoConstraints = false
        settingsLabel.textAlignment = .left
        settingsLabel.textColor = .label
        settingsLabel.text = "Icon"
        self.accessoryType = .disclosureIndicator
    }
    
    func set(settingType: settingType) {
        switch settingType {
        case .tint:
            colors = gradients.array[1]
            settingsImageButton.setImage(UIImage(systemName: "paintbrush.fill"), for: .normal)
            settingsLabel.text = "System Tint"
        case .theme:
            colors = gradients.array[2]
            settingsImageButton.setImage(UIImage(systemName: "square.filled.and.line.vertical.and.square"), for: .normal)
            settingsLabel.text = "System Theme"
        case .icon:
            colors = gradients.array[3]
            settingsImageButton.setImage(UIImage(systemName: "apps.iphone"), for: .normal)
            settingsLabel.text = "App Icon"
        }
    }
    
    private func layoutUI() {
        addSubviews(settingsImageButton, settingsLabel)
        let padding: CGFloat = 10
        NSLayoutConstraint.activate([
            settingsImageButton.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            settingsImageButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            settingsImageButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding),
            settingsImageButton.widthAnchor.constraint(equalTo: settingsImageButton.heightAnchor),
            
            settingsLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            settingsLabel.leadingAnchor.constraint(equalTo: settingsImageButton.trailingAnchor, constant: padding),
            settingsLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            settingsLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding),
        ])
    }
    
    
}

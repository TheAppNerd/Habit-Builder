//
//  SettingsSwitchCell.swift
//  Habits
//
//  Created by Alexander Thompson on 16/5/2022.
//

import UIKit

class SettingsSwitchCell: UITableViewCell {
    
    //MARK: - Properties
    
    static let reuseID = "SettingsSwitchCell"
    let settingsImageButton = GradientButton()
    let settingsLabel = UILabel()
    let settingsSwitch = UISwitch()
    var colors: [CGColor] = []
    
    enum switchSetting {
        case privacy
        case haptics
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
        
        settingsSwitch.translatesAutoresizingMaskIntoConstraints = false
        
        
        
    }
    
    func set(switchSetting: switchSetting) {
        switch switchSetting {
        case .privacy:
            settingsImageButton.setImage(UIImage(systemName: "lock.fill"), for: .normal)
            settingsLabel.text = "Privacy Lock"
            colors = gradients.array[4]
        case .haptics:
            settingsImageButton.setImage(UIImage(systemName: "waveform"), for: .normal)
            settingsLabel.text = "Haptics"
            colors = gradients.array[5]
        }
    }
    
    
    private func layoutUI() {
        addSubviews(settingsImageButton, settingsLabel, settingsSwitch)
        let padding: CGFloat = 10
        
        NSLayoutConstraint.activate([
            settingsImageButton.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            settingsImageButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            settingsImageButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding),
            settingsImageButton.widthAnchor.constraint(equalTo: settingsImageButton.heightAnchor),
            
            settingsLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            settingsLabel.leadingAnchor.constraint(equalTo: settingsImageButton.trailingAnchor, constant: padding),
            settingsLabel.trailingAnchor.constraint(equalTo: settingsSwitch.leadingAnchor, constant: -padding),
            settingsLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding),
            
            settingsSwitch.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            settingsSwitch.leadingAnchor.constraint(equalTo: settingsLabel.trailingAnchor, constant: padding),
            settingsSwitch.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            settingsSwitch.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding),
            settingsSwitch.widthAnchor.constraint(equalTo: settingsSwitch.heightAnchor, multiplier: 2.0)
        ])
    }
    
    
}

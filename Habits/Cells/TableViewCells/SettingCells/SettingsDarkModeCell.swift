//
//  SettingsDarkModeCell.swift
//  Habits
//
//  Created by Alexander Thompson on 16/5/2022.
//

import UIKit

class SettingsDarkModeCell: UITableViewCell {
    
    //MARK: - Properties

    static let reuseID = "SettingsDarkModeCell"
    let settingsImageButton = GradientButton()
    let settingsLabel = UILabel()
    let settingsSegment = UISegmentedControl(items: ["Device", "Light", "Dark"])

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
        settingsImageButton.addGradient(colors: gradients.array[0])
    }
    
    
    
    //MARK: - Functions
    
    private func configure() {
        settingsImageButton.translatesAutoresizingMaskIntoConstraints = false
        settingsImageButton.layer.cornerRadius = 10
        settingsImageButton.setImage(UIImage(systemName: "moon.fill"), for: .normal)
       
        settingsLabel.translatesAutoresizingMaskIntoConstraints = false
        settingsLabel.textAlignment = .left
        settingsLabel.textColor = .label
        settingsLabel.text = "Dark Mode"
        
        settingsSegment.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func layoutUI() {
        addSubviews(settingsImageButton, settingsLabel, settingsSegment)
        let padding: CGFloat = 10
        NSLayoutConstraint.activate([
            settingsImageButton.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            settingsImageButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            settingsImageButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding),
            settingsImageButton.widthAnchor.constraint(equalTo: settingsImageButton.heightAnchor),
                
                settingsLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
                settingsLabel.leadingAnchor.constraint(equalTo: settingsImageButton.trailingAnchor, constant: padding),
                settingsLabel.trailingAnchor.constraint(equalTo: settingsSegment.leadingAnchor, constant: -padding),
                settingsLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding),
                
                settingsSegment.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
                settingsSegment.leadingAnchor.constraint(equalTo: settingsLabel.trailingAnchor, constant: padding),
                settingsSegment.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
                settingsSegment.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding),
                settingsSegment.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5)
        ])

        
    }

}

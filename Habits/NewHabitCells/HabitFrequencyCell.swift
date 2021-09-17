//
//  HabitFrequencyCell.swift
//  Habits
//
//  Created by Alexander Thompson on 13/8/21.
//

import UIKit

class HabitFrequencyCell: UITableViewCell {
    
    static let reuseID = "HabitFrequencyCell"
    
    let timesAWeekLabel = UILabel()
    let negativeButton  = GradientButton(colors: Gradients().blueGradient)
    let positiveButton  = GradientButton(colors: Gradients().blueGradient)
    let frequencyLabel  = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        timesAWeekLabel.translatesAutoresizingMaskIntoConstraints = false
        timesAWeekLabel.textAlignment      = .left
        timesAWeekLabel.text               = "Days a Week:"
        
        negativeButton.setImage(SFSymbols.minus, for: .normal)
        negativeButton.layer.cornerRadius  = 10
        negativeButton.tintColor           = .white
        
        frequencyLabel.translatesAutoresizingMaskIntoConstraints = false
        frequencyLabel.textAlignment       = .center
        frequencyLabel.backgroundColor     = .secondarySystemBackground
        frequencyLabel.layer.cornerRadius  = 10
        frequencyLabel.layer.masksToBounds = true
        
        positiveButton.setImage(SFSymbols.plus, for: .normal)
        positiveButton.layer.cornerRadius  = 10
        positiveButton.tintColor           = .white
        
        contentView.addSubviews(timesAWeekLabel, negativeButton, positiveButton, frequencyLabel)
        
        let padding: CGFloat = 10
        
        NSLayoutConstraint.activate([
            timesAWeekLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            timesAWeekLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            timesAWeekLabel.trailingAnchor.constraint(equalTo: negativeButton.leadingAnchor, constant: padding),
            timesAWeekLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
            timesAWeekLabel.heightAnchor.constraint(equalToConstant: 35),
            
            negativeButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            negativeButton.leadingAnchor.constraint(equalTo: timesAWeekLabel.trailingAnchor, constant: padding),
            negativeButton.trailingAnchor.constraint(equalTo: frequencyLabel.leadingAnchor, constant: -6),
            negativeButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
            negativeButton.widthAnchor.constraint(equalToConstant: self.frame.width / 6.2),
            
            frequencyLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            frequencyLabel.leadingAnchor.constraint(equalTo: negativeButton.trailingAnchor, constant: 6),
            frequencyLabel.trailingAnchor.constraint(equalTo: positiveButton.leadingAnchor, constant: -6),
            frequencyLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
            frequencyLabel.widthAnchor.constraint(equalToConstant: self.frame.width / 6.2),
            
            positiveButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            positiveButton.leadingAnchor.constraint(equalTo: frequencyLabel.trailingAnchor, constant: 6),
            positiveButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            positiveButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
            positiveButton.widthAnchor.constraint(equalToConstant: self.frame.width / 6.2),
        ])
    }
}

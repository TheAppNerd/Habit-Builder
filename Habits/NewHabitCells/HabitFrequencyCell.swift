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
    let negativeButton = GradientButton(colors: Gradients().blueGradient)
    let positiveButton = GradientButton(colors: Gradients().blueGradient)
    let frequencyLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        timesAWeekLabel.translatesAutoresizingMaskIntoConstraints = false
        timesAWeekLabel.textAlignment = .left
        timesAWeekLabel.text = "Days a Week:"
        
        negativeButton.translatesAutoresizingMaskIntoConstraints = false
        negativeButton.setImage(UIImage(systemName: "minus"), for: .normal)
        negativeButton.layer.cornerRadius = 10
        negativeButton.tintColor = .white
     

        frequencyLabel.translatesAutoresizingMaskIntoConstraints = false
        frequencyLabel.textAlignment = .center
        
        positiveButton.translatesAutoresizingMaskIntoConstraints = false
        positiveButton.setImage(UIImage(systemName: "plus"), for: .normal)
        positiveButton.layer.cornerRadius = 10
        positiveButton.tintColor = .white
        
        contentView.addSubviews(timesAWeekLabel, negativeButton, positiveButton, frequencyLabel)
        
        let padding: CGFloat = 10
        
        NSLayoutConstraint.activate([
            timesAWeekLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            timesAWeekLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            timesAWeekLabel.trailingAnchor.constraint(equalTo: negativeButton.leadingAnchor, constant: padding),
            timesAWeekLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
            timesAWeekLabel.heightAnchor.constraint(equalToConstant: 40),
         
           
            negativeButton.leadingAnchor.constraint(equalTo: timesAWeekLabel.trailingAnchor, constant: padding),
            negativeButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            negativeButton.trailingAnchor.constraint(equalTo: frequencyLabel.leadingAnchor),
            negativeButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
            negativeButton.widthAnchor.constraint(equalTo: negativeButton.heightAnchor),
            
            frequencyLabel.leadingAnchor.constraint(equalTo: negativeButton.trailingAnchor),
            frequencyLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            frequencyLabel.trailingAnchor.constraint(equalTo: positiveButton.leadingAnchor),
            frequencyLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
            frequencyLabel.widthAnchor.constraint(equalTo: frequencyLabel.heightAnchor),
            
            positiveButton.leadingAnchor.constraint(equalTo: frequencyLabel.trailingAnchor),
            positiveButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            positiveButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            positiveButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
            positiveButton.widthAnchor.constraint(equalTo: positiveButton.heightAnchor),
        ])
    }
}

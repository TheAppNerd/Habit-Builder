//
//  HabitCell.swift
//  Habits
//
//  Created by Alexander Thompson on 26/4/21.
//

import UIKit

class HabitCell: UITableViewCell {

static let reuseID = "HabitCell"
    
    let habitName = TitleLabel(textAlignment: .center, fontSize: 16)
    let streakCount = TitleLabel(textAlignment: .center, fontSize: 10)
    let completionCount = TitleLabel(textAlignment: .center, fontSize: 10)
    let completionButton = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(habitName)
        addSubview(streakCount)
        addSubview(completionCount)
        addSubview(completionButton)
        
        let padding: CGFloat = 10
        completionButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            habitName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            habitName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            habitName.trailingAnchor.constraint(equalTo: completionCount.leadingAnchor, constant: -padding),
            habitName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
            
            streakCount.topAnchor.constraint(equalTo: habitName.bottomAnchor, constant: padding),
            streakCount.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            streakCount.trailingAnchor.constraint(equalTo: completionCount.leadingAnchor, constant: -padding),
            streakCount.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
            
            completionCount.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            completionCount.leadingAnchor.constraint(equalTo: habitName.trailingAnchor, constant: padding),
            completionCount.trailingAnchor.constraint(equalTo: completionButton.leadingAnchor, constant: -padding),
            completionCount.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30),
            
            completionButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            completionButton.leadingAnchor.constraint(equalTo: completionCount.trailingAnchor, constant: padding),
            completionButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            completionButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30)
        ])
        
    }
    
    
}

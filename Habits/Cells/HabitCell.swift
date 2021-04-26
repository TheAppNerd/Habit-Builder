//
//  HabitCell.swift
//  Habits
//
//  Created by Alexander Thompson on 26/4/21.
//

import UIKit

class HabitCell: UITableViewCell {

static let reuseID = "HabitCell"
    
    let habitName = UILabel()
    let streakCount = UILabel()
    let completionCount = UILabel()
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
        
    }
    
    
}

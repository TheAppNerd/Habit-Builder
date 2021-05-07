//
//  HabitCell.swift
//  Habits
//
//  Created by Alexander Thompson on 26/4/21.
//

import UIKit

class HabitCell: UITableViewCell {

static let reuseID = "HabitCell"
    
    let habitName = TitleLabel(textAlignment: .left, fontSize: 16)
    let completionCount = TitleLabel(textAlignment: .center, fontSize: 10)
    
    let reduceButton = UIButton()
    let completionButton = UIButton()
    let progressView = HabitProgressView()
    let cellView = TableCellView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
       
        configureButtons()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func configureButtons() {
        completionButton.translatesAutoresizingMaskIntoConstraints = false
        reduceButton.translatesAutoresizingMaskIntoConstraints = false
        
        let completionImage = UIImage(systemName: "largecircle.fill.circle")
        completionButton.setImage(completionImage, for: .normal)
        completionButton.contentVerticalAlignment = .fill
        completionButton.contentHorizontalAlignment = .fill
        
        let reduceImage = UIImage(systemName: "arrow.uturn.left.circle")
        reduceButton.setImage(reduceImage, for: .normal)
       reduceButton.contentVerticalAlignment = .fill
       reduceButton.contentHorizontalAlignment = .fill
    }
    
    private func configure() {
        contentView.isUserInteractionEnabled = true
      
        progressView.transform = progressView.transform.scaledBy(x: 1, y: 4)
        
        addSubview(habitName)
        addSubview(completionCount)
        addSubview(completionButton)
        addSubview(reduceButton)
        addSubview(cellView)
        addSubview(progressView)

        let padding: CGFloat = 20
        cellView.backgroundColor = .secondarySystemBackground
        
        self.sendSubviewToBack(cellView)
        NSLayoutConstraint.activate([
            
            cellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            cellView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            cellView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            
            habitName.topAnchor.constraint(equalTo: cellView.topAnchor, constant: padding),
            habitName.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: padding),
            habitName.widthAnchor.constraint(equalToConstant: 80),
            habitName.heightAnchor.constraint(equalToConstant: 30),
            
            completionCount.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: padding),
            completionCount.heightAnchor.constraint(equalToConstant: padding),
            completionCount.widthAnchor.constraint(equalToConstant: 120),
            completionCount.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -20),
            
            progressView.topAnchor.constraint(equalTo: habitName.bottomAnchor, constant: 30),
            progressView.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -10),
            progressView.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: padding),
            progressView.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -padding),
            
            completionButton.centerYAnchor.constraint(equalTo: cellView.centerYAnchor),
            completionButton.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -padding),
            completionButton.heightAnchor.constraint(equalToConstant: 30),
            completionButton.widthAnchor.constraint(equalToConstant: 30),

            reduceButton.centerYAnchor.constraint(equalTo: cellView.centerYAnchor),
            reduceButton.trailingAnchor.constraint(equalTo: completionButton.leadingAnchor, constant: -padding),
            reduceButton.heightAnchor.constraint(equalToConstant: 30),
            reduceButton.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
}

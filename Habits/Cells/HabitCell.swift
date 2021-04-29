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
    let streakCount = TitleLabel(textAlignment: .left, fontSize: 10)
    let completionCount = TitleLabel(textAlignment: .center, fontSize: 10)
    let completionButton = UIButton()
    let progressBar = HabitProgressView()
    let cellView = TableCellView()
    
    let stackView = UIStackView()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        configureStackView()
        configureProgressBar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureStackView() {
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.addArrangedSubview(progressBar)
        stackView.addArrangedSubview(completionCount)
        stackView.sendSubviewToBack(progressBar)
        //arrange the lavbel to go on top of the progress bar 
    }
    
    func configureProgressBar() {
        progressBar.transform = progressBar.transform.scaledBy(x: 1, y: 8)
   //use this area to round the corners of the progress bar
    }
    
    private func configure() {
        
        contentView.isUserInteractionEnabled = true
        
        addSubview(habitName)
        addSubview(streakCount)
        addSubview(stackView)
        addSubview(completionButton)
        addSubview(cellView)
        

        let padding: CGFloat = 20
        completionButton.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.sendSubviewToBack(cellView)
        NSLayoutConstraint.activate([
            
            cellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            cellView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            cellView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            
            habitName.topAnchor.constraint(equalTo: cellView.topAnchor, constant: padding),
            habitName.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: padding),
            habitName.widthAnchor.constraint(equalToConstant: 80),
            habitName.heightAnchor.constraint(equalToConstant: padding),
            
            streakCount.topAnchor.constraint(equalTo: cellView.topAnchor, constant: padding),
            streakCount.leadingAnchor.constraint(equalTo: habitName.trailingAnchor, constant: padding),
            streakCount.heightAnchor.constraint(equalToConstant: padding),
            streakCount.trailingAnchor.constraint(equalTo: completionButton.leadingAnchor, constant: -padding),
            
            stackView.topAnchor.constraint(equalTo: habitName.bottomAnchor, constant: 30),
            stackView.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -padding),
            stackView.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -padding),
            
            completionButton.topAnchor.constraint(equalTo: habitName.topAnchor),
            completionButton.leadingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -50),
            completionButton.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -padding),
            completionButton.heightAnchor.constraint(equalToConstant: 30),
            completionButton.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
}

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
    var progressTotal: String?
    let reduceButton = UIButton()
    let completionButton = UIButton()
    let progressView = HabitProgressView()
    let cellView = TableCellView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        configureProgressBar()
        configureButtons()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureProgressBar() {
        progressView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapPressed)))
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
        
        addSubview(habitName)
        addSubview(streakCount)
        addSubview(completionCount)
        addSubview(completionButton)
        addSubview(reduceButton)
        addSubview(cellView)
        addSubview(progressView)

        let padding: CGFloat = 20
        
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
            
//            streakCount.topAnchor.constraint(equalTo: cellView.topAnchor, constant: padding),
//            streakCount.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: padding),
//            streakCount.heightAnchor.constraint(equalToConstant: padding),
//            streakCount.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -20),
            
            completionCount.topAnchor.constraint(equalTo: habitName.bottomAnchor, constant: 30),
            completionCount.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -padding),
            completionCount.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: padding),
            completionCount.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -padding),
            
//            progressView.topAnchor.constraint(equalTo: habitName.bottomAnchor, constant: 30),
//            progressView.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -padding),
//            progressView.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: padding),
//            progressView.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -padding),
            
            completionButton.centerYAnchor.constraint(equalTo: cellView.centerYAnchor),
            completionButton.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -padding),
            completionButton.heightAnchor.constraint(equalToConstant: 60),
            completionButton.widthAnchor.constraint(equalToConstant: 60),
            
            reduceButton.centerYAnchor.constraint(equalTo: cellView.centerYAnchor),
            reduceButton.trailingAnchor.constraint(equalTo: completionButton.leadingAnchor, constant: -padding),
            reduceButton.heightAnchor.constraint(equalToConstant: 60),
            reduceButton.widthAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    @objc func tapPressed() {
        if let total = Float(progressTotal ?? "0.0") {
        UIView.animate(withDuration: 3) {
            self.progressView.setProgress(total, animated: true)
        }
        }
    }
}

//
//  SaveCell.swift
//  Habits
//
//  Created by Alexander Thompson on 16/8/21.
//

import UIKit

class HabitSaveCell: UITableViewCell {
    
    static let reuseID = "SaveCell"

    let saveButton = GradientButton(colors: Gradients().darkBlueGradient)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
        saveButton.setTitle("Save Habit", for: .normal)
        saveButton.layer.cornerRadius = 10
        contentView.addSubview(saveButton)
        
        let padding: CGFloat = 10
        
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            saveButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            saveButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            saveButton.bottomAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: -padding),
            saveButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}

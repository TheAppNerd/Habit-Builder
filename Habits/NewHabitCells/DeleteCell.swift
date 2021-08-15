//
//  DeleteCell.swift
//  Habits
//
//  Created by Alexander Thompson on 13/8/21.
//

import UIKit

class DeleteCell: UITableViewCell {

static let reuseID = "DeleteCell"
    
    let deleteButton = GradientButton(colors: Gradients().redGradient)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.setTitle("Delete Habit", for: .normal)
        deleteButton.layer.cornerRadius = 10
        contentView.addSubview(deleteButton)
        
        let padding: CGFloat = 10
        
        NSLayoutConstraint.activate([
            deleteButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            deleteButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            deleteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            deleteButton.bottomAnchor.constraint(equalTo: deleteButton.bottomAnchor, constant: -padding),
            deleteButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}

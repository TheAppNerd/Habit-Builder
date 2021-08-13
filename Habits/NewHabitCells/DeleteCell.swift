//
//  DeleteCell.swift
//  Habits
//
//  Created by Alexander Thompson on 13/8/21.
//

import UIKit

class DeleteCell: UITableViewCell {

static let reuseID = "DeleteCell"
    
    let deleteLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        deleteLabel.translatesAutoresizingMaskIntoConstraints = false
        deleteLabel.text = "Delete Habit"
        deleteLabel.textAlignment = .center
        
        contentView.backgroundColor = .red
        contentView.addSubview(deleteLabel)
        
        NSLayoutConstraint.activate([
            deleteLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            deleteLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            deleteLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            deleteLabel.bottomAnchor.constraint(equalTo: deleteLabel.bottomAnchor),
            deleteLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}

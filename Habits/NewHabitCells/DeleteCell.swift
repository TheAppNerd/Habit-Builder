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
        deleteLabel.layer.masksToBounds = true
        deleteLabel.layer.cornerRadius = 10
        deleteLabel.backgroundColor = .red
        contentView.addSubview(deleteLabel)
        
        let padding: CGFloat = 10
        
        NSLayoutConstraint.activate([
            deleteLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            deleteLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            deleteLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            deleteLabel.bottomAnchor.constraint(equalTo: deleteLabel.bottomAnchor, constant: -padding),
            deleteLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}

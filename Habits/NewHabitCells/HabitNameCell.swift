//
//  HabitNameCell.swift
//  Habits
//
//  Created by Alexander Thompson on 13/8/21.
//

import UIKit

class HabitNameCell: UITableViewCell {

 static let reuseID = "HabitNameCell"
    
    var nameTextField = UITextField()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = .secondarySystemBackground
        self.layer.cornerRadius = 10
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.placeholder       = Labels.placeholder
        nameTextField.layer.cornerRadius = 10
        nameTextField.layer.borderColor = UIColor.red.cgColor
        nameTextField.text              = ""
        contentView.layer.cornerRadius  = 10
        
        let padding: CGFloat = 10
        
        contentView.addSubview(nameTextField)
        
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: contentView.topAnchor),
            nameTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nameTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            nameTextField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            nameTextField.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    
}

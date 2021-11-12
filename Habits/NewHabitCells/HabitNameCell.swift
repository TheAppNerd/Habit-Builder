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
      
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.placeholder       = Labels.placeholder
        nameTextField.layer.borderColor = UIColor.red.cgColor
        nameTextField.text              = ""
        contentView.layer.cornerRadius  = 10
        
        let padding: CGFloat = 10
        
        contentView.addSubview(nameTextField)
        
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            nameTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            nameTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            nameTextField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
            nameTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
}

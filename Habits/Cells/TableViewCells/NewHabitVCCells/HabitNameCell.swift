//
//  HabitNameCell.swift
//  Habits
//
//  Created by Alexander Thompson on 13/8/21.
//

import UIKit

class HabitNameCell: UITableViewCell {
    
    //MARK: - Properties
    static let reuseID = "HabitNameCell"
    var nameTextField  = HabitTextField()
    
    //MARK: - Class Funcs
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Functions
    
    private func configure() {
        backgroundColor                 = BackgroundColors.secondaryBackground
        layer.cornerRadius              = 10
        contentView.layer.cornerRadius  = 10
        
    }
    
    
    private func layoutUI() {
        contentView.addSubview(nameTextField)
        let padding: CGFloat = 10
        
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            nameTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            nameTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            nameTextField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
            nameTextField.heightAnchor.constraint(equalToConstant: 35)
        ])
    }
    
}

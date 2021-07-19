//
//  MenuTableViewCell.swift
//  Habits
//
//  Created by Alexander Thompson on 11/5/21.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    static let reuseID = "MenuCell"
    
    let cellImage = UIImageView()
    let cellLabel = TitleLabel(textInput: "", textAlignment: .left, fontSize: 20)
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        contentView.isUserInteractionEnabled = true
        addSubview(cellImage)
        addSubview(cellLabel)
        self.backgroundColor = .secondarySystemBackground
      
        cellLabel.textColor = .label
        cellImage.translatesAutoresizingMaskIntoConstraints = false
        cellLabel.translatesAutoresizingMaskIntoConstraints = false

        let padding: CGFloat = 10
        NSLayoutConstraint.activate([
            
            cellImage.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: padding),
            cellImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            cellImage.heightAnchor.constraint(equalToConstant: 20),
            cellImage.trailingAnchor.constraint(equalTo: cellLabel.leadingAnchor, constant: -padding),
            cellImage.widthAnchor.constraint(equalToConstant: 20),
            
            cellLabel.leadingAnchor.constraint(equalTo: cellImage.trailingAnchor, constant: padding),
            cellLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            cellLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
        ])
    }
    
    
   
}

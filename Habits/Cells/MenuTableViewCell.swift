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
    let cellLabel = TitleLabel(textAlignment: .left, fontSize: 30)
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(cellImage)
        addSubview(cellLabel)
        cellImage.translatesAutoresizingMaskIntoConstraints = false
        cellLabel.translatesAutoresizingMaskIntoConstraints = false
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            
            cellImage.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: padding),
            cellImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            cellImage.heightAnchor.constraint(equalToConstant: self.frame.height / 2),
            cellImage.widthAnchor.constraint(equalTo: self.heightAnchor),
            
            cellLabel.leadingAnchor.constraint(equalTo: cellImage.trailingAnchor, constant: padding),
            cellLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            cellLabel.heightAnchor.constraint(equalTo: cellImage.heightAnchor),
            cellLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding)
        ])
        
        
    }
}

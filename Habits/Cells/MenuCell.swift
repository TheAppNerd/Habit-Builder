//
//  MenuTableViewCell.swift
//  Habits
//
//  Created by Alexander Thompson on 11/5/21.
//

import UIKit

class MenuCell: UITableViewCell {

    static let reuseID = "MenuCell"
    
    let cellImage      = UIImageView()
    let cellLabel      = TitleLabel(textAlignment: .left, fontSize: 20)
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        contentView.isUserInteractionEnabled = true
        addSubviews(cellImage, cellLabel)
        self.backgroundColor = BackgroundColors.secondaryBackground
      
        cellLabel.textColor  = .label
        cellLabel.translatesAutoresizingMaskIntoConstraints = false
        cellImage.translatesAutoresizingMaskIntoConstraints = false
       
        let padding: CGFloat = 10
        NSLayoutConstraint.activate([
            
            cellImage.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            cellImage.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: padding * 2),
            cellImage.trailingAnchor.constraint(equalTo: cellLabel.leadingAnchor, constant: -padding),
            cellImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding),
            cellImage.widthAnchor.constraint(equalTo: cellImage.heightAnchor),
            
            cellLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            cellLabel.leadingAnchor.constraint(equalTo: cellImage.trailingAnchor, constant: padding),
            cellLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            cellLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding),
        ])
    }
}

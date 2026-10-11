//
//  MenuTableViewCell.swift
//  Habits
//
//  Created by Alexander Thompson on 11/5/21.
//

import UIKit

class MenuCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let reuseID = "MenuCell"
    let cellImage      = UIImageView()
    let cellLabel      = TitleLabel(textAlignment: .left, fontSize: 20)
    
    // MARK: - Class Methods
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func configure() {
        contentView.isUserInteractionEnabled = true
        backgroundColor = BackgroundColors.secondaryBackground
        
        cellLabel.textColor  = .label

        cellImage.translatesAutoresizingMaskIntoConstraints = false

        //iconButton.imageEdgeInsets    = UIEdgeInsets(top: 6, left: 9, bottom: 6, right: 9)
    }
    
    private func layoutUI() {
        addSubviews(cellImage, cellLabel)
        let padding: CGFloat = 10
        
        NSLayoutConstraint.activate([
            cellImage.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            cellImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding * 2),
            cellImage.trailingAnchor.constraint(equalTo: cellLabel.leadingAnchor, constant: -padding),
            cellImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding),
            cellImage.widthAnchor.constraint(equalTo: cellImage.heightAnchor),
            
            cellLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            cellLabel.leadingAnchor.constraint(equalTo: cellImage.trailingAnchor, constant: padding),
            cellLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            cellLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding)
        ])
    }
    
}

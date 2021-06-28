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
    let cellLabel = TitleLabel(textAlignment: .left, fontSize: 20)
    var cellSwitch = UISwitch()
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        contentView.isUserInteractionEnabled = true
        cellSwitch.isHidden = true
        addSubview(cellImage)
        addSubview(cellLabel)
        addSubview(cellSwitch)
        
        self.backgroundColor = .secondarySystemBackground
        cellLabel.textColor = .label
        cellImage.tintColor = .label
        cellImage.translatesAutoresizingMaskIntoConstraints = false
        cellLabel.translatesAutoresizingMaskIntoConstraints = false
        cellSwitch.translatesAutoresizingMaskIntoConstraints = false
        let padding: CGFloat = 10
        NSLayoutConstraint.activate([
            
            cellImage.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: padding),
            cellImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            cellImage.heightAnchor.constraint(equalToConstant: 20),
            cellImage.trailingAnchor.constraint(equalTo: cellLabel.leadingAnchor, constant: -padding),
            cellImage.widthAnchor.constraint(equalToConstant: 20),
            
            cellLabel.leadingAnchor.constraint(equalTo: cellImage.trailingAnchor, constant: padding),
            cellLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            cellLabel.trailingAnchor.constraint(equalTo: cellSwitch.leadingAnchor, constant: -padding),
            
            cellSwitch.leadingAnchor.constraint(equalTo: cellLabel.trailingAnchor, constant: padding),
            cellSwitch.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            cellSwitch.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
    
    
   
}

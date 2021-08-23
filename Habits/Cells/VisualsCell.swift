//
//  VisualsCell.swift
//  Habits
//
//  Created by Alexander Thompson on 21/7/21.
//

import UIKit

class VisualsCell: UITableViewCell {
    
    static let reuseID = "VisualCell"

    let cellImage = UIImageView()
    let cellLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
       
        self.accessoryType = .disclosureIndicator
        addSubviews(cellImage, cellLabel)
        let padding: CGFloat = 20
        cellImage.translatesAutoresizingMaskIntoConstraints = false
        cellLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cellImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            cellImage.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            cellImage.trailingAnchor.constraint(equalTo: cellLabel.leadingAnchor, constant: -padding),
            cellImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding),
            cellImage.widthAnchor.constraint(equalTo: cellImage.heightAnchor),
            //cellImage.heightAnchor.constraint(equalToConstant: 30),
            
            cellLabel.leadingAnchor.constraint(equalTo: cellImage.trailingAnchor, constant: padding),
            cellLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            cellLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            cellLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding)
        
        ])
        
        
    }
    
}

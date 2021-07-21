//
//  DarkModeCell.swift
//  Habits
//
//  Created by Alexander Thompson on 21/7/21.
//

import UIKit

class DarkModeCell: UITableViewCell {

    static let reuseID = "DarkCell"
    
    let darkModeSegment = UISegmentedControl(items: ["Adaptive", "Light Mode", "Dark Mode"])
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        darkModeSegment.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(darkModeSegment)
        let padding: CGFloat = 5
        NSLayoutConstraint.activate([
            darkModeSegment.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            darkModeSegment.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            darkModeSegment.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            darkModeSegment.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        
        
        ])
        
    }
    
}

//
//  IconCell.swift
//  Habits
//
//  Created by Alexander Thompson on 13/8/21.
//

import UIKit

class IconCell: UITableViewCell {

static let reuseID = "IconCell"
    
    let stackViewOne = UIStackView()
    let stackViewTwo = UIStackView()
    let stackViewThree = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        let stackArray = [stackViewOne, stackViewTwo, stackViewThree]
        
        for stack in stackArray {
            stack.translatesAutoresizingMaskIntoConstraints = false
            stack.axis = .horizontal
            stack.distribution = .fillEqually
            stack.spacing = 3
            
            for _ in 0...6 {
                let iconButton = UIButton()
                iconButton.setImage(UIImage(systemName: "swift"), for: .normal)
                stack.addArrangedSubview(iconButton)
            }
        }

        contentView.addSubviews(stackViewOne, stackViewTwo, stackViewThree)
        let padding: CGFloat = 10
        
        NSLayoutConstraint.activate([
            
            stackViewOne.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            stackViewOne.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            stackViewOne.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            stackViewOne.bottomAnchor.constraint(equalTo: stackViewTwo.topAnchor, constant: -padding),
            
            stackViewTwo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            stackViewTwo.topAnchor.constraint(equalTo: stackViewOne.bottomAnchor, constant: padding),
            stackViewTwo.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            stackViewTwo.bottomAnchor.constraint(equalTo: stackViewThree.topAnchor, constant: -padding),
            
            stackViewThree.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            stackViewThree.topAnchor.constraint(equalTo: stackViewTwo.bottomAnchor, constant: padding),
            stackViewThree.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            stackViewThree.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding)
            
            
        
        
        
        ])
        
    }
    
}

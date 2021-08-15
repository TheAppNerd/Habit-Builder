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
    let stackViewFour = UIStackView()
    
    var colors = [CGColor]()
    var noColors = [UIColor.clear.cgColor, UIColor.clear.cgColor]
    
    var buttonArray = [GradientButton]()
    var iconArray = ["bicycle", "blender", "deadline", "desktopcomputer", "dumbbell", "guitar", "hammer", "jogging", "kettlebell", "meditation", "notebook", "painting", "pills", "plantpot", "reading", "refund", "shower", "taoism", "tea", "tooth", "vegetable", "washingmachine", "water", "watermelon", "alarmclock", "music", "pillow", "laughing"]
    
    let paths = Bundle.main.paths(forResourcesOfType: "png", inDirectory: nil)
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        let stackArray = [stackViewOne, stackViewTwo, stackViewThree, stackViewFour]
        
        for stack in stackArray {
            stack.translatesAutoresizingMaskIntoConstraints = false
            stack.axis = .horizontal
            stack.distribution = .fillEqually
            stack.spacing = 6
            
            for _ in 0...6 {
                let iconButton = GradientButton()
                iconButton.imageEdgeInsets = UIEdgeInsets(top: 8, left: 10, bottom: 8, right: 10)
                iconButton.layer.cornerRadius = 10
                iconButton.backgroundColor = .tertiarySystemBackground
                iconButton.tintColor = .secondaryLabel
                iconButton.addTarget(self, action: #selector(iconButtonPressed), for: .touchUpInside)
                stack.addArrangedSubview(iconButton)
                buttonArray.append(iconButton)
            }
        }
        for count in 0...buttonArray.count - 1 {
            buttonArray[count].setImage(UIImage(named: iconArray[count]), for: .normal)
            
        }
        contentView.addSubviews(stackViewOne, stackViewTwo, stackViewThree, stackViewFour)
        let padding: CGFloat = 10
        
        NSLayoutConstraint.activate([
            
            stackViewOne.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            stackViewOne.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            stackViewOne.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            stackViewOne.bottomAnchor.constraint(equalTo: stackViewTwo.topAnchor, constant: -padding),
            stackViewOne.heightAnchor.constraint(equalToConstant: 40),
            
            stackViewTwo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            stackViewTwo.topAnchor.constraint(equalTo: stackViewOne.bottomAnchor, constant: padding),
            stackViewTwo.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            stackViewTwo.bottomAnchor.constraint(equalTo: stackViewThree.topAnchor, constant: -padding),
            stackViewTwo.heightAnchor.constraint(equalToConstant: 40),
            
            stackViewThree.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            stackViewThree.topAnchor.constraint(equalTo: stackViewTwo.bottomAnchor, constant: padding),
            stackViewThree.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            stackViewThree.bottomAnchor.constraint(equalTo: stackViewFour.topAnchor, constant: -padding),
            stackViewThree.heightAnchor.constraint(equalToConstant: 40),
            
            stackViewFour.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            stackViewFour.topAnchor.constraint(equalTo: stackViewThree.bottomAnchor, constant: padding),
            stackViewFour.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            stackViewFour.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
            stackViewFour.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc func iconButtonPressed(_ sender: GradientButton) {
        for item in buttonArray {
                item.tintColor = .secondaryLabel
            item.layer.borderWidth = 0
            item.backgroundColor = .systemBackground

            item.gradientLayer.colors = noColors
            }
            
        sender.tintColor = .label
        sender.layer.borderWidth = 1
        sender.layer.borderColor = UIColor.label.cgColor
        sender.colors = colors
        }
   
    }


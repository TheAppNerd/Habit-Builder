//
//  ColorCell.swift
//  Habits
//
//  Created by Alexander Thompson on 13/8/21.
//

import UIKit


class ColorCell: UITableViewCell {

    static let reuseID = "ColorCell"
 
   
    let gradientArray = [Gradients().blueGradient, Gradients().greenGradient, Gradients().orangeGradient, Gradients().pinkGradient, Gradients().purpleGradient, Gradients().redGradient, Gradients().darkGreen]
    
    
    let stackView = UIStackView()
    var buttonArray = [UIButton]()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    private func configure() {
     
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 6
        
        for num in 0...6 {
            let colorButton = GradientButton(colors: gradientArray[num])
            colorButton.layer.cornerRadius = 10
            colorButton.addTarget(self, action: #selector(colorButtonPressed), for: .touchUpInside)
            
            stackView.addArrangedSubview(colorButton)
            buttonArray.append(colorButton)
        }
        contentView.addSubview(stackView)
        let padding: CGFloat = 10
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding)
        ])
    }
    
    @objc func colorButtonPressed(_ sender: UIButton) {
        for item in buttonArray {
            item.layer.borderWidth = 0
            item.isSelected = false
        }
        sender.isSelected = true
        sender.layer.borderWidth = 1
        sender.layer.borderColor = UIColor.label.cgColor
    }
}

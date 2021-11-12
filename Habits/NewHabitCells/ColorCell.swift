//
//  ColorCell.swift
//  Habits
//
//  Created by Alexander Thompson on 13/8/21.
//

import UIKit

protocol reloadTableViewDelegate: AnyObject {
    func reloadTableView(colors: [CGColor], colorIndex: Int)
}

class ColorCell: UITableViewCell {

    weak var delegate: reloadTableViewDelegate?
    
    static let reuseID = "ColorCell"
    let stackView      = UIStackView()
    var color          = [CGColor]()
    var colorIndex     = Int()
    var buttonArray    = [GradientButton]()
    let generator            = UIImpactFeedbackGenerator(style: .medium)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
        generator.prepare()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis          = .horizontal
        stackView.distribution  = .fillEqually
        stackView.spacing       = 6
        
        for num in 0...6 {
            let colorButton = GradientButton(colors: GradientArray.array[num])

            colorButton.layer.cornerRadius = 10
            colorButton.layer.borderColor  = UIColor.label.cgColor
            colorButton.addTarget(self, action: #selector(colorButtonPressed), for: .touchUpInside)
            
            stackView.addArrangedSubview(colorButton)
            buttonArray.append(colorButton)
        }
        contentView.addSubview(stackView)
        
        let padding: CGFloat = 10
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding)
        ])
    }
    
    @objc func colorButtonPressed(_ sender: GradientButton) {
        sender.bounceAnimation()
        generator.impactOccurred()
        for item in buttonArray {
            item.layer.borderWidth = 0
            item.isSelected        = false
        }
        sender.isSelected          = true
        sender.layer.borderWidth   = 2
        color                      = sender.colors
        
        let index                  = buttonArray.firstIndex(of: sender)!
        delegate?.reloadTableView(colors: color, colorIndex: index)
    }
}

//
//  ColorCell.swift
//  Habits
//
//  Created by Alexander Thompson on 13/8/21.
//

import UIKit

// MARK: - Protocol

protocol passColorsData: AnyObject {
    func passColorsData(colorIndex: Int)
}

class HabitColorCell: UITableViewCell {
    
    // MARK: - Properties
    
    weak var delegate: passColorsData?
    
    static let reuseID = "ColorCell"
    let colorStack     = CustomStackView(axis: .horizontal, distribution: .fillEqually, spacing: 6)
    var buttonArray    = [GradientButton]()
    let generator      = UIImpactFeedbackGenerator(style: .medium)
    
    // MARK: - Class Methods
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        configureColorButtons()
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func configure() {
        generator.prepare()
        backgroundColor          = BackgroundColors.secondaryBackground
        layer.cornerRadius       = 10
    }
    
    private func configureColorButtons() {
        for index in 0...6 {
            let colorButton                = GradientButton(colors: Gradients.array[index])
            colorButton.layer.cornerRadius = 10
            colorButton.layer.borderColor  = UIColor.label.cgColor
            colorButton.addTarget(self, action: #selector(colorButtonPressed), for: .touchUpInside)
            colorStack.addArrangedSubview(colorButton)
            buttonArray.append(colorButton)
        }
    }

    private func layoutUI() {
        contentView.addSubview(colorStack)
        let padding: CGFloat = 10

        NSLayoutConstraint.activate([
            colorStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            colorStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            colorStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            colorStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding)
        ])
    }
    
    // MARK: - @Objc Methods
    @objc func colorButtonPressed(_ sender: GradientButton) {
        sender.bounce()
        generator.impactOccurred()
        for button in buttonArray {
            button.layer.borderWidth = 0
        }
        sender.layer.borderWidth     = 2
        
        if let index = buttonArray.firstIndex(of: sender) {
            delegate?.passColorsData(colorIndex: index)
        }
    }

}

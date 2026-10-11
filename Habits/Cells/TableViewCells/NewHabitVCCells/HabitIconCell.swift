//
//  IconCell.swift
//  Habits
//
//  Created by Alexander Thompson on 13/8/21.
//

import UIKit

// MARK: - Protocol

protocol passIconData: AnyObject {
    func passIconData(iconString: String)
}

class HabitIconCell: UITableViewCell {

    // MARK: - Properties
    let generator      = UIImpactFeedbackGenerator(style: .medium)
    weak var delegate: passIconData?

    static let reuseID = "IconCell"
    let iconStack = CustomStackView(axis: .vertical, distribution: .fillEqually, spacing: 10)
    var buttonArray: [GradientButton] = []

    // MARK: - Class Methods

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        configureStackViews()
        layoutUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods

    private func configure() {
        backgroundColor = BackgroundColors.secondaryBackground
        self.layer.cornerRadius = 10
        generator.prepare()
    }

    private func configureStackViews() {
        for _ in 0...3 {
            let stackView = CustomStackView(axis: .horizontal, distribution: .fillEqually, spacing: 6)

            for _ in 0...6 {
                let iconButton                = GradientButton()
                iconButton.imageEdgeInsets    = UIEdgeInsets(top: 6, left: 9, bottom: 6, right: 9)
                iconButton.layer.cornerRadius = 10
                iconButton.tintColor          = .secondaryLabel
                iconButton.addTarget(self, action: #selector(iconButtonPressed), for: .touchUpInside)

                stackView.addArrangedSubview(iconButton)
                buttonArray.append(iconButton)
            }
            iconStack.addArrangedSubview(stackView)
        }

        for count in 0...buttonArray.count - 1 {
            buttonArray[count].setImage(UIImage(named: Icons.iconArray[count]), for: .normal)
        }
    }

    private func layoutUI() {
        contentView.addSubviews(iconStack)
        let padding: CGFloat = 10

        NSLayoutConstraint.activate([
            iconStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            iconStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            iconStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            iconStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
            iconStack.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 4.5)
        ])
    }

// MARK: - @Objc Methods

    @objc func iconButtonPressed(_ sender: GradientButton) {
        sender.bounce()
        generator.impactOccurred()
        for button in buttonArray {
            button.tintColor  = .secondaryLabel
            button.isSelected = false
            button.colors     = GradientColors.clearGradient
        }

        sender.tintColor  = .white
        sender.colors     = Gradients.darkBlueGradient
        sender.isSelected = true

        for (index, button) in buttonArray.enumerated() {
            if button.isSelected == true {
                delegate?.passIconData(iconString: Icons.iconArray[index])
            }
        }
    }
}

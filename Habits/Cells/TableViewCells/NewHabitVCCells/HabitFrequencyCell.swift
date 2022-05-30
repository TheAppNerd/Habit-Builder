//
//  HabitFrequencyCell.swift
//  Habits
//
//  Created by Alexander Thompson on 13/8/21.
//

import UIKit

// MARK: - Protocol

protocol passFrequencyData: AnyObject {
    func passFrequencyData(frequency: Int)
}

class HabitFrequencyCell: UITableViewCell {

    // MARK: - Properties

    static let reuseID       = "HabitFrequencyCell"
    weak var delegate: passFrequencyData?
    let frequencyStackView   = CustomStackView(axis: .horizontal, distribution: .fillEqually, spacing: 6)
    let generator            = UIImpactFeedbackGenerator(style: .medium)
    var frequencyButtonArray = [GradientButton]()

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
        generator.prepare()
        backgroundColor    = BackgroundColors.secondaryBackground
        layer.cornerRadius = 10

        for count in 0...6 {
            let frequencyButton = GradientButton()
            frequencyButton.layer.cornerRadius = 10
            frequencyButton.setTitleColor(.secondaryLabel, for: .normal)
            frequencyButton.setTitle("\(count + 1)", for: .normal)
            frequencyButton.addTarget(self, action: #selector(frequencyButtonPressed), for: .touchUpInside)
            frequencyButtonArray.append(frequencyButton)
            frequencyStackView.addArrangedSubview(frequencyButton)
        }
    }

    private func layoutUI() {
        contentView.addSubviews(frequencyStackView)
        let padding: CGFloat = 10

        NSLayoutConstraint.activate([
            frequencyStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            frequencyStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            frequencyStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            frequencyStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding)
        ])
    }

    // MARK: - @Objc Methods

    @objc func frequencyButtonPressed(_ sender: GradientButton) {
        sender.bounce()
        generator.impactOccurred()
        for button in frequencyButtonArray {
            button.isSelected = false
            button.setTitleColor(.secondaryLabel, for: .normal)
            button.colors = GradientColors.clearGradient
        }
        sender.isSelected = true
        sender.setTitleColor(.white, for: .normal)
        sender.colors = Gradients.darkBlueGradient

        if let frequency = Int(sender.currentTitle ?? "1") {
            delegate?.passFrequencyData(frequency: frequency)
        }
    }

}

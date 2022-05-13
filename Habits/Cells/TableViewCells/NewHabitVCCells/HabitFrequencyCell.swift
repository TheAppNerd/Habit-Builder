//
//  HabitFrequencyCell.swift
//  Habits
//
//  Created by Alexander Thompson on 13/8/21.
//

import UIKit

protocol passFrequencyData: AnyObject {
    func passFrequencyData(frequency: Int)
}

class HabitFrequencyCell: UITableViewCell {
    
    //MARK: - Properties
    
    // TODO: - move all reuseID's to constants
    weak var delegate: passFrequencyData?
    static let reuseID       = "HabitFrequencyCell"
    let frequencyStackView   = UIStackView()
    let generator            = UIImpactFeedbackGenerator(style: .medium)
    var frequencyButtonArray = [GradientButton]()

    //MARK: - Class Funcs
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Functions
    
    // TODO: move funcs out of cell
    @objc func frequencyButtonPressed(_ sender: GradientButton) {
        sender.bounceAnimation()
        generator.impactOccurred()
        for item in frequencyButtonArray {
            item.isSelected = false
            item.setTitleColor(.secondaryLabel, for: .normal)
            item.colors = GradientColors.clearGradient
        }
        sender.isSelected = true
        sender.setTitleColor(.white, for: .normal)
        sender.colors = Gradients().darkBlueGradient
        
        if let frequency = Int(sender.currentTitle ?? "1") {
        delegate?.passFrequencyData(frequency: frequency)
        }
    }
    
    private func configure() {
        generator.prepare() // TODO: - move this out of here as @objc func is leaving
        backgroundColor                 = BackgroundColors.secondaryBackground
        layer.cornerRadius              = 10
        frequencyStackView.translatesAutoresizingMaskIntoConstraints = false
        frequencyStackView.axis         = .horizontal
        frequencyStackView.distribution = .fillEqually
        frequencyStackView.spacing      = 6
    
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
    
}

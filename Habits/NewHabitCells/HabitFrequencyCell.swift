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
    weak var delegate: passFrequencyData?
    static let reuseID = "HabitFrequencyCell"
    var frequency = 1
    var frequencyArray = [1, 2, 3, 4, 5, 6, 7]
    
    let frequencyStackView = UIStackView()
    let generator            = UIImpactFeedbackGenerator(style: .medium)
    var frequencyButtonArray = [GradientButton]()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        sender.colors = GradientArray.array[0]
        
        //fix this
        frequency = Int(sender.currentTitle!) ?? 1
        delegate?.passFrequencyData(frequency: frequency)
    }
    
    private func configure() {
        backgroundColor = .secondarySystemBackground
        generator.prepare()
        self.layer.cornerRadius = 10
        frequencyStackView.translatesAutoresizingMaskIntoConstraints = false
        frequencyStackView.axis = .horizontal
        frequencyStackView.distribution = .fillEqually
        frequencyStackView.spacing = 6
    
        for count in 0...6 {
            let frequencyButton = GradientButton()
            frequencyButton.layer.cornerRadius = 10
            frequencyButton.setTitleColor(.secondaryLabel, for: .normal)
            frequencyButton.setTitle("\(frequencyArray[count])", for: .normal)
            frequencyButton.addTarget(self, action: #selector(frequencyButtonPressed), for: .touchUpInside)
            frequencyButtonArray.append(frequencyButton)
            frequencyStackView.addArrangedSubview(frequencyButton)
        }
     
        
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

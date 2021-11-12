//
//  HabitDetailsStreakView.swift
//  Habits
//
//  Created by Alexander Thompson on 15/9/21.
//

import UIKit

class HabitDetailsStreakView: UIView {

    let dateCreatedLabel = UILabel()
    let totalCountLabel = UILabel()
    let averageCountLabel = UILabel()
    
    let dateCreatedImage = UIImageView(image: UIImage(systemName: "deskclock")?.addTintGradient(colors: Gradients().purpleGradient))
    let totalCountImage = UIImageView(image: SFSymbols.flame?.addTintGradient(colors: Gradients().orangeGradient))
    let averageCountImage = UIImageView(image: UIImage(systemName: "equal.square.fill")?.addTintGradient(colors: Gradients().darkGreenGradient))
    
    let labelStack = UIStackView()
    let imageStack = UIStackView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLabels(date: String, count: Int, average: String) {
        
        dateCreatedLabel.text = "Date Habit Created: \(date)"
        totalCountLabel.text = "Total Days Completed: \(count)"
        averageCountLabel.text = "Average habits per week: \(average)"
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10
        backgroundColor    = .tertiarySystemBackground
        
        labelStack.translatesAutoresizingMaskIntoConstraints = false
        labelStack.axis = .vertical
        labelStack.distribution = .fillEqually
        labelStack.spacing = 6
        
        imageStack.translatesAutoresizingMaskIntoConstraints = false
        imageStack.axis = .vertical
        imageStack.distribution = .fillEqually
        imageStack.spacing = 6
        
        labelStack.addArrangedSubview(dateCreatedLabel)
        labelStack.addArrangedSubview(totalCountLabel)
        labelStack.addArrangedSubview(averageCountLabel)
        
        imageStack.addArrangedSubview(dateCreatedImage)
        imageStack.addArrangedSubview(totalCountImage)
        imageStack.addArrangedSubview(averageCountImage)
        
        addSubviews(labelStack, imageStack)
        
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            imageStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            imageStack.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            imageStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding),
            imageStack.widthAnchor.constraint(equalToConstant: 30),
            
            
            labelStack.leadingAnchor.constraint(equalTo: imageStack.trailingAnchor, constant: padding),
            labelStack.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            labelStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            labelStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding)
        ])
    }
}

//
//  HabitDetailsStreakView.swift
//  Habits
//
//  Created by Alexander Thompson on 15/9/21.
//

import UIKit

class HabitDetailsStreakView: UIView {

    let dateCreatedLabel = UILabel()
    let dateCreatedResultLabel = UILabel()
    
    let totalCountLabel = UILabel()
    let totalCountResultLabel = UILabel()
    
    let averageCountLabel = UILabel()
    let averageCountResultLabel = UILabel()
    
    
    let labelStack = UIStackView()
    let resultStack = UIStackView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLabels(date: String, count: Int, average: String) {
        dateCreatedResultLabel.text = "\(date)"
        totalCountResultLabel.text = "\(count)"
        averageCountResultLabel.text = "\(average)"
        
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10
        backgroundColor    = .tertiarySystemBackground
        
        dateCreatedLabel.text = "Date Habit Created:"
        totalCountLabel.text = "Total Days Completed:"
        averageCountLabel.text = "Average habits per week:"
        
        dateCreatedResultLabel.textAlignment = .right
        totalCountResultLabel.textAlignment = .right
        averageCountResultLabel.textAlignment = .right
        
        labelStack.translatesAutoresizingMaskIntoConstraints = false
        labelStack.axis = .vertical
        labelStack.distribution = .fillEqually
        labelStack.spacing = 6
        
        resultStack.translatesAutoresizingMaskIntoConstraints = false
        resultStack.axis = .vertical
        resultStack.distribution = .fillEqually
        resultStack.spacing = 6
        
        labelStack.addArrangedSubview(dateCreatedLabel)
        labelStack.addArrangedSubview(totalCountLabel)
        labelStack.addArrangedSubview(averageCountLabel)
        
        resultStack.addArrangedSubview(dateCreatedResultLabel)
        resultStack.addArrangedSubview(totalCountResultLabel)
        resultStack.addArrangedSubview(averageCountResultLabel)
        
        addSubviews(labelStack, resultStack)
        
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            labelStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            labelStack.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            labelStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding),
            labelStack.trailingAnchor.constraint(equalTo: resultStack.leadingAnchor, constant: padding),
            
            resultStack.leadingAnchor.constraint(equalTo: labelStack.trailingAnchor, constant: padding),
            resultStack.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            resultStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            resultStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding)
        ])
    }
}

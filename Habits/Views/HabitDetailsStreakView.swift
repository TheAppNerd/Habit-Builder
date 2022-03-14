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
    
    let streakImage = UIImageView()
    
    
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
    
    func setColor(colors: [CGColor] ) {
        DispatchQueue.main.async {
            self.streakImage.image = UIImage(systemName: "checkmark.square.fill")?.addTintGradient(colors: colors)
            self.dateCreatedResultLabel.textColor = UIColor(cgColor: colors[0])
            self.totalCountResultLabel.textColor = UIColor(cgColor: colors[0])
            self.averageCountResultLabel.textColor = UIColor(cgColor: colors[0])
         
            
        }
    }

    
    private func configure() {
        addShadow()
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10
        backgroundColor    = BackgroundColors.secondaryBackground
        
        
        let line = UIView()
        line.backgroundColor = UIColor.label
        line.translatesAutoresizingMaskIntoConstraints = false
        
        
        streakImage.translatesAutoresizingMaskIntoConstraints = false
        
        let streakLabel = BodyLabel(textInput: "Habit Details", textAlignment: .left, fontSize: 18)
        streakLabel.translatesAutoresizingMaskIntoConstraints = false
        
        dateCreatedLabel.text = "Date Habit Created:"
        totalCountLabel.text = "Total Days Completed:"
        averageCountLabel.text = "Average habits per week:"
        
        dateCreatedLabel.adjustsFontSizeToFitWidth = true
        totalCountLabel.adjustsFontSizeToFitWidth = true
        averageCountLabel.adjustsFontSizeToFitWidth = true
        
        dateCreatedResultLabel.adjustsFontSizeToFitWidth = true
        totalCountResultLabel.adjustsFontSizeToFitWidth = true
        averageCountResultLabel.adjustsFontSizeToFitWidth = true
        
        dateCreatedLabel.font = UIFont.boldSystemFont(ofSize: 16)
        totalCountLabel.font = UIFont.boldSystemFont(ofSize: 16)
        averageCountLabel.font = UIFont.boldSystemFont(ofSize: 16)

        dateCreatedResultLabel.font = UIFont.boldSystemFont(ofSize: 20)
        totalCountResultLabel.font = UIFont.boldSystemFont(ofSize: 20)
        averageCountResultLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        
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
        
        addSubviews(line, streakImage, streakLabel, labelStack, resultStack)
        
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            
            streakImage.topAnchor.constraint(equalTo: self.topAnchor, constant: padding / 2),
            streakImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            streakImage.trailingAnchor.constraint(equalTo: streakLabel.leadingAnchor, constant: -5),
            streakImage.heightAnchor.constraint(equalToConstant: 30),
            streakImage.widthAnchor.constraint(equalToConstant: 30),
            
            streakLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: padding / 2),
            streakLabel.leadingAnchor.constraint(equalTo: streakImage.trailingAnchor, constant: 5),
            streakLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            streakLabel.heightAnchor.constraint(equalToConstant: 40),
            
            line.topAnchor.constraint(equalTo: streakLabel.bottomAnchor, constant: 5),
            line.leadingAnchor.constraint(equalTo: streakImage.leadingAnchor),
            line.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            line.heightAnchor.constraint(equalToConstant: 1),
            
            labelStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            labelStack.topAnchor.constraint(equalTo: line.bottomAnchor, constant: 5),
            labelStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding / 2),
            labelStack.trailingAnchor.constraint(equalTo: resultStack.leadingAnchor, constant: padding),
            
            resultStack.leadingAnchor.constraint(equalTo: labelStack.trailingAnchor, constant: padding),
            resultStack.topAnchor.constraint(equalTo: line.bottomAnchor, constant: 5),
            resultStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            resultStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding / 2)
        ])
    }
}

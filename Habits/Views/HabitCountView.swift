//
//  HabitCountView.swift
//  Habits
//
//  Created by Alexander Thompson on 3/6/21.
//

import UIKit

class HabitCountView: UIView {

    var stackArray: [UIStackView] = []
    let monthArray = ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec",]
    let monthCount = [1,20,5,15,11,3,6,9,1,5,5,3,]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
   configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
    let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        
        for stack in 0...11 {
            let vStackView = UIStackView()
            vStackView.translatesAutoresizingMaskIntoConstraints = false
            vStackView.axis = .vertical
            vStackView.alignment = .fill
            vStackView.distribution = .fillEqually
            vStackView.spacing = 1
            
            let countLabel = UILabel()
            countLabel.translatesAutoresizingMaskIntoConstraints = false
            countLabel.text = "\(monthCount[stack])"
            vStackView.addArrangedSubview(countLabel)
            
            for number in 0...30 {
                let count = UIView()
                count.translatesAutoresizingMaskIntoConstraints = false
                let reverseNumber = 31 - monthCount[stack]
                if number < reverseNumber {
                    count.backgroundColor = .black
                } else {
                        count.backgroundColor = .blue
                    }
                
                vStackView.addArrangedSubview(count)
            }
            let monthLabel = UILabel()
            monthLabel.adjustsFontSizeToFitWidth = true
            monthLabel.translatesAutoresizingMaskIntoConstraints = false
            monthLabel.text = monthArray[stack]
            vStackView.addArrangedSubview(monthLabel)
            
            stackView.addArrangedSubview(vStackView)
        }
 
        self.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
}
}

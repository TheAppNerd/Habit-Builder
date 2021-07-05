//
//  HabitCountView.swift
//  Habits
//
//  Created by Alexander Thompson on 3/6/21.
//

import UIKit

class HabitCountView: UIView {

    let monthArray = ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec",]
    var monthCount = [0,0,0,0,0,0,0,0,0,0,0,0]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
            
    
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     func configureStackView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
    let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        
        let countStack = UIStackView()
            countStack.translatesAutoresizingMaskIntoConstraints = false
        countStack.axis = .horizontal
        countStack.alignment = .fill
        countStack.distribution = .fillEqually
        countStack.spacing = 10
        
        let monthStack = UIStackView()
            monthStack.translatesAutoresizingMaskIntoConstraints = false
        monthStack.axis = .horizontal
        monthStack.alignment = .fill
        monthStack.distribution = .fillEqually
        monthStack.spacing = 10
        
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
            countStack.addArrangedSubview(countLabel)
          
            for number in 0...30 {
                let count = UIView()
                count.translatesAutoresizingMaskIntoConstraints = false
                
                let reverseNumber = 31 - monthCount[stack]
                if number < reverseNumber {
                    count.backgroundColor = .clear
                } else {
                    //add each of these counts to an array to then have each count go from clear to correct color from top to bottom
                        count.alpha = 1
                        count.backgroundColor = .blue
                    
                }
                vStackView.addArrangedSubview(count)
            }
            let monthLabel = UILabel()
            monthLabel.adjustsFontSizeToFitWidth = true
            monthLabel.translatesAutoresizingMaskIntoConstraints = false
            monthLabel.text = monthArray[stack]
            monthStack.addArrangedSubview(monthLabel)

            stackView.addArrangedSubview(vStackView)
        }
       
        addSubview(stackView)
        addSubview(monthStack)
        addSubview(countStack)
        
        NSLayoutConstraint.activate([
            countStack.topAnchor.constraint(equalTo: self.topAnchor),
            countStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            countStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            countStack.bottomAnchor.constraint(equalTo: stackView.topAnchor),
            countStack.heightAnchor.constraint(equalToConstant: 30),
            
            stackView.topAnchor.constraint(equalTo: countStack.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: monthStack.topAnchor),
            
            monthStack.topAnchor.constraint(equalTo: stackView.bottomAnchor),
            monthStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            monthStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            monthStack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            monthStack.heightAnchor.constraint(equalToConstant: 30)
        ])
}
    
    
}

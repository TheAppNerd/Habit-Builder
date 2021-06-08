//
//  HabitCountView.swift
//  Habits
//
//  Created by Alexander Thompson on 3/6/21.
//

import UIKit

class HabitCountView: UIView {

    let verticalStack = UIStackView()
    let horizontalStack = UIStackView()
    
    //instead of vertical stack view. make a view with added labels
    var stackArray: [UIStackView] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        verticalStackView()
        horizontalStackView()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
        addSubview(horizontalStack)
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        
          horizontalStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
          horizontalStack.topAnchor.constraint(equalTo: self.topAnchor),
          horizontalStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
          horizontalStack.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])

    }
    
    private func verticalStackView() {
        verticalStack.translatesAutoresizingMaskIntoConstraints = false
        let monthLabel = UILabel()
        let countLabel = UILabel()
        monthLabel.translatesAutoresizingMaskIntoConstraints = false
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        monthLabel.text = "12"
        countLabel.text = "29"
       
        
        verticalStack.axis = .vertical
        verticalStack.addArrangedSubview(monthLabel)
        for _ in 1...31 {
            let countView = UILabel()
            countView.backgroundColor = .blue
            countView.text = "CV"
            verticalStack.addArrangedSubview(countView)
        }
        verticalStack.addArrangedSubview(countLabel)
        verticalStack.translatesAutoresizingMaskIntoConstraints = false
        verticalStack.distribution = .equalSpacing
        
        for _ in 0...11 {
            stackArray.append(verticalStack)
        }
    }
    
    private func horizontalStackView() {
        horizontalStack.translatesAutoresizingMaskIntoConstraints = false
        horizontalStack.axis = .horizontal
        horizontalStack.translatesAutoresizingMaskIntoConstraints = false
        horizontalStack.distribution = .equalSpacing
        for stack in 0...11 {
            horizontalStack.addArrangedSubview(stackArray[stack])
        }
        
    }
    
}

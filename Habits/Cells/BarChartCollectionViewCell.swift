//
//  BarChartCollectionViewCell.swift
//  Habits
//
//  Created by Alexander Thompson on 24/5/21.
//

import UIKit

class BarChartCollectionViewCell: UICollectionViewCell {
    
    let verticalStack = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        verticalStackView()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    static let reuseID = "CollectionCell"
    
    func horizontalStackView() {
        let horizontalStack = UIStackView()
        let yearLabel = UILabel()
        
    }
    
    private func configure() {
        addSubview(verticalStack)
        
        NSLayoutConstraint.activate([
        
            verticalStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            verticalStack.topAnchor.constraint(equalTo: self.topAnchor),
            verticalStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            verticalStack.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        
        ])
        
    }
    
    
    func verticalStackView() {
        let monthLabel = UILabel()
        let countLabel = UILabel()
        let countView = UIView()
        
        monthLabel.text = "12"
        countLabel.text = "29"
        countView.backgroundColor = .blue
        
        verticalStack.axis = .vertical
        verticalStack.addArrangedSubview(monthLabel)
        for _ in 1...31 {
            verticalStack.addArrangedSubview(countView)
        }
        verticalStack.addArrangedSubview(countLabel)
        
        verticalStack.translatesAutoresizingMaskIntoConstraints = false
        
        verticalStack.distribution = .fill
      
        
    }
    
    
}

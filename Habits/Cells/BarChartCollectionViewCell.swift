//
//  BarChartCollectionViewCell.swift
//  Habits
//
//  Created by Alexander Thompson on 24/5/21.
//

import UIKit

class BarChartCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        verticalStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    static let reuseID = "CollectionCell"
    
    func horizontalStackView() {
        let horizontalStack = UIStackView()
        let yearLabel = UILabel()
        
    }
    
    
    func verticalStackView() {
        let verticalStack = UIStackView()
        let monthLabel = UILabel()
        let countLabel = UILabel()
        let countView = UIView()
        
        
        verticalStack.axis = .vertical
        verticalStack.addArrangedSubview(monthLabel)
        for _ in 1...31 {
            verticalStack.addArrangedSubview(countView)
        }
        verticalStack.addArrangedSubview(countLabel)
        
        verticalStack.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    
}

//
//  ChartCollectionViewCell.swift
//  Habits
//
//  Created by Alexander Thompson on 5/7/21.
//

import UIKit

class ChartCollectionViewCell: UICollectionViewCell {
    
    static let reuseID = "ChartCell"
    
    let chartView = HabitCountView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        addSubview(chartView)
        
        NSLayoutConstraint.activate([
            chartView.topAnchor.constraint(equalTo: self.topAnchor),
            chartView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            chartView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            chartView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
    }
    
}

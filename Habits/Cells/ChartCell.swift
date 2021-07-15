//
//  ChartCell.swift
//  Habits
//
//  Created by Alexander Thompson on 6/7/21.
//

import UIKit

class ChartCell: UICollectionViewCell {
 
    static let reuseID = "ChartCell"
    let habitView = HabitCountView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
      configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
        contentView.addSubview(habitView)
        habitView.frame = contentView.bounds
        habitView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
}

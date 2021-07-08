//
//  ChartCell.swift
//  Habits
//
//  Created by Alexander Thompson on 6/7/21.
//

import UIKit

class ChartCell: UICollectionViewCell {
 
    static let reuseID = "ChartCell"
    
    var cellView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        cellView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(cellView)
       
        NSLayoutConstraint.activate([

            cellView.topAnchor.constraint(equalTo: self.topAnchor),
            cellView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            cellView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
    ])}
}
    
    //complete chart cell. create a view to insert charts.
    
    //build out year array as planned. follow dribble for look.
    


//
//  ChartCellCollectionViewCell.swift
//  Habits
//
//  Created by Alexander Thompson on 29/9/21.
//

import UIKit

class ChartCellCollectionViewCell: UICollectionViewCell {
    
    static let reuseID = "ChartCellCollectionViewCell"
    let stackview = UIStackView()
    var monthlyCountArray = [UILabel]()
    var progressBarArray = [UIProgressView]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //cant use stackview for progress bars. need to use strategic auto layout. have poadding match spacing on top and bottom stackviews. 
    
    func configure() {
    for num in 0...1 {
    let progressBar = UIProgressView()
        progressBar.progress = 0.7
        progressBar.backgroundColor = .red
        progressBar.tintColor = .blue
        progressBar.clipsToBounds = true
        progressBar.transform = CGAffineTransform(rotationAngle: .pi / -2)
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        progressBarArray.append(progressBar)
        stackview.addArrangedSubview(progressBarArray[num])
}
        stackview.axis = .horizontal
        stackview.distribution = .fillEqually
        stackview.spacing = 10

        addSubview(progressBarArray[0])
        NSLayoutConstraint.activate([
            progressBarArray[0].centerXAnchor.constraint(equalTo: self.centerXAnchor),
            progressBarArray[0].centerYAnchor.constraint(equalTo: self.centerYAnchor),
            progressBarArray[0].widthAnchor.constraint(equalTo: self.heightAnchor),
            progressBarArray[0].heightAnchor.constraint(equalToConstant: 15)
        
        ])
}

        }
//create a way to update all the items in a clean pattern

//attempt one. try to build vertical progress bars again. are stack views needed?

//
//  HabitDetailsChartView.swift
//  Habits
//
//  Created by Alexander Thompson on 15/9/21.
//

import UIKit

class HabitDetailsChartView: UIView {
    
    var gradientIndex: Int?
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .tertiarySystemBackground
        self.layer.cornerRadius = 10

        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = .label
        
        let collectionImage = UIImageView(image: UIImage(systemName: "chart.bar.xaxis")?.addTintGradient(colors: GradientArray.array[gradientIndex ?? 0]))
        collectionImage.layer.cornerRadius = 10
        collectionImage.backgroundColor = UIColor.clear
        collectionImage.translatesAutoresizingMaskIntoConstraints = false
        
        let collectionLabel = BodyLabel(textInput: "Monthly Count", textAlignment: .left, fontSize: 18)
        let infoLabel = BodyLabel(textInput: "Swipe to see more", textAlignment: .right, fontSize: 18)
        
        self.addSubviews(collectionImage, collectionLabel, infoLabel, collectionView, line)
        let padding2: CGFloat = 20
        NSLayoutConstraint.activate([
            
            collectionImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding2),
            collectionImage.topAnchor.constraint(equalTo: self.topAnchor, constant: padding2),
            collectionImage.trailingAnchor.constraint(equalTo: collectionLabel.leadingAnchor, constant: -5),
            collectionImage.heightAnchor.constraint(equalToConstant: 30),
            collectionImage.widthAnchor.constraint(equalToConstant: 30),
            
            collectionLabel.leadingAnchor.constraint(equalTo: collectionImage.trailingAnchor, constant: 5),
            collectionLabel.trailingAnchor.constraint(equalTo: infoLabel.leadingAnchor, constant: -padding2),
            collectionLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: padding2),
            collectionLabel.heightAnchor.constraint(equalToConstant: 40),
            
            infoLabel.leadingAnchor.constraint(equalTo: collectionLabel.trailingAnchor, constant: padding2),
            infoLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            infoLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: padding2),
            infoLabel.heightAnchor.constraint(equalToConstant: 40),
            
            line.leadingAnchor.constraint(equalTo: collectionImage.leadingAnchor),
            line.topAnchor.constraint(equalTo: collectionLabel.bottomAnchor, constant: 5),
            line.trailingAnchor.constraint(equalTo: infoLabel.trailingAnchor),
            line.heightAnchor.constraint(equalToConstant: 1),
            
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding2),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding2),
            collectionView.topAnchor.constraint(equalTo: line.bottomAnchor, constant: 5),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20)
        ])
        
    }
}

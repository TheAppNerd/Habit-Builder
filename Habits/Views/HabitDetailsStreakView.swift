//
//  HabitDetailsStreakView.swift
//  Habits
//
//  Created by Alexander Thompson on 15/9/21.
//

import UIKit

class HabitDetailsStreakView: UIView {

    var viewControllerHeight: Int?
    let streakLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10
        backgroundColor    = .tertiarySystemBackground
        
        let streakImage = UIImageView(image: SFSymbols.flame?.addTintGradient(colors: Gradients().orangeGradient))
        streakImage.translatesAutoresizingMaskIntoConstraints = false
        streakLabel.translatesAutoresizingMaskIntoConstraints = false
        streakLabel.textAlignment = .left
        
        self.addSubviews(streakImage, streakLabel)
//        var padding: CGFloat = 0
//        if viewControllerHeight ?? 0 < 800 {
//            padding = 5
//        } else {
        let padding: CGFloat = 20
       // }
       
        NSLayoutConstraint.activate([
        
            streakImage.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            streakImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding * 2),
            streakImage.trailingAnchor.constraint(equalTo: streakLabel.leadingAnchor, constant: -20),
            streakImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding),
            streakImage.widthAnchor.constraint(equalTo: streakImage.heightAnchor),
            
            streakLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            streakLabel.leadingAnchor.constraint(equalTo: streakImage.trailingAnchor, constant: padding),
            streakLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: padding),
            streakLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding)
        ])
    }
}

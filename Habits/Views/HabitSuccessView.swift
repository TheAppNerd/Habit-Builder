//
//  HabitSuccessView.swift
//  Habits
//
//  Created by Alexander Thompson on 1/2/22.
//

import UIKit

class HabitSuccessView: UIView {
    
    let successImage = UIImageView()
    let successTitle = TitleLabel()
    let successlabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(image: String, title: String, colors: [CGColor]) {
        successImage.image = UIImage(named: image)?.addTintGradient(colors: colors)
        successTitle.text = title
    }
    
    
    private func configure() {
        
        self.backgroundColor = .secondarySystemBackground
        self.layer.cornerRadius = 10
        
        successTitle.textAlignment = .left
        successTitle.textColor = .label
        
        successlabel.textAlignment = .left
        successlabel.textColor = .label
        
        
        successImage.translatesAutoresizingMaskIntoConstraints = false
        successTitle.translatesAutoresizingMaskIntoConstraints = false
        successlabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubviews(successImage, successTitle, successlabel)
        
        
        NSLayoutConstraint.activate([
        
        ])
        
    }
    
    
}

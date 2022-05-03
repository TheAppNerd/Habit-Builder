//
//  ScrollViewPage.swift
//  Habits
//
//  Created by Alexander Thompson on 3/5/2022.
//

import UIKit

class ScrollViewPage: UIView {

    //MARK: - Properties
    
    let label     = UILabel()
    let imageView = UIImageView()
  
    //MARK: - Class Funcs
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Functions
    
    private func configure() {
        label.textAlignment             = .center
        label.font                      = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.numberOfLines             = 6
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func layoutUI() {
        let padding: CGFloat = 20
        self.addSubviews(label, imageView)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            label.heightAnchor.constraint(equalToConstant: self.frame.size.height / 6.5),
            
            imageView.topAnchor.constraint(equalTo: label.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding)
        ])
    }
}

//
//  CustomStackView.swift
//  Habits
//
//  Created by Alexander Thompson on 25/5/2022.
//

import UIKit

class CustomStackView: UIStackView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(axis: NSLayoutConstraint.Axis, distribution: UIStackView.Distribution, spacing: CGFloat) {
        self.init(frame: .zero)
        self.axis         = axis
        self.distribution = distribution
        self.spacing      = spacing
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
    }
}

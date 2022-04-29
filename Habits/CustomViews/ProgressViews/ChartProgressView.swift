//
//  ChartProgressView.swift
//  Habits
//
//  Created by Alexander Thompson on 28/4/2022.
//

import UIKit

class ChartProgressView: UIProgressView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 5
        progress           = 0.0
        backgroundColor    = .quaternaryLabel
        tintColor          = .blue
        clipsToBounds      = true
    }
    
}

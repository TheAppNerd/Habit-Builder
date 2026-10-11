//
//  ChartProgressView.swift
//  Habits
//
//  Created by Alexander Thompson on 28/4/2022.
//

import UIKit

class ChartProgressView: UIProgressView {

    // MARK: - Class Methods

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 5
        progress           = 0.0
        backgroundColor    = .quaternaryLabel
        clipsToBounds      = true
    }

}

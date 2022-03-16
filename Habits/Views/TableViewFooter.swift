//
//  TableViewFooter.swift
//  Habits
//
//  Created by Alexander Thompson on 14/9/21.
//

import UIKit

class TableViewFooter: UIView {
    
    //MARK: - Constants
    
    let addHabitButton = UIButton()
    
    //MARK: - Initilisers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Funcs
    
    private func configure() {
        self.frame.size = .init(width: 100, height: 50)
        self.addSubview(addHabitButton)
        addHabitButton.translatesAutoresizingMaskIntoConstraints = false
        addHabitButton.tintColor = .systemGreen
        addHabitButton.setImage(SFSymbols.addHabitButton, for: .normal)
        addHabitButton.setTitle(Labels.tableViewFooterLabel, for: .normal)
        addHabitButton.setTitleColor(.systemGreen, for: .normal)
        
        NSLayoutConstraint.activate([
            addHabitButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            addHabitButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            addHabitButton.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -20),
            addHabitButton.heightAnchor.constraint(equalTo: self.heightAnchor)
        ])
    }
}

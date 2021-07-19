//
//  EmptyStateView.swift
//  Habits
//
//  Created by Alexander Thompson on 20/5/21.
//

import UIKit


class EmptyStateView: UIView {

    let message = TitleLabel(textInput: "", textAlignment: .center, fontSize: 12)
    let imageView = UIImageView()
    let addHabitButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        addSubview(message)
        addSubview(imageView)
        addSubview(addHabitButton)
        message.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addHabitButton.translatesAutoresizingMaskIntoConstraints = false
        
        message.numberOfLines = 4
        message.text = "There are no habits here yet. Press the add habit button to get started"
        imageView.image = UIImage(systemName: "paperplane")
        
        addHabitButton.setTitle("Add Habit", for: .normal)
        addHabitButton.backgroundColor = .systemGreen
        addHabitButton.addTarget(self, action: #selector(addHabitPressed), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
        
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 100),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            
            message.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            message.widthAnchor.constraint(equalToConstant: 100),
            message.heightAnchor.constraint(equalToConstant: 100),
            message.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            addHabitButton.topAnchor.constraint(equalTo: message.bottomAnchor, constant: 10),
            addHabitButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            addHabitButton.widthAnchor.constraint(equalToConstant: 100),
            addHabitButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    
    @objc func addHabitPressed() {
    
        (superview?.next as? UIViewController)?.navigationController!.pushViewController(AddHabitVC(), animated: true)
        
    }
    
    
    
    
    
}

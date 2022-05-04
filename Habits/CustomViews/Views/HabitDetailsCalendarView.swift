//
//  HabitDetailsCalendarView.swift
//  Habits
//
//  Created by Alexander Thompson on 14/9/21.
//

import UIKit
import FSCalendar

class HabitDetailsCalendarView: UIView {
    
    //MARK: - Properties
    
    let calendarView  = FSCalendarView()
    let calendarImage = UIImageView()
    let line          = UIView()
    var calendarLabel = BodyLabel()
    var infoLabel     = BodyLabel()
    
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
    
    func setColor(colors: [CGColor]) {
        DispatchQueue.main.async { [weak self] in
            self?.calendarImage.image = UIImage(systemName: "calendar")?.addTintGradient(colors: colors)
        }
        calendarView.appearance.selectionColor = UIColor(cgColor: colors[0])
    }
    
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius   = 10
        backgroundColor      = BackgroundColors.secondaryBackground
        
        line.backgroundColor = UIColor.label
        line.translatesAutoresizingMaskIntoConstraints = false
        
        calendarLabel = BodyLabel(textInput: "Habit Calendar", textAlignment: .left, fontSize: 18)
        calendarLabel.translatesAutoresizingMaskIntoConstraints = false
        
        infoLabel = BodyLabel(textInput: "Swipe to see more", textAlignment: .right, fontSize: 12)
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        
        calendarImage.layer.cornerRadius = 10
        calendarImage.backgroundColor = UIColor.clear
        calendarImage.translatesAutoresizingMaskIntoConstraints = false
        calendarView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func layoutUI() {
        self.addSubviews(calendarImage, calendarLabel, infoLabel, calendarView, line)
        let padding: CGFloat = 20
        NSLayoutConstraint.activate([
            calendarImage.topAnchor.constraint(equalTo: self.topAnchor, constant: padding / 2),
            calendarImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            calendarImage.trailingAnchor.constraint(equalTo: calendarLabel.leadingAnchor, constant: -5),
            calendarImage.heightAnchor.constraint(equalToConstant: 30),
            calendarImage.widthAnchor.constraint(equalTo: calendarImage.heightAnchor),
            
            calendarLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: padding / 2),
            calendarLabel.leadingAnchor.constraint(equalTo: calendarImage.trailingAnchor, constant: 5),
            calendarLabel.trailingAnchor.constraint(equalTo: infoLabel.leadingAnchor, constant: -padding),
            calendarLabel.heightAnchor.constraint(equalToConstant: 40),
            
            infoLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: padding / 2),
            infoLabel.leadingAnchor.constraint(equalTo: calendarLabel.trailingAnchor, constant: padding),
            infoLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            infoLabel.heightAnchor.constraint(equalToConstant: 40),
            
            line.topAnchor.constraint(equalTo: calendarLabel.bottomAnchor, constant: 5),
            line.leadingAnchor.constraint(equalTo: calendarImage.leadingAnchor),
            line.trailingAnchor.constraint(equalTo: infoLabel.trailingAnchor),
            line.heightAnchor.constraint(equalToConstant: 1),
            
            calendarView.topAnchor.constraint(equalTo: line.bottomAnchor, constant: 5),
            calendarView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            calendarView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            calendarView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
}



//
//  HabitDetailsCalendarView.swift
//  Habits
//
//  Created by Alexander Thompson on 14/9/21.
//

import UIKit
import FSCalendar

class HabitDetailsCalendarView: UIView {
    
    var gradientIndex: Int?
    let calendarView = FSCalendarView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 10
        backgroundColor = .tertiarySystemBackground
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
            line.backgroundColor = UIColor.label
        
            let calendarLabel = BodyLabel(textInput: "Habits Calendar", textAlignment: .left, fontSize: 18)

            let infoLabel = BodyLabel(textInput: "Swipe to see more", textAlignment: .right, fontSize: 18)
            
            let calendarImage = UIImageView(image: UIImage(systemName: "calendar"))
            //?.addTintGradient(colors: GradientArray.array[gradientIndex ?? 0]))
            calendarImage.layer.cornerRadius = 10
            calendarImage.backgroundColor = UIColor.clear
            calendarImage.translatesAutoresizingMaskIntoConstraints = false
            calendarView.translatesAutoresizingMaskIntoConstraints = false
            
        self.addSubviews(calendarImage, calendarLabel, infoLabel, calendarView, line)
            let padding2: CGFloat = 20
            NSLayoutConstraint.activate([
                
                calendarImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding2),
                calendarImage.topAnchor.constraint(equalTo: self.topAnchor, constant: padding2),
                calendarImage.trailingAnchor.constraint(equalTo: calendarLabel.leadingAnchor, constant: -5),
                calendarImage.heightAnchor.constraint(equalToConstant: 30),
                calendarImage.widthAnchor.constraint(equalToConstant: 30),
                
                calendarLabel.leadingAnchor.constraint(equalTo: calendarImage.trailingAnchor, constant: 5),
                calendarLabel.trailingAnchor.constraint(equalTo: infoLabel.leadingAnchor, constant: -padding2),
                calendarLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: padding2),
                calendarLabel.heightAnchor.constraint(equalToConstant: 40),
                
                infoLabel.leadingAnchor.constraint(equalTo: calendarLabel.trailingAnchor, constant: padding2),
                infoLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding2),
                infoLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: padding2),
                infoLabel.heightAnchor.constraint(equalToConstant: 40),
                
                line.leadingAnchor.constraint(equalTo: calendarImage.leadingAnchor),
                line.topAnchor.constraint(equalTo: calendarLabel.bottomAnchor, constant: 5),
                line.trailingAnchor.constraint(equalTo: infoLabel.trailingAnchor),
                line.heightAnchor.constraint(equalToConstant: 1),
                
                calendarView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding2),
                calendarView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding2),
                calendarView.topAnchor.constraint(equalTo: line.bottomAnchor, constant: 10),
                calendarView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            ])
        }
        
 
    
    }
    


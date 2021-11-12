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
    var calendarImage = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setColor(colors: [CGColor]) {
        DispatchQueue.main.async {
            self.calendarImage.image = UIImage(systemName: "calendar")?.addTintGradient(colors: colors)
        }
        calendarView.appearance.selectionColor = UIColor(cgColor: colors[1])
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius   = 10
        backgroundColor      = .tertiarySystemBackground
       
        let line = UIView()
        line.backgroundColor = UIColor.label
        line.translatesAutoresizingMaskIntoConstraints = false
           
        
        let calendarLabel = BodyLabel(textInput: "Habits Calendar", textAlignment: .left, fontSize: 18)
        calendarLabel.translatesAutoresizingMaskIntoConstraints = false

        let infoLabel = BodyLabel(textInput: "Swipe to see more", textAlignment: .right, fontSize: 18)
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
            
        calendarImage.layer.cornerRadius = 10
        calendarImage.backgroundColor = UIColor.clear
        calendarImage.translatesAutoresizingMaskIntoConstraints = false
        calendarView.translatesAutoresizingMaskIntoConstraints = false
            
        self.addSubviews(calendarImage, calendarLabel, infoLabel, calendarView, line)
            let padding: CGFloat = 20
            NSLayoutConstraint.activate([
                
                calendarImage.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
                calendarImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
                calendarImage.trailingAnchor.constraint(equalTo: calendarLabel.leadingAnchor, constant: -5),
                calendarImage.heightAnchor.constraint(equalToConstant: 30),
                calendarImage.widthAnchor.constraint(equalToConstant: 30),
                
                calendarLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
                calendarLabel.leadingAnchor.constraint(equalTo: calendarImage.trailingAnchor, constant: 5),
                calendarLabel.trailingAnchor.constraint(equalTo: infoLabel.leadingAnchor, constant: -padding),
                calendarLabel.heightAnchor.constraint(equalToConstant: 40),
                
                infoLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
                infoLabel.leadingAnchor.constraint(equalTo: calendarLabel.trailingAnchor, constant: padding),
                infoLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
                infoLabel.heightAnchor.constraint(equalToConstant: 40),
                
                line.topAnchor.constraint(equalTo: calendarLabel.bottomAnchor, constant: 5),
                line.leadingAnchor.constraint(equalTo: calendarImage.leadingAnchor),
                line.trailingAnchor.constraint(equalTo: infoLabel.trailingAnchor),
                line.heightAnchor.constraint(equalToConstant: 1),
                
                calendarView.topAnchor.constraint(equalTo: line.bottomAnchor, constant: 10),
                calendarView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
                calendarView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
                calendarView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            ])
        }
    }
    


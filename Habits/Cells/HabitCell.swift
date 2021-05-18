//
//  HabitCell.swift
//  Habits
//
//  Created by Alexander Thompson on 26/4/21.
//

import UIKit
import KDCalendar

class HabitCell: UITableViewCell {

static let reuseID = "HabitCell"
    
    let habitName = TitleLabel(textAlignment: .left, fontSize: 16)
    let streakCount = TitleLabel(textAlignment: .left, fontSize: 10)
    let completionCount = TitleLabel(textAlignment: .center, fontSize: 10)
    let reduceButton = UIButton()
    let completionButton = UIButton()
    let cellView = TableCellView()
    var calendarView = CalendarView()
   
    let labelStackView = UIStackView()
    let buttonStackView = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        configureDays()
        configureLabelStackView()
        configureButtonStackView()
      
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    

    func configureLabelStackView() {
        let dayLabels: [DayLabel] = [ DayLabel(text: "Sun"),
                                      DayLabel(text: "Mon"),
                                      DayLabel(text: "Tue"),
                                      DayLabel(text: "Wed"),
                                      DayLabel(text: "Thur"),
                                      DayLabel(text: "Fri"),
                                      DayLabel(text: "Sat")
        ]
        for label in dayLabels {
            labelStackView.addArrangedSubview(label)
        }
        labelStackView.axis = .horizontal
        labelStackView.spacing = 10
        labelStackView.alignment = .fill
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureButtonStackView() {
        let dayButton: [UIButton] = [ UIButton(),
                                      UIButton(),
                                      UIButton(),
                                      UIButton(),
                                      UIButton(),
                                      UIButton(),
                                      UIButton()
        ]
        for button in dayButton {
            buttonStackView.addArrangedSubview(button)
            buttonStackView.alignment = .center
            button.backgroundColor = .red
        }
        buttonStackView.axis = .horizontal
        buttonStackView.spacing = 10
        buttonStackView.alignment = .center
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureDays() {

        var dateComponents = DateComponents()
        var dailyDateComponents = DateComponents()
        var count = 1
        var dateArray: [Date] = []
            
        switch getDayOfWeek() {
        case 1:
            dateComponents.day = 0
        case 2:
            dateComponents.day = -1
        case 3:
            dateComponents.day = -2
        case 4:
            dateComponents.day = -3
        case 5:
            dateComponents.day = -4
        case 6:
            dateComponents.day = -5
        case 7:
            dateComponents.day = -6
        default:
            print("Error")
        }
        
        let startOfWeek = calendarView.calendar.date(byAdding: dateComponents, to: Date())!
        dateArray.append(startOfWeek)
        for date in dateArray {
        while dateArray.count <= 6 {
            count += 1
            dailyDateComponents.day = count
            dateArray.append(calendarView.calendar.date(byAdding: dailyDateComponents, to: date)!)
        }
        }
    }
    
    func getDayOfWeek() -> Int {
        let myCalendar = Calendar(identifier: .gregorian)
        let today = myCalendar.startOfDay(for: Date())
        let weekDay = myCalendar.component(.weekday, from: today)
        return weekDay
    }
    
    private func configure() {
        contentView.isUserInteractionEnabled = true
        addSubview(cellView)
        addSubview(habitName)
        addSubview(labelStackView)
        addSubview(buttonStackView)
        

        let padding: CGFloat = 20
        
        self.sendSubviewToBack(cellView)
        NSLayoutConstraint.activate([
            
            cellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            cellView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            cellView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            
            habitName.topAnchor.constraint(equalTo: cellView.topAnchor, constant: padding),
            habitName.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: padding),
            habitName.widthAnchor.constraint(equalToConstant: cellView.layer.borderWidth / 2),
            habitName.heightAnchor.constraint(equalToConstant: padding),
        
            labelStackView.topAnchor.constraint(equalTo: habitName.bottomAnchor, constant: padding),
            labelStackView.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: padding),
            labelStackView.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: padding),
            labelStackView.heightAnchor.constraint(equalToConstant: 30),
            
            buttonStackView.topAnchor.constraint(equalTo: labelStackView.bottomAnchor, constant: 10),
            buttonStackView.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: padding),
            buttonStackView.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: padding),
            buttonStackView.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
  
}

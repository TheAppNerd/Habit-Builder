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
    var habitdata = HabitData()
    
    let habitName = TitleLabel(textAlignment: .left, fontSize: 16)
    let streakCount = TitleLabel(textAlignment: .left, fontSize: 10)
    let completionCount = TitleLabel(textAlignment: .center, fontSize: 10)
    let cellView = TableCellView()
    var calendarView = CalendarView()
    var dateArray: [Date] = []
    var dayArray: [Int] = []
    let alarmButton = UIButton()
    let frequencyLabel = BodyLabel()
    let labelStackView = UIStackView()
    let buttonStackView = UIStackView()
    
    let dayButton: [DayButton] = [ DayButton(),
                                   DayButton(),
                                   DayButton(),
                                   DayButton(),
                                   DayButton(),
                                   DayButton(),
                                   DayButton()
    ]
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        configureDays()
        getDay()
        configureLabelStackView()
        configureButtonStackView()
       
    }
    
    override func layoutSubviews() {
            for button in dayButton {
                button.layer.cornerRadius = 0.5 * button.bounds.size.width
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureLabelStackView() {
        let dayLabels: [DayLabel] = [ DayLabel(text: "Sun"),
                                      DayLabel(text: "Mon"),
                                      DayLabel(text: "Tue"),
                                      DayLabel(text: "Wed"),
                                      DayLabel(text: "Thu"),
                                      DayLabel(text: "Fri"),
                                      DayLabel(text: "Sat")
        ]
        for label in dayLabels {
            labelStackView.addArrangedSubview(label)
        }
        labelStackView.axis = .horizontal
        labelStackView.spacing = 10
        labelStackView.distribution = .equalSpacing
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureButtonStackView() {
        
        var count = 0
        for button in dayButton {
            buttonStackView.addArrangedSubview(button)
            buttonStackView.distribution = .equalSpacing
            button.layer.borderWidth = 1.5
            button.setTitle("\(dayArray[count])", for: .normal)
            
            count += 1
        }
        buttonStackView.axis = .horizontal
        buttonStackView.spacing = 10 
        buttonStackView.alignment = .center
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureDays() { //this func works out the weeks dates.

        var dateComponents = DateComponents()
        var dailyDateComponents = DateComponents()
        var count = 0
        
            
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
        func getDay() { //this func takes the weeks dates and converts them to just the months day
            let myCalendar = Calendar(identifier: .gregorian)
            for date in dateArray {
            let day = myCalendar.component(.day, from: date)
            dayArray.append(day)
            }
        }
    
    func getDayOfWeek() -> Int {
        let myCalendar = Calendar(identifier: .gregorian)
        let today = myCalendar.startOfDay(for: Date())
        let weekDay = myCalendar.component(.weekday, from: today)
        print(weekDay)
        return weekDay
    }
    func viewWillLayoutSubviews() {
        
    }
    private func configure() {
        contentView.isUserInteractionEnabled = true
        addSubview(cellView)
        addSubview(habitName)
        addSubview(labelStackView)
        addSubview(buttonStackView)
        addSubview(alarmButton)
        addSubview(frequencyLabel)
        
        alarmButton.setImage(UIImage(systemName: "bell"), for: .normal)
        alarmButton.translatesAutoresizingMaskIntoConstraints = false
        
        frequencyLabel.text = "Everyday"
        
        
        let padding: CGFloat = 20
        
        self.sendSubviewToBack(cellView)
        NSLayoutConstraint.activate([

            cellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            cellView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            cellView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),

            habitName.topAnchor.constraint(equalTo: cellView.topAnchor, constant: padding),
            habitName.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: padding),
            habitName.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -cellView.frame.width / 3),
            habitName.heightAnchor.constraint(equalToConstant: padding),
            
            frequencyLabel.topAnchor.constraint(equalTo: cellView.topAnchor, constant: padding),
            frequencyLabel.trailingAnchor.constraint(equalTo: alarmButton.leadingAnchor, constant: -10),
            frequencyLabel.heightAnchor.constraint(equalToConstant: padding),

            alarmButton.topAnchor.constraint(equalTo: cellView.topAnchor, constant: padding),
            alarmButton.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -padding),
            alarmButton.heightAnchor.constraint(equalToConstant: padding),
            alarmButton.widthAnchor.constraint(equalToConstant: padding),
          

            labelStackView.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: padding),
            labelStackView.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -padding),
            labelStackView.heightAnchor.constraint(equalToConstant: padding),
            labelStackView.bottomAnchor.constraint(equalTo: buttonStackView.topAnchor, constant: -10),

            buttonStackView.heightAnchor.constraint(equalToConstant: 30),
            buttonStackView.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: padding),
            buttonStackView.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -padding),
            buttonStackView.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -10)
       
        ])
        
    }
    
  
}

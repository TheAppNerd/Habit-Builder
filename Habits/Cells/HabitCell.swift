//
//  HabitCell.swift
//  Habits
//
//  Created by Alexander Thompson on 26/4/21.
//

import UIKit

class HabitCell: UITableViewCell {

    
    static let reuseID = "HabitCell"
    
    let habitName          = TitleLabel(textAlignment: .left, fontSize: 22)
    let habitIcon          = UIImageView()
    let habitFrequency     = BodyLabel(textInput: "", textAlignment: .right, fontSize: 18)
    let habitAlarmIcon     = UIImageView()
    var habitGradient      = [CGColor]()
    
    var habitCompletedDays = Int()
    let dateModel          = DateModel()
    let cellView           = UIView()

    let labelStackView    = UIStackView()
    let buttonStackView   = UIStackView()
   
    var dateArray: [Date] = []
    var dayArray: [Int]   = []
    let dayButton: [DayButton] = [DayButton(), DayButton(), DayButton(), DayButton(), DayButton(), DayButton(), DayButton()]
         
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        dateArray = dateModel.configureDays()
        dayArray = dateModel.getDay(dateArray: dateArray)
        configureLabelStackView()
        configureButtonStackView()
        self.selectionStyle = UITableViewCell.SelectionStyle.none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
            for button in dayButton {
                button.layer.cornerRadius = 0.5 * button.bounds.size.width
        }
       layoutGradient()
       cellView.addShadow()
    }
    
 
    func layoutGradient() {
        //prevents gradient changes from cell reuse
        if ((cellView.layer.sublayers?.first as? CAGradientLayer) != nil) {
            cellView.layer.sublayers?.remove(at: 0)
        }
        cellView.addGradient(colors: habitGradient)
    }
    
    
    func set(habit: HabitCoreData) {
        habitName.text = habit.habitName
        habitIcon.image = UIImage(named: habit.iconString ?? "")
        habitFrequency.text = " \(habitCompletedDays) / \(habit.frequency) days "
        
        switch habit.alarmBool {
        case true: habitAlarmIcon.image = SFSymbols.bell
        case false: habitAlarmIcon.image = SFSymbols.bellSlash
        }
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
        labelStackView.alignment = .fill
        labelStackView.distribution = .equalCentering
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        
        //this marks the current day of the week
        dayLabels[dateModel.getDayOfWeek()-1].backgroundColor = UIColor.white.withAlphaComponent(0.3)
    }
    
    
    func configureButtonStackView() {
        for (index, button) in dayButton.enumerated() {
            button.widthAnchor.constraint(equalTo: button.heightAnchor).isActive = true
            buttonStackView.addArrangedSubview(button)
            button.setTitleColor(.white, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
            button.tintColor = .white
            button.layer.borderColor = UIColor.white.cgColor
            button.backgroundColor = .clear
            button.layer.borderWidth = 2
            button.setTitle("\(dayArray[index])", for: .normal)
        }
        
        buttonStackView.axis = .horizontal
        buttonStackView.spacing = 10
        buttonStackView.distribution = .equalCentering
        buttonStackView.alignment = .fill
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
    }
    

    private func configure() {
        contentView.isUserInteractionEnabled = true
        addSubviews(habitIcon, cellView, habitName, labelStackView, buttonStackView, habitAlarmIcon, habitFrequency)
        
        cellView.translatesAutoresizingMaskIntoConstraints = false
        cellView.backgroundColor = .tertiarySystemBackground
        cellView.layer.cornerRadius = 10
        
        habitName.adjustsFontSizeToFitWidth = true
        habitName.minimumScaleFactor = 0.7
        
        habitIcon.translatesAutoresizingMaskIntoConstraints = false
        habitIcon.tintColor = .white
        
        habitFrequency.textColor = .white
        habitFrequency.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        habitFrequency.adjustsFontSizeToFitWidth = true
        habitFrequency.minimumScaleFactor = 0.7
        
        habitAlarmIcon.tintColor = .white
        habitAlarmIcon.image = SFSymbols.bellSlash
        habitAlarmIcon.translatesAutoresizingMaskIntoConstraints = false
        
        let padding: CGFloat = 20
        
        self.sendSubviewToBack(cellView)
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            cellView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            cellView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),

            habitIcon.topAnchor.constraint(equalTo: cellView.topAnchor, constant: padding),
            habitIcon.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: padding),
            habitIcon.trailingAnchor.constraint(equalTo: habitName.leadingAnchor, constant: -10),
            habitIcon.heightAnchor.constraint(equalToConstant: padding * 1.5),
            habitIcon.widthAnchor.constraint(equalTo: habitIcon.heightAnchor),
            
            habitName.topAnchor.constraint(equalTo: cellView.topAnchor, constant: padding),
            habitName.leadingAnchor.constraint(equalTo: habitIcon.trailingAnchor, constant: padding),
            habitName.trailingAnchor.constraint(equalTo: habitFrequency.leadingAnchor, constant: -padding),
            habitName.heightAnchor.constraint(equalToConstant: padding * 1.5),
            
            habitFrequency.leadingAnchor.constraint(equalTo: habitName.trailingAnchor, constant: padding),
            habitFrequency.topAnchor.constraint(equalTo: cellView.topAnchor, constant: padding),
            habitFrequency.trailingAnchor.constraint(equalTo: habitAlarmIcon.leadingAnchor, constant: -10),
            habitFrequency.heightAnchor.constraint(equalToConstant: padding * 1.5),
            habitFrequency.widthAnchor.constraint(equalToConstant: contentView.frame.size.width / 5.5),

            habitAlarmIcon.topAnchor.constraint(equalTo: cellView.topAnchor, constant: padding),
            habitAlarmIcon.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -padding),
            habitAlarmIcon.heightAnchor.constraint(equalToConstant: padding * 1.3),
            habitAlarmIcon.widthAnchor.constraint(equalToConstant: padding * 1.3),
          
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

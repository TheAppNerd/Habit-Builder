//
//  HabitCell.swift
//  Habits
//
//  Created by Alexander Thompson on 26/4/21.
//

import UIKit
import CoreData

class HabitCell: UITableViewCell {
    
    // TODO:  way too much code in here.
    
    //MARK: - Properties
    
    static let reuseID = "HabitCell"
    
    let habitName               = TitleLabel(textAlignment: .left, fontSize: 22)
    let habitIcon               = UIImageView()
    let habitFrequency          = BodyLabel(textInput: "", textAlignment: .center, fontSize: 18)
    let habitAlarmIcon          = UIImageView()
    var habitGradient           = [CGColor]()
    
    var habitCompletedDays      = Int()
    let dateModel               = DateModel()
    let cellView                = UIView()
    
    let labelStackView          = UIStackView()
    let buttonStackView         = UIStackView()
    
    var dateArray: [Date]       = DateModel.weeklyDateArray()
    var dayArray: [Int]         = DateModel.weeklyDayArray()
    var dayButtons: [DayButton] = []
    
    //MARK: - Class Funcs
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        configureLabelStackView()
        configureButtonStackView()
        layoutUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        for button in dayButtons {
            button.layer.cornerRadius = 0.5 * button.bounds.size.width
        }
        layoutGradient()
        cellView.addShadow()
    }
    
    //MARK: - Functions
    
    private func configure() {
        contentView.isUserInteractionEnabled = true
        self.selectionStyle                      = UITableViewCell.SelectionStyle.none
        backgroundColor                          = BackgroundColors.mainBackGround
        
        cellView.translatesAutoresizingMaskIntoConstraints = false
        cellView.backgroundColor                 = BackgroundColors.secondaryBackground
        cellView.layer.cornerRadius              = 10
        
        habitName.adjustsFontSizeToFitWidth      = true
        habitName.minimumScaleFactor             = 0.7
        
        habitIcon.translatesAutoresizingMaskIntoConstraints = false
        habitIcon.tintColor                      = .white
        
        habitFrequency.textColor                 = .white
        habitFrequency.font                      = UIFont.systemFont(ofSize: 12, weight: .bold)
        habitFrequency.adjustsFontSizeToFitWidth = true
        habitFrequency.minimumScaleFactor        = 0.7
        habitFrequency.layer.borderColor         = UIColor.white.cgColor
        habitFrequency.layer.cornerRadius        = 10
        
        habitAlarmIcon.translatesAutoresizingMaskIntoConstraints = false
        habitAlarmIcon.tintColor                 = .white
        habitAlarmIcon.image                     = SFSymbols.bellSlash
    }
    
    ///Prevents gradient changes from cell reuse which is an issue that was occuring.
    func layoutGradient() {
        if ((cellView.layer.sublayers?.first as? CAGradientLayer) != nil) {
            cellView.layer.sublayers?.remove(at: 0)
        }
        cellView.addGradient(colors: habitGradient)
    }
    
    
    ///Called from tableView to fill cell with habit details.
    func set(habit: HabitEnt) {
        habitName.text      = habit.name ?? ""
        habitIcon.image     = UIImage(named: habit.icon ?? "")
        habitFrequency.text = " \(habitCompletedDays) / \(habit.frequency) days  "
        habitGradient       = gradients.array[Int(habit.gradient)]
        
        let intFrequency    = Int(habit.frequency)
        if habitCompletedDays >= intFrequency {
            habitFrequency.layer.borderWidth = 1.5
        } else if habitCompletedDays < intFrequency {
            habitFrequency.layer.borderWidth = 0.0
        }
        
        switch habit.notificationBool {
        case true: habitAlarmIcon.image  = SFSymbols.bell
        case false: habitAlarmIcon.image = SFSymbols.bellSlash
        }
    }
    
    func configureLabelStackView() {
        var dayLabels: [DayLabel] = []
        
        for index in 0...6 {
            let daylabel = DayLabel(text: Labels.daysArray[index])
            dayLabels.append(daylabel)
            labelStackView.addArrangedSubview(daylabel)
        }
        
        labelStackView.axis         = .horizontal
        labelStackView.spacing      = 10
        labelStackView.alignment    = .fill
        labelStackView.distribution = .equalCentering
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        
        //this marks the current day of the week with a different background colour.
        dayLabels[DateModel.getDayOfWeek()-1].backgroundColor = UIColor.white.withAlphaComponent(0.3)
    }
    
    // TODO: add a view behind buttons to make ti easier to select them without going to details screen.
    func configureButtonStackView() {
        for index in 0...6 {
            let dayButton = DayButton()
            dayButton.widthAnchor.constraint(equalTo: dayButton.heightAnchor).isActive = true
            dayButton.setTitle("\(dayArray[index])", for: .normal)
            buttonStackView.addArrangedSubview(dayButton)
            dayButtons.append(dayButton)
        }
        
        buttonStackView.axis = .horizontal
        buttonStackView.spacing = 10
        buttonStackView.distribution = .equalCentering
        buttonStackView.alignment = .fill
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    private func layoutUI() {
        addSubviews(habitIcon, cellView, habitName, labelStackView, buttonStackView, habitAlarmIcon, habitFrequency)
        self.sendSubviewToBack(cellView)
        let padding: CGFloat = 20
        
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
            
            habitAlarmIcon.topAnchor.constraint(equalTo: cellView.topAnchor, constant: padding * 1.2 ),
            habitAlarmIcon.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -padding),
            habitAlarmIcon.heightAnchor.constraint(equalToConstant: padding),
            habitAlarmIcon.widthAnchor.constraint(equalToConstant: padding),
            
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

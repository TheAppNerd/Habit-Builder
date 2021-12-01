//
//  HabitCell.swift
//  Habits
//
//  Created by Alexander Thompson on 26/4/21.
//

import UIKit

class HabitCell: UITableViewCell {

    //move all calculations to model. nothing but view setup in here. 
    
static let reuseID = "HabitCell"
    
   
    
    let habitName         = TitleLabel(textInput: "", textAlignment: .left, fontSize: 22)
    let habitIcon         = UIImageView()
    var habitGradient     = [CGColor]()
    let habitFrequency    = BodyLabel(textInput: "", textAlignment: .right, fontSize: 18)
    let habitAlarmIcon    = UIImageView()
    var habitCompletedDays = Int()
    
    
    
    
    let dateModel         = DateModel()
    let cellView          = UIView()

    
    
    let labelStackView    = UIStackView()
    let buttonStackView   = UIStackView()
   
    var dateArray: [Date] = []
    var dayArray: [Int]   = []
    var calendarView      = Calendar.current
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
        dateArray = dateModel.configureDays()
        dayArray = dateModel.getDay(dateArray: dateArray)
        configureLabelStackView()
        configureButtonStackView()
        self.selectionStyle = UITableViewCell.SelectionStyle.none
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
            for button in dayButton {
                button.layer.cornerRadius = 0.5 * button.bounds.size.width
        }
       layoutGradient()
        configureShadow()
    }
    
    func layoutGradient() {
        
        //prevents gradient changers from cell reuse
        if ((cellView.layer.sublayers?.first as? CAGradientLayer) != nil) {
            cellView.layer.sublayers?.remove(at: 0)
        }
        //make an extension instead
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.frame = cellView.bounds
        gradientLayer.startPoint = CGPoint(x: 1, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        gradientLayer.cornerRadius = cellView.layer.cornerRadius
        gradientLayer.colors = habitGradient
        cellView.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func configureShadow() { //rastersize to reduce memory?
        cellView.layer.shadowPath = UIBezierPath(roundedRect: cellView.bounds, cornerRadius: 10).cgPath
        cellView.layer.shadowRadius = 5
        cellView.layer.shadowOffset = .zero
        cellView.layer.shadowOpacity = 0.7
        cellView.layer.shadowColor = UIColor.label.cgColor
    }
    
    func set(habit: HabitCoreData) {
        habitName.text = habit.habitName
        habitIcon.image = UIImage(named: habit.iconString ?? "")
       //habitGradient  = GradientArray.array[Int(habit.habitGradientIndex)]
        habitFrequency.text = "\(habitCompletedDays) / \(habit.frequency) days"
        
        switch habit.alarmBool {
        case true: habitAlarmIcon.image = SFSymbols.bell
        case false: habitAlarmIcon.image = SFSymbols.bellSlash
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
        labelStackView.alignment = .fill
        labelStackView.distribution = .equalCentering
        labelStackView.translatesAutoresizingMaskIntoConstraints = false

        //dayLabels[dateModel.getDayOfWeek()-1].textColor = .white
        //dayLabels[dateModel.getDayOfWeek()-1].font = UIFont.systemFont(ofSize: 18, weight: .bold)
        dayLabels[dateModel.getDayOfWeek()-1].backgroundColor = UIColor.white.withAlphaComponent(0.3)
        dayLabels[dateModel.getDayOfWeek()-1].layer.masksToBounds = true
        dayLabels[dateModel.getDayOfWeek()-1].layer.cornerRadius = 5
    }
    
    func configureButtonStackView() {
        
        var count = 0
        for button in dayButton {
            button.widthAnchor.constraint(equalTo: button.heightAnchor).isActive = true
            buttonStackView.addArrangedSubview(button)
            button.setTitleColor(.white, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
            button.tintColor = .white
            button.layer.borderColor = UIColor.white.cgColor
            button.backgroundColor = .clear
            button.layer.borderWidth = 2
            button.setTitle("\(dayArray[count])", for: .normal)

            
            count += 1
        }
        buttonStackView.axis = .horizontal
        buttonStackView.spacing = 10
        buttonStackView.distribution = .equalCentering
        buttonStackView.alignment = .fill
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
    }
    

    private func configure() {
        contentView.isUserInteractionEnabled = true
        addSubview(habitIcon)
        addSubview(cellView)
        addSubview(habitName)
        addSubview(labelStackView)
        addSubview(buttonStackView)
        addSubview(habitAlarmIcon)
        addSubview(habitFrequency)
        cellView.translatesAutoresizingMaskIntoConstraints = false
        cellView.backgroundColor = .tertiarySystemBackground
        
        habitIcon.translatesAutoresizingMaskIntoConstraints = false
        habitIcon.tintColor = .white
        habitFrequency.textColor = .white
        habitFrequency.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        
        habitName.adjustsFontSizeToFitWidth = true
        habitName.minimumScaleFactor = 0.7 
        habitFrequency.adjustsFontSizeToFitWidth = true
        habitFrequency.minimumScaleFactor = 0.7
      
        
        cellView.layer.cornerRadius = 10
        habitAlarmIcon.tintColor = .white
        habitAlarmIcon.image = UIImage(systemName: "bell.slash.fill")
        habitAlarmIcon.translatesAutoresizingMaskIntoConstraints = false
        
        //frequencyLabel.text = "Everyday"
        
        
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

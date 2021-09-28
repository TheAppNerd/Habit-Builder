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
    
    let dateModel         = DateModel()
    let habitName         = TitleLabel(textInput: "", textAlignment: .left, fontSize: 22)
    let cellView          = UIView()
    let iconImage         = UIImageView()
    let alarmImage        = UIImageView()
    let frequencyLabel    = BodyLabel()
    let labelStackView    = UIStackView()
    let buttonStackView   = UIStackView()
    var gradientColors    = [CGColor]()
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
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.frame = cellView.bounds
        gradientLayer.startPoint = CGPoint(x: 1, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        gradientLayer.cornerRadius = cellView.layer.cornerRadius
        gradientLayer.colors = gradientColors
        cellView.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func configureShadow() { //rastersize to reduce memory?
        cellView.layer.shadowPath = UIBezierPath(roundedRect: cellView.bounds, cornerRadius: 10).cgPath
        cellView.layer.shadowRadius = 5
        cellView.layer.shadowOffset = .zero
        cellView.layer.shadowOpacity = 0.7
        cellView.layer.shadowColor = UIColor.label.cgColor
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

        dayLabels[dateModel.getDayOfWeek()-1].textColor = .white
        dayLabels[dateModel.getDayOfWeek()-1].font = UIFont.systemFont(ofSize: 18, weight: .bold)

        
    }
    
    func configureButtonStackView() {
        
        var count = 0
        for button in dayButton {
            button.widthAnchor.constraint(equalTo: button.heightAnchor).isActive = true
            buttonStackView.addArrangedSubview(button)
            button.setTitleColor(.white, for: .normal)
            button.tintColor = .white
            button.layer.borderColor = UIColor.white.cgColor
            button.backgroundColor = .clear
            button.layer.borderWidth = 1.5
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
        addSubview(iconImage)
        addSubview(cellView)
        addSubview(habitName)
        addSubview(labelStackView)
        addSubview(buttonStackView)
        addSubview(alarmImage)
        addSubview(frequencyLabel)
        cellView.translatesAutoresizingMaskIntoConstraints = false
        cellView.backgroundColor = .tertiarySystemBackground
        
        iconImage.translatesAutoresizingMaskIntoConstraints = false
        iconImage.tintColor = .white
        frequencyLabel.textColor = .white
        
        habitName.adjustsFontSizeToFitWidth = true
        habitName.minimumScaleFactor = 0.7 
        frequencyLabel.adjustsFontSizeToFitWidth = true
        frequencyLabel.minimumScaleFactor = 0.7
      
        
        cellView.layer.cornerRadius = 10
        alarmImage.tintColor = .white
        alarmImage.image = UIImage(systemName: "bell.slash.fill")
        alarmImage.translatesAutoresizingMaskIntoConstraints = false
        
        //frequencyLabel.text = "Everyday"
        
        
        let padding: CGFloat = 20
        
        self.sendSubviewToBack(cellView)
        NSLayoutConstraint.activate([

            cellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            cellView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            cellView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),

            iconImage.topAnchor.constraint(equalTo: cellView.topAnchor, constant: padding),
            iconImage.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: padding),
            iconImage.trailingAnchor.constraint(equalTo: habitName.leadingAnchor, constant: -10),
            iconImage.heightAnchor.constraint(equalToConstant: padding * 1.5),
            iconImage.widthAnchor.constraint(equalTo: iconImage.heightAnchor),
            
            habitName.topAnchor.constraint(equalTo: cellView.topAnchor, constant: padding),
            habitName.leadingAnchor.constraint(equalTo: iconImage.trailingAnchor, constant: padding),
            habitName.trailingAnchor.constraint(equalTo: frequencyLabel.leadingAnchor, constant: -padding),
            habitName.heightAnchor.constraint(equalToConstant: padding * 1.5),
            
            frequencyLabel.leadingAnchor.constraint(equalTo: habitName.trailingAnchor, constant: padding),
            frequencyLabel.topAnchor.constraint(equalTo: cellView.topAnchor, constant: padding),
            frequencyLabel.trailingAnchor.constraint(equalTo: alarmImage.leadingAnchor, constant: -10),
            frequencyLabel.heightAnchor.constraint(equalToConstant: padding * 1.5),
            frequencyLabel.widthAnchor.constraint(equalToConstant: contentView.frame.size.width / 5.5),

            alarmImage.topAnchor.constraint(equalTo: cellView.topAnchor, constant: padding),
            alarmImage.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -padding),
            alarmImage.heightAnchor.constraint(equalToConstant: padding * 1.5),
            alarmImage.widthAnchor.constraint(equalToConstant: padding * 1.5),
          
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

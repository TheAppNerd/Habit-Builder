//
//  ReminderCell.swift
//  Habits
//
//  Created by Alexander Thompson on 13/8/21.
//

import UIKit

protocol passDayData: AnyObject {
    func passDayData(dayArray: [Bool])
}

class ReminderCell: UITableViewCell {
  
  
    

 static let reuseID = "ReminderCell"
    
    var dayArray: [Bool] = [false, false, false, false, false, false, false]
    let datePicker = UIDatePicker()
    let dateSegment = UISegmentedControl(items: ["Alarm Off", "Alarm On"])
    let stackView = UIStackView()
    weak var delegate: passDayData?
    var hour = Int()
    var minute = Int()
    
    let weekArray = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    var buttonArray = [GradientButton]()
    
    var colors = [CGColor]()
    
    var noColors = [UIColor.clear.cgColor, UIColor.clear.cgColor]
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func timeChanged() {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        let dateAsString = formatter.string(from: datePicker.date)

        let date = formatter.date(from: dateAsString)
        formatter.dateFormat = "HH:mm"

        let twentyFourHourDate = formatter.string(from: date!)
        let time = twentyFourHourDate.components(separatedBy: ":")
        hour = Int(time[0])!
        minute = Int(time[1])!
    }
    

    
    @objc func dateSegmentChanged(_ sender: UISegmentedControl) {
//        if dateSwitch.isOn == true {
//            habitData.alarmBool = true
//            bellImage.image = UIImage(systemName: "bell.fill")
//        } else if dateSwitch.isOn == false {
//            habitData.alarmBool = false
//            bellImage.image = UIImage(systemName: "bell.slash")
//            userNotifications.scheduleNotification(title: habitNameTextField.text!, hour: hour, minute: minute, onOrOff: false)
//
    }
    
    private func configure() {
    
        datePicker.datePickerMode = .time
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.addTarget(self, action: #selector(timeChanged), for: .valueChanged)
        
        dateSegment.layer.cornerRadius = 10
        dateSegment.translatesAutoresizingMaskIntoConstraints = false
        dateSegment.selectedSegmentTintColor = .systemBlue
        dateSegment.addTarget(self, action: #selector(dateSegmentChanged), for: .valueChanged)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 6
        
        for button in 0...6 {
            let dayButton = GradientButton()
            dayButton.addTarget(self, action: #selector(dayButtonpressed), for: .touchUpInside)
            dayButton.setTitle(weekArray[button], for: .normal)
            dayButton.backgroundColor = .secondarySystemBackground
            dayButton.setTitleColor(.secondaryLabel, for: .normal)
            dayButton.layer.cornerRadius = 10
            stackView.addArrangedSubview(dayButton)
            buttonArray.append(dayButton)
        }
        
        contentView.addSubviews(datePicker, stackView, dateSegment)
        
        let padding: CGFloat = 10
        
        NSLayoutConstraint.activate([
            
            datePicker.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            datePicker.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            datePicker.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -padding),
            datePicker.trailingAnchor.constraint(equalTo: dateSegment.leadingAnchor, constant: -padding),
            datePicker.heightAnchor.constraint(equalToConstant: 40),
       
            
            dateSegment.leadingAnchor.constraint(equalTo: datePicker.trailingAnchor, constant: padding),
            dateSegment.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            dateSegment.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -padding),
            dateSegment.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
          
           
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            stackView.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
            stackView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
   
    
    @objc func dayButtonpressed(_ sender: GradientButton) {
        sender.bounceAnimation()
        sender.isSelected.toggle()
        for (index, button) in buttonArray.enumerated() {
            if button.isSelected == false {
            button.setTitleColor(.secondaryLabel, for: .normal)
            button.isSelected = false
                button.backgroundColor = .secondarySystemBackground
            button.colors = noColors
                dayArray[index] = false
            } else {
                button.setTitleColor(.label, for: .normal)
                button.backgroundColor = .clear
                button.colors = Gradients().blueGradient
                dayArray[index] = true
            }
        }
        
        delegate?.passDayData(dayArray: dayArray)
        
    }
}


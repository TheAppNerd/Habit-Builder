//
//  ReminderCell.swift
//  Habits
//
//  Created by Alexander Thompson on 13/8/21.
//

import UIKit

class ReminderCell: UITableViewCell {

 static let reuseID = "ReminderCell"
    
    let datePicker = UIDatePicker()
    let dateSegment = UISegmentedControl(items: ["Alarm Off", "Alarm On"])
    let stackView = UIStackView()
    
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
            dayButton.setTitle(weekArray[button], for: .normal)
            dayButton.backgroundColor = .secondarySystemBackground
            dayButton.layer.cornerRadius = 10
            dayButton.setTitleColor(.secondaryLabel, for: .normal)
            dayButton.addTarget(self, action: #selector(dayButtonpressed), for: .touchUpInside)
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
            //datePicker.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),
            
            
            dateSegment.leadingAnchor.constraint(equalTo: datePicker.trailingAnchor, constant: padding),
            dateSegment.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            dateSegment.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -padding),
            dateSegment.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
           // dateSegment.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),
            
           
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            stackView.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
            stackView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    @objc func dayButtonpressed(_ sender: GradientButton) {
        sender.isSelected.toggle()
//        for item in buttonArray {
//            if item.isSelected == false {
//                item.setTitleColor(.secondaryLabel, for: .normal)
//                item.colors = noColors
            //}
       // }
        if sender.isSelected == true {
        sender.setTitleColor(.label, for: .normal)
            sender.colors = colors
        } else if sender.isSelected == false {
            sender.setTitleColor(.secondaryLabel, for: .normal)
            sender.colors = noColors
        }
        print(sender.isSelected)
        
    }
}


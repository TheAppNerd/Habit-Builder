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
    let dateSwitch = UISwitch()
    let bellImage = UIImageView()
    let stackView = UIStackView()
    
    let weekArray = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        datePicker.datePickerMode = .time
        datePicker.preferredDatePickerStyle = .inline
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        
        dateSwitch.preferredStyle = .sliding
        dateSwitch.translatesAutoresizingMaskIntoConstraints = false
        
        bellImage.translatesAutoresizingMaskIntoConstraints = false
        bellImage.image = UIImage(systemName: "bell")
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 3
        
        for button in 0...6 {
            let dayButton = UIButton()
            dayButton.setTitle(weekArray[button], for: .normal)
            stackView.addArrangedSubview(dayButton)
        }
        
        contentView.addSubviews(datePicker, dateSwitch, bellImage, stackView)
        
        let padding: CGFloat = 10
        
        NSLayoutConstraint.activate([
            
            datePicker.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            datePicker.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            //datePicker.trailingAnchor.constraint(equalTo: dateSwitch.leadingAnchor, constant: -padding),
            datePicker.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -padding),
            datePicker.heightAnchor.constraint(equalToConstant: 50),
            
            //dateSwitch.leadingAnchor.constraint(equalTo: datePicker.trailingAnchor, constant: padding),
            dateSwitch.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding * 2),
            dateSwitch.trailingAnchor.constraint(equalTo: bellImage.leadingAnchor, constant: -padding),
            dateSwitch.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -padding),
            
            bellImage.leadingAnchor.constraint(equalTo: dateSwitch.trailingAnchor, constant: padding),
            bellImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding * 2),
            bellImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            bellImage.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -padding * 2),
            bellImage.widthAnchor.constraint(equalTo: bellImage.heightAnchor),
            
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            stackView.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
            stackView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
}

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
    var buttonArray = [UIButton]()
    
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
        stackView.spacing = 6
        
        for button in 0...6 {
            let dayButton = UIButton()
            dayButton.setTitle(weekArray[button], for: .normal)
            dayButton.backgroundColor = .tertiarySystemBackground
            dayButton.layer.cornerRadius = 10
            dayButton.setTitleColor(.secondaryLabel, for: .normal)
            dayButton.addTarget(self, action: #selector(dayButtonpressed), for: .touchUpInside)
            stackView.addArrangedSubview(dayButton)
            buttonArray.append(dayButton)
        }
        
        contentView.addSubviews(datePicker, dateSwitch, bellImage, stackView)
        
        let padding: CGFloat = 10
        
        NSLayoutConstraint.activate([
            
            datePicker.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            datePicker.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            //datePicker.trailingAnchor.constraint(equalTo: dateSwitch.leadingAnchor, constant: -padding),
            datePicker.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -padding),
            datePicker.heightAnchor.constraint(equalToConstant: 40),
            
            //dateSwitch.leadingAnchor.constraint(equalTo: datePicker.trailingAnchor, constant: padding),
            dateSwitch.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding * 1.5),
            dateSwitch.trailingAnchor.constraint(equalTo: bellImage.leadingAnchor, constant: -padding),
            dateSwitch.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -padding),
            
            bellImage.leadingAnchor.constraint(equalTo: dateSwitch.trailingAnchor, constant: padding),
            bellImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            bellImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            bellImage.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -padding),
            bellImage.widthAnchor.constraint(equalTo: bellImage.heightAnchor),
            
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            stackView.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
            stackView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    @objc func dayButtonpressed(_ sender: UIButton) {
        sender.isSelected.toggle()
        
        if sender.isSelected == true {
        sender.setTitleColor(.label, for: .normal)
        sender.layer.borderWidth = 1
        sender.layer.borderColor = UIColor.label.cgColor
        } else {
            sender.layer.borderWidth = 0
            sender.setTitleColor(.secondaryLabel, for: .normal)
        }
    }
}

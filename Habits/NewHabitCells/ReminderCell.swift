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
    let generator            = UIImpactFeedbackGenerator(style: .medium)
    weak var delegate: passDayData?
    
    let datePicker       = DatePicker()
    let dateSegment      = UISegmentedControl(items: ["Alarm Off", "Alarm On"])
    let stackView        = UIStackView() //rename
    let weekArray        = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    
    var dayArray: [Bool] = [false, false, false, false, false, false, false]
    var hour             = Int()
    var minute           = Int()
    var buttonArray      = [GradientButton]()
    var colors           = [CGColor]()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func timeChanged() {
        let formatter          = DateFormatter()
        formatter.dateFormat   = "h:mm a"
        let dateAsString       = formatter.string(from: datePicker.date)

        let date               = formatter.date(from: dateAsString)
        formatter.dateFormat   = "HH:mm"

        let twentyFourHourDate = formatter.string(from: date!)
        let time               = twentyFourHourDate.components(separatedBy: ":")
        hour                   = Int(time[0])!
        minute                 = Int(time[1])!
    }

    
    private func configure() {
        backgroundColor = .secondarySystemBackground
        self.layer.cornerRadius = 10
        generator.prepare()
        datePicker.addTarget(self, action: #selector(timeChanged), for: .valueChanged)
        
        dateSegment.translatesAutoresizingMaskIntoConstraints = false
        dateSegment.layer.cornerRadius       = 10
        dateSegment.selectedSegmentTintColor = .systemBlue
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis         = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing      = 6
        
        for button in 0...6 {
            let dayButton = GradientButton()
            dayButton.addTarget(self, action: #selector(dayButtonpressed), for: .touchUpInside)
            dayButton.setTitle(weekArray[button], for: .normal)
            dayButton.setTitleColor(.secondaryLabel, for: .normal)
            dayButton.backgroundColor    = .secondarySystemBackground
            dayButton.layer.cornerRadius = 10
            
            stackView.addArrangedSubview(dayButton)
            buttonArray.append(dayButton)
        }
        
        contentView.addSubviews(datePicker, stackView, dateSegment)
        
        let padding: CGFloat = 10
        
        NSLayoutConstraint.activate([
            datePicker.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            datePicker.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            datePicker.trailingAnchor.constraint(equalTo: dateSegment.leadingAnchor, constant: -padding),
            datePicker.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -padding),
            datePicker.heightAnchor.constraint(equalToConstant: 40),
       
            dateSegment.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            dateSegment.leadingAnchor.constraint(equalTo: datePicker.trailingAnchor, constant: padding),
            dateSegment.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            dateSegment.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -padding),

            stackView.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
            stackView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    
    @objc func dayButtonpressed(_ sender: GradientButton) {
        sender.bounceAnimation()
        generator.impactOccurred()
        sender.isSelected.toggle()
        
        for (index, button) in buttonArray.enumerated() {
            if button.isSelected == false {
            button.setTitleColor(.secondaryLabel, for: .normal)
            button.isSelected = false
                button.backgroundColor = .secondarySystemBackground
                button.colors          = GradientColors.clearGradient
                dayArray[index]        = false
            } else {
                button.setTitleColor(.white, for: .normal)
                button.backgroundColor = .clear
                button.colors          = Gradients().blueGradient
                dayArray[index]        = true
            }
        }
        delegate?.passDayData(dayArray: dayArray)
    }
}


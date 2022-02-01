//
//  ReminderCell.swift
//  Habits
//
//  Created by Alexander Thompson on 13/8/21.
//

import UIKit

protocol passDayData: AnyObject {
    func passDayData(dayArray: String)
}

class HabitReminderCell: UITableViewCell {
    
    static let reuseID = "ReminderCell"
    
    let generator            = UIImpactFeedbackGenerator(style: .medium)
    weak var delegate: passDayData?
    
    let datePicker       = DatePicker()
    let dateSegment      = UISegmentedControl(items: ["Alarm Off", "Alarm On"])
    let dayStackView        = UIStackView() //rename
    
    
    
    var hour             = Int()
    var minute           = Int()
    var buttonArray      = [GradientButton]()
    var colors           = [CGColor]()
    let rectangleGradient     = UIImage(systemName: "rectangle.fill")?.addTintGradient(colors: GradientArray.array[5])
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func timeChanged() {
        let time = DateFuncs.timeChanged(datePicker: datePicker)
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
        dateSegment.layer.borderWidth = 1.5
        dateSegment.layer.borderColor = GradientArray.array[5][0]
        dateSegment.setGradientColors()
        
        dayStackView.translatesAutoresizingMaskIntoConstraints = false
        dayStackView.axis         = .horizontal
        dayStackView.distribution = .fillEqually
        dayStackView.spacing      = 6
        
        let weekArray = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
        for index in 0...6 {
            let dayButton = GradientButton()
            dayButton.addTarget(self, action: #selector(dayButtonpressed), for: .touchUpInside)
            dayButton.setTitle(weekArray[index], for: .normal)
            dayButton.setTitleColor(.secondaryLabel, for: .normal)
            dayButton.backgroundColor    = .secondarySystemBackground
            dayButton.layer.cornerRadius = 10
            
            dayStackView.addArrangedSubview(dayButton)
            buttonArray.append(dayButton)
        }
        
        contentView.addSubviews(datePicker, dayStackView, dateSegment)
        
        let padding: CGFloat = 10
        
        NSLayoutConstraint.activate([
            datePicker.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            datePicker.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            datePicker.trailingAnchor.constraint(equalTo: dateSegment.leadingAnchor, constant: -padding),
            datePicker.bottomAnchor.constraint(equalTo: dayStackView.topAnchor, constant: -padding),
            datePicker.heightAnchor.constraint(equalToConstant: 45),
            
            dateSegment.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            dateSegment.leadingAnchor.constraint(equalTo: datePicker.trailingAnchor, constant: padding),
            dateSegment.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            dateSegment.bottomAnchor.constraint(equalTo: dayStackView.topAnchor, constant: -padding),
            
            dayStackView.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: padding),
            dayStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            dayStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            dayStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
            dayStackView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    
    @objc func dayButtonpressed(_ sender: GradientButton) {
        sender.bounceAnimation()
        generator.impactOccurred()
        sender.isSelected.toggle()
        var stringWeek: String = ""
        var dayArray: [String] = ["", "", "", "", "", "", ""]
        
        for (index, button) in buttonArray.enumerated() {
            if button.isSelected == false {
                button.setTitleColor(.secondaryLabel, for: .normal)
                button.backgroundColor = .secondarySystemBackground
                button.colors          = GradientColors.clearGradient
                dayArray[index]        = "f"
            } else {
                button.setTitleColor(.white, for: .normal)
                button.backgroundColor = .clear
                button.colors          = Gradients().darkBlueGradient
                dayArray[index]        = "t"
            }
            stringWeek = dayArray.joined(separator: "")
            
        }
        print("string\(stringWeek)")
        delegate?.passDayData(dayArray: stringWeek)
    }
}


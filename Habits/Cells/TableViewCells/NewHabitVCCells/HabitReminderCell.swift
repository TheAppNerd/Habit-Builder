//
//  ReminderCell.swift
//  Habits
//
//  Created by Alexander Thompson on 13/8/21.
//

import UIKit

// MARK: - Protocol

protocol passDayData: AnyObject {
    func passDayData(dayArray: String)
}

class HabitReminderCell: UITableViewCell {

    // MARK: - Properties

    static let reuseID    = "ReminderCell"
    weak var delegate: passDayData?
    let generator         = UIImpactFeedbackGenerator(style: .medium)
    let datePicker        = DatePicker()
    let alarmSegment      = UISegmentedControl(items: ["Alarm Off", "Alarm On"])
    let dayStackView      = CustomStackView(axis: .horizontal, distribution: .fillEqually, spacing: 6)
    var hour              = Int()
    var minute            = Int()
    var buttonArray       = [GradientButton]()
    let rectangleGradient = UIImage(systemName: "rectangle.fill")?.addTintGradient(colors: Gradients.array[5])

    // MARK: - Class Methods

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        layoutUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods

    @objc func timeChanged() {
        let time = datePicker.timeChanged()
        hour     = Int(time[0]) ?? 0
        minute   = Int(time[1]) ?? 0
    }

    private func configure() {
        backgroundColor = BackgroundColors.secondaryBackground
        layer.cornerRadius = 10
        generator.prepare()
        datePicker.addTarget(self, action: #selector(timeChanged), for: .valueChanged)

        alarmSegment.translatesAutoresizingMaskIntoConstraints = false
        alarmSegment.layer.cornerRadius = 10
        alarmSegment.layer.borderWidth  = 1.5
        alarmSegment.layer.borderColor  = Gradients.array[5][0]
        alarmSegment.setGradientColors()

        for index in 0...6 {
            let dayButton = GradientButton()
            dayButton.addTarget(self, action: #selector(dayButtonpressed), for: .touchUpInside)
            dayButton.setTitle(Labels.daysArray[index], for: .normal)
            dayButton.setTitleColor(.secondaryLabel, for: .normal)
            dayButton.backgroundColor    = BackgroundColors.secondaryBackground
            dayButton.layer.cornerRadius = 10

            dayStackView.addArrangedSubview(dayButton)
            buttonArray.append(dayButton)
        }
    }

    private func layoutUI() {
        contentView.addSubviews(datePicker, dayStackView, alarmSegment)

        let padding: CGFloat = 10

        NSLayoutConstraint.activate([
            datePicker.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            datePicker.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            datePicker.trailingAnchor.constraint(equalTo: alarmSegment.leadingAnchor, constant: -padding),
            datePicker.bottomAnchor.constraint(equalTo: dayStackView.topAnchor, constant: -padding),
            datePicker.heightAnchor.constraint(equalToConstant: 45),

            alarmSegment.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            alarmSegment.leadingAnchor.constraint(equalTo: datePicker.trailingAnchor, constant: padding),
            alarmSegment.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            alarmSegment.bottomAnchor.constraint(equalTo: dayStackView.topAnchor, constant: -padding),

            dayStackView.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: padding),
            dayStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            dayStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            dayStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
            dayStackView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    // MARK: - @Objc Methods

    @objc func dayButtonpressed(_ sender: GradientButton) {
        sender.bounce()
        generator.impactOccurred()
        sender.isSelected.toggle()
        var stringWeek: String = ""
        var dayArray: [String] = ["", "", "", "", "", "", ""]

        for (index, button) in buttonArray.enumerated() {
            if button.isSelected == false {
                button.setTitleColor(.secondaryLabel, for: .normal)
                button.backgroundColor = BackgroundColors.secondaryBackground
                button.colors          = GradientColors.clearGradient
                dayArray[index]        = "f"
            } else {
                button.setTitleColor(.white, for: .normal)
                button.backgroundColor = .clear
                button.colors          = Gradients.darkBlueGradient
                dayArray[index]        = "t"
            }
            stringWeek = dayArray.joined(separator: "")

        }
        delegate?.passDayData(dayArray: stringWeek)
    }
}

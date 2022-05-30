//
//  HabitDetailsStreakView.swift
//  Habits
//
//  Created by Alexander Thompson on 15/9/21.
//

import UIKit

class DetailsStreakView: UIView {

    // MARK: - Properties

    var streakLabel             = BodyLabel(textInput: "Habit Details", textAlignment: .left, fontSize: 18)
    var dateCreatedLabel        = BodyLabel(textInput: "Date Habit Created:", textAlignment: .left, fontSize: 16)
    var dateCreatedResultLabel  = BodyLabel(textInput: "", textAlignment: .right, fontSize: 20)

    var totalCountLabel         = BodyLabel(textInput: "Total Days Completed:", textAlignment: .left, fontSize: 16)
    var totalCountResultLabel   = BodyLabel(textInput: "", textAlignment: .right, fontSize: 20)

    var averageCountLabel       = BodyLabel(textInput: "Average habits per week:", textAlignment: .left, fontSize: 16)
    var averageCountResultLabel = BodyLabel(textInput: "", textAlignment: .right, fontSize: 20)

    let labelStack              = CustomStackView(axis: .vertical, distribution: .fillEqually, spacing: 6)
    let resultStack             = CustomStackView(axis: .vertical, distribution: .fillEqually, spacing: 6)

    let streakImage             = UIImageView()
    let line                    = UIView()

    // MARK: - Class Methods

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        configureStackViews()
        layoutUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods

    func setLabels(date: String, count: Int, average: String) {
        dateCreatedResultLabel.text  = "\(date)"
        totalCountResultLabel.text   = "\(count)"
        averageCountResultLabel.text = "\(average)"
    }

    func setColor(colors: [CGColor] ) {
        DispatchQueue.main.async { [weak self] in
            self?.streakImage.image                 = UIImage(systemName: "checkmark.square.fill")?.addTintGradient(colors: colors)
            self?.dateCreatedResultLabel.textColor  = UIColor(cgColor: colors[0])
            self?.totalCountResultLabel.textColor   = UIColor(cgColor: colors[0])
            self?.averageCountResultLabel.textColor = UIColor(cgColor: colors[0])
        }
    }

    private func configure() {
        addShadow()
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10
        backgroundColor    = BackgroundColors.secondaryBackground

        line.backgroundColor = UIColor.label
        line.translatesAutoresizingMaskIntoConstraints = false

        streakImage.translatesAutoresizingMaskIntoConstraints = false
    }

    private func configureStackViews() {
        labelStack.addArrangedSubview(dateCreatedLabel)
        labelStack.addArrangedSubview(totalCountLabel)
        labelStack.addArrangedSubview(averageCountLabel)

        resultStack.addArrangedSubview(dateCreatedResultLabel)
        resultStack.addArrangedSubview(totalCountResultLabel)
        resultStack.addArrangedSubview(averageCountResultLabel)
    }

    private func layoutUI() {
        addSubviews(line, streakImage, streakLabel, labelStack, resultStack)
        let padding: CGFloat = 20

        NSLayoutConstraint.activate([
            streakImage.topAnchor.constraint(equalTo: self.topAnchor, constant: padding / 2),
            streakImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            streakImage.trailingAnchor.constraint(equalTo: streakLabel.leadingAnchor, constant: -5),
            streakImage.heightAnchor.constraint(equalToConstant: 30),
            streakImage.widthAnchor.constraint(equalToConstant: 30),

            streakLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: padding / 2),
            streakLabel.leadingAnchor.constraint(equalTo: streakImage.trailingAnchor, constant: 5),
            streakLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            streakLabel.heightAnchor.constraint(equalToConstant: 40),

            line.topAnchor.constraint(equalTo: streakLabel.bottomAnchor, constant: 5),
            line.leadingAnchor.constraint(equalTo: streakImage.leadingAnchor),
            line.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            line.heightAnchor.constraint(equalToConstant: 1),

            labelStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            labelStack.topAnchor.constraint(equalTo: line.bottomAnchor, constant: 5),
            labelStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding / 2),
            labelStack.trailingAnchor.constraint(equalTo: resultStack.leadingAnchor, constant: padding),

            resultStack.leadingAnchor.constraint(equalTo: labelStack.trailingAnchor, constant: padding),
            resultStack.topAnchor.constraint(equalTo: line.bottomAnchor, constant: 5),
            resultStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            resultStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding / 2)
        ])
    }
}

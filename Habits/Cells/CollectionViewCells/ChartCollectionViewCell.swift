//
//  ChartCellCollectionViewCell.swift
//  Habits
//
//  Created by Alexander Thompson on 29/9/21.
//

import UIKit

class ChartCollectionViewCell: UICollectionViewCell {

    // MARK: - Properties

    static let reuseID                  = "ChartCellCollectionViewCell"

    let countStack                      = CustomStackView(axis: .horizontal, distribution: .fillEqually, spacing: 10)
    let monthStack                      = CustomStackView(axis: .horizontal, distribution: .fillEqually, spacing: 10)
    let progressStack                   = CustomStackView(axis: .vertical, distribution: .fillEqually, spacing: 10)
    let yearLabel                       = BodyLabel(textInput: "", textAlignment: .left, fontSize: 16)
    var countArray: [UILabel]           = []
    var progressArray: [UIProgressView] = []

    // MARK: - Class Methods

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        layoutUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods
    func set(chartYear: ChartYear) {
        yearLabel.text = String(chartYear.year)
        for index in 0...11 {
            progressArray[index].progressImage = UIImage(systemName: "rectangle.portrait.fill")?.addTintGradient(colors: chartYear.color)
            countArray[index].text             = String(chartYear.monthCount[index])

            // Only shows month count on months that arent empty
            if chartYear.monthCount[index] == 0 {
                countArray[index].alpha     = 0
            } else {
                countArray[index].alpha     = 1.0
            }

            UIView.animate(withDuration: 1.0) { [weak self] in
                let progress: Float = 1.0 / 31
                self?.progressArray[index].setProgress(Float(chartYear.monthCount[index]) * progress, animated: true)
            }
        }
    }

    private func configure() {
        for index in 0...11 {
            let monthLabel = BodyLabel(textInput: Labels.monthArray[index], textAlignment: .center, fontSize: 13)
            monthLabel.adjustsFontSizeToFitWidth = false
            monthStack.addArrangedSubview(monthLabel)

            let countLabel = BodyLabel(textInput: "0", textAlignment: .center, fontSize: 14)
            countArray.append(countLabel)
            countStack.addArrangedSubview(countArray[index])

            let chartProgressView = ChartProgressView()
            progressArray.append(chartProgressView)
            progressStack.addArrangedSubview(chartProgressView)
        }
        progressStack.transform = CGAffineTransform(rotationAngle: .pi / -2)
    }

    private func layoutUI() {
        addSubviews(countStack, progressStack, monthStack, yearLabel)
        NSLayoutConstraint.activate([
            countStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            countStack.topAnchor.constraint(equalTo: self.topAnchor),
            countStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            countStack.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.1),

            progressStack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            progressStack.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -10),
            progressStack.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.65),
            progressStack.heightAnchor.constraint(equalTo: self.widthAnchor),

            monthStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            monthStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            monthStack.bottomAnchor.constraint(equalTo: yearLabel.topAnchor),
            monthStack.heightAnchor.constraint(equalToConstant: 20),

            yearLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            yearLabel.topAnchor.constraint(equalTo: monthStack.bottomAnchor),
            yearLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            yearLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.1)
        ])
    }

}

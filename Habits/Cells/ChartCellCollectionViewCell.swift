//
//  ChartCellCollectionViewCell.swift
//  Habits
//
//  Created by Alexander Thompson on 29/9/21.
//

import UIKit

class ChartCellCollectionViewCell: UICollectionViewCell {
    
    static let reuseID = "ChartCellCollectionViewCell"
    
    var monthlyCountArray = [UILabel]()
    let countStack = UIStackView()
    
    var progressBarArray = [UIProgressView]()
    let barView = UIStackView()
    var countLabelArray = [UILabel]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        for label in monthlyCountArray {
            label.text = ""
        }
        for label in countLabelArray {
            label.text = ""
        }
        for bar in progressBarArray {
            bar.progress = 0.0
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(chartYear: ChartYear) {
        print("set")
        for num in 0...11{
            var time = 2.0
            countLabelArray[num].text = String(chartYear.monthCount[num])
            
            if chartYear.monthCount[num] == 0 {
                countLabelArray[num].alpha    = 0
            } else {
                countLabelArray[num].alpha   = 1.0
            }
            UIView.animate(withDuration: time) { [self] in
                self.progressBarArray[num].progress = (Float(1.0) / Float(chartYear.monthCount[num]))
            }
        }
        print(chartYear.monthCount)
    }
    
    
    func configure() {
        print("configure")
        let monthStack = UIStackView()
        monthStack.translatesAutoresizingMaskIntoConstraints = false
        monthStack.axis         = .horizontal
        monthStack.distribution = .fillEqually
        monthStack.spacing      = 10
        
        countStack.translatesAutoresizingMaskIntoConstraints = false
        countStack.axis = .horizontal
        countStack.distribution = .fillEqually
        countStack.spacing = 10
        
        let monthArray = ["01","02","03","04","05","06","07","08","09","10","11","12",]
        for num in 0...11 {
            
            let monthLabel = UILabel()
            monthLabel.translatesAutoresizingMaskIntoConstraints = false
            monthLabel.adjustsFontSizeToFitWidth = true
            monthLabel.font                      = monthLabel.font.withSize(12)
            monthLabel.text                      = monthArray[num]
            monthStack.addArrangedSubview(monthLabel)
            
            let countLabel = UILabel()
            countLabel.translatesAutoresizingMaskIntoConstraints = false
            countLabel.text = "0"
            countLabelArray.append(countLabel)
            countStack.addArrangedSubview(countLabelArray[num])
            
            
            let progressBar = UIProgressView()
            progressBar.layer.cornerRadius = 5
            progressBar.progress = 0.3
            progressBar.backgroundColor = .tertiarySystemBackground
            progressBar.tintColor = .blue
            let image = UIImage(systemName: "rectangle.portrait.fill")?.addTintGradient(colors: Gradients().blueGradient)
            progressBar.progressImage = image
            progressBar.clipsToBounds = true
            progressBar.translatesAutoresizingMaskIntoConstraints = false
            progressBarArray.append(progressBar)
            barView.addArrangedSubview(progressBar)
        }
        barView.translatesAutoresizingMaskIntoConstraints = false
        barView.axis = .vertical
        barView.distribution = .fillEqually
        barView.spacing = 10
        barView.transform = CGAffineTransform(rotationAngle: .pi / -2)
        addSubviews(countStack, barView, monthStack)
        NSLayoutConstraint.activate([
            countStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 4),
            countStack.topAnchor.constraint(equalTo: self.topAnchor),
            countStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            countStack.heightAnchor.constraint(equalToConstant: 20),
            
            barView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            barView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            barView.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.80),
            barView.heightAnchor.constraint(equalTo: self.widthAnchor),
            
            monthStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 4),
            monthStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            monthStack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            monthStack.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}


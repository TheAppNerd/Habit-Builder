//
//  ChartCellCollectionViewCell.swift
//  Habits
//
//  Created by Alexander Thompson on 29/9/21.
//

import UIKit

class ChartCollectionViewCell: UICollectionViewCell {
    
    // TODO: move chart to own class?
    // TODO: move funcs out of cell
    
    static let reuseID = "ChartCellCollectionViewCell"
    
    let countStack = UIStackView()
    var progressBarArray = [UIProgressView]()
    let barView = UIStackView()
    var countLabelArray = [UILabel]()
    let yearLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(chartYear: ChartYear) {
        yearLabel.text = String(chartYear.year)
        for num in 0...11{
            //workaround to add tint to progress bars
            progressBarArray[num].progressImage = UIImage(systemName: "rectangle.portrait.fill")?.addTintGradient(colors: chartYear.color)
            
            countLabelArray[num].text = String(chartYear.monthCount[num])
            
            //only shows month count on months that arent empty
            if chartYear.monthCount[num] == 0 {
                countLabelArray[num].alpha    = 0
            } else {
                countLabelArray[num].alpha   = 1.0
            }
            
            UIView.animate(withDuration: 1.0) { [weak self] in
                let progress: Float = 1.0 / 31
                self?.progressBarArray[num].setProgress(Float(chartYear.monthCount[num]) * progress, animated: true)
            }
        }
    }
    
    
    func configure() {
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
            monthLabel.textAlignment = .center
            monthLabel.text                      = monthArray[num]
            monthStack.addArrangedSubview(monthLabel)
            
            let countLabel = UILabel()
            countLabel.translatesAutoresizingMaskIntoConstraints = false
            countLabel.text = "0"
            countLabel.textAlignment = .center
            countLabel.font = UIFont.boldSystemFont(ofSize: 12)
            countLabelArray.append(countLabel)
            countStack.addArrangedSubview(countLabelArray[num])
            
            let progressBar = UIProgressView()
            progressBar.layer.cornerRadius = 5
            progressBar.progress = 0.0
            progressBar.backgroundColor = .quaternaryLabel
            progressBar.tintColor = .blue
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
        
        yearLabel.translatesAutoresizingMaskIntoConstraints = false
        yearLabel.font = UIFont.boldSystemFont(ofSize: 16)
        yearLabel.textAlignment = .left
        
        
        addSubviews(countStack, barView, monthStack, yearLabel)
        NSLayoutConstraint.activate([
            countStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            countStack.topAnchor.constraint(equalTo: self.topAnchor),
            countStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            countStack.heightAnchor.constraint(equalToConstant: 20),
            
            barView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            barView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -10),
            barView.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.65),
            barView.heightAnchor.constraint(equalTo: self.widthAnchor),

            monthStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            monthStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            monthStack.bottomAnchor.constraint(equalTo: yearLabel.topAnchor),
            monthStack.heightAnchor.constraint(equalToConstant: 20),
            
            yearLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            yearLabel.topAnchor.constraint(equalTo: monthStack.bottomAnchor),
            yearLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            yearLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}


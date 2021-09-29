//
//  ChartCollectionCell.swift
//  Habits
//
//  Created by Alexander Thompson on 20/8/21.
//

import UIKit

class ChartCollectionCell: UICollectionViewCell {
    
    static let reuseID = "CollectionChartCell"
    
    let stackView = UIStackView() //rename
    
    let yearLabel = UILabel()
    var monthCountArray = [UILabel]()
    var countArray = [[GradientView]]()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureStackView()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(chartYear: ChartYear) {
        print("set")
        yearLabel.text = String(chartYear.year)
        
        for num in 0...11 {
            monthCountArray[num].text = String(chartYear.monthCount[num])
            if chartYear.monthCount[num] == 0 {
                monthCountArray[num].alpha    = 0
            } else {
                monthCountArray[num].alpha   = 1.0
            }
            
            var time                = 2.0
            for number in 0...30 {
                countArray[num][number].alpha = 0.0
            
                let reverseNumber   = 31 - chartYear.monthCount[num]
                if number < reverseNumber {
                    countArray[num][number].colors    = GradientColors.clearGradient
                } else {
                    countArray[num][number].colors    = chartYear.color
                    
                    UIView.animate(withDuration: time) {
                        self.countArray[num][number].alpha = 1.0
                        time -= 0.2
                    }
                }
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    //biggest func ever. break it down
    func configureStackView() {
        print("configure")
        self.translatesAutoresizingMaskIntoConstraints = true
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis          = .horizontal
        stackView.distribution  = .fillEqually
        stackView.spacing       = 10
        
        let countStack = UIStackView()
        countStack.translatesAutoresizingMaskIntoConstraints = false
        countStack.axis         = .horizontal
        countStack.distribution = .fillEqually
        countStack.spacing      = 10
        
        let monthStack = UIStackView()
        monthStack.translatesAutoresizingMaskIntoConstraints = false
        monthStack.axis         = .horizontal
        monthStack.distribution = .fillEqually
        monthStack.spacing      = 10
        
        yearLabel.translatesAutoresizingMaskIntoConstraints = false
        yearLabel.textAlignment = .left
        yearLabel.font          = UIFont.boldSystemFont(ofSize: 20)
        
        for stack in 0...11 {
            let vStackView = UIStackView()
            vStackView.translatesAutoresizingMaskIntoConstraints = false
            vStackView.axis         = .vertical
            vStackView.alignment    = .fill
            vStackView.distribution = .fillEqually
            
            let countLabel = UILabel()
            countLabel.translatesAutoresizingMaskIntoConstraints = false
            monthCountArray.append(countLabel)
            countStack.addArrangedSubview(monthCountArray[stack])
            
            var array = [GradientView]()
            for _ in 0...30 {
                let gradientView           = GradientView()
                gradientView.translatesAutoresizingMaskIntoConstraints = false
                vStackView.addArrangedSubview(gradientView)
                array.append(gradientView)
            }
            countArray.append(array)
            stackView.addArrangedSubview(vStackView)
            
            let monthArray = ["01","02","03","04","05","06","07","08","09","10","11","12",]
            let monthLabel = UILabel()
            monthLabel.translatesAutoresizingMaskIntoConstraints = false
            monthLabel.adjustsFontSizeToFitWidth = true
            monthLabel.font                      = monthLabel.font.withSize(12)
            monthLabel.text                      = monthArray[stack]
            monthStack.addArrangedSubview(monthLabel)
        }
        

        addSubview(stackView)
        addSubview(monthStack)
        addSubview(countStack)
        addSubview(yearLabel)
        
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            countStack.topAnchor.constraint(equalTo: self.topAnchor),
            countStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            countStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            countStack.bottomAnchor.constraint(equalTo: stackView.topAnchor),
            countStack.heightAnchor.constraint(equalToConstant: 30),
            
            stackView.topAnchor.constraint(equalTo: countStack.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            stackView.bottomAnchor.constraint(equalTo: monthStack.topAnchor),
            
            monthStack.topAnchor.constraint(equalTo: stackView.bottomAnchor),
            monthStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            monthStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            monthStack.bottomAnchor.constraint(equalTo: yearLabel.topAnchor),
            monthStack.heightAnchor.constraint(equalToConstant: 30),
            
            yearLabel.topAnchor.constraint(equalTo: monthStack.bottomAnchor),
            yearLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            yearLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            yearLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            yearLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
}





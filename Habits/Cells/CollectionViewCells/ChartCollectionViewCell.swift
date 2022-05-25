//
//  ChartCellCollectionViewCell.swift
//  Habits
//
//  Created by Alexander Thompson on 29/9/21.
//

import UIKit

class ChartCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    static let reuseID                  = "ChartCellCollectionViewCell"
    
    let countStack                      = CustomStackView(axis: .horizontal, distribution: .fillEqually, spacing: 10)
    let monthStack                      = CustomStackView(axis: .horizontal, distribution: .fillEqually, spacing: 10)
    let progressStack                   = CustomStackView(axis: .vertical, distribution: .fillEqually, spacing: 10)
    let yearLabel                       = UILabel()
   
    var countArray: [UILabel]           = []
    var progressArray: [UIProgressView] = []
   
    
    
    //MARK: - Class Funcs
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        layoutUI()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Functions
    func set(chartYear: ChartYear) {
        yearLabel.text = String(chartYear.year)
        for num in 0...11 {
            
            //workaround to add tint to progress bars
            progressArray[num].progressImage = UIImage(systemName: "rectangle.portrait.fill")?.addTintGradient(colors: chartYear.color)
            
            countArray[num].text           = String(chartYear.monthCount[num])
            
            //only shows month count on months that arent empty
            if chartYear.monthCount[num] == 0 {
                countArray[num].alpha    = 0
            } else {
                countArray[num].alpha   = 1.0
            }
            
            UIView.animate(withDuration: 1.0) { [weak self] in
                let progress: Float = 1.0 / 31
                self?.progressArray[num].setProgress(Float(chartYear.monthCount[num]) * progress, animated: true)
            }
        }
    }
    
    
    private func configure() {
        for index in 0...11 {
            let monthLabel = BodyLabel(textInput: Labels.monthArray[index], textAlignment: .center, fontSize: 12)
            monthStack.addArrangedSubview(monthLabel)
            
            let countLabel = BodyLabel(textInput: "0", textAlignment: .center, fontSize: 12)
            countArray.append(countLabel)
            countStack.addArrangedSubview(countArray[index])
            
            let chartProgressView = ChartProgressView()
            progressArray.append(chartProgressView)
            progressStack.addArrangedSubview(chartProgressView)
        }
        
        yearLabel.translatesAutoresizingMaskIntoConstraints = false
        yearLabel.font = UIFont.boldSystemFont(ofSize: 16)
        yearLabel.textAlignment = .left
        
        progressStack.transform = CGAffineTransform(rotationAngle: .pi / -2)
    }
    

    private func layoutUI() {
        addSubviews(countStack, progressStack, monthStack, yearLabel)
        NSLayoutConstraint.activate([
            countStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            countStack.topAnchor.constraint(equalTo: self.topAnchor),
            countStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            countStack.heightAnchor.constraint(equalToConstant: 20),
            
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
            yearLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
}


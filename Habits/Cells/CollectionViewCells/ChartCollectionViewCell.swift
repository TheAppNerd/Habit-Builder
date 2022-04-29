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
    
    //MARK: - Properties
    
    static let reuseID                  = "ChartCellCollectionViewCell"
    
    let countStack                      = UIStackView()
    let monthStack                      = UIStackView()
    let progressStack                   = UIStackView()
    let yearLabel                       = UILabel()
   
    var countArray: [UILabel]           = []
    var progressArray: [UIProgressView] = []
   
    
    
    //MARK: - Class Funcs
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        configureStackView()
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
       // TODO: - Use custom labels
        for index in 0...11 {
            let monthLabel = UILabel()
            monthLabel.translatesAutoresizingMaskIntoConstraints = false
            monthLabel.adjustsFontSizeToFitWidth = true
            monthLabel.font                      = monthLabel.font.withSize(12)
            monthLabel.textAlignment             = .center
            monthLabel.text                      = Labels.monthArray[index]
            monthStack.addArrangedSubview(monthLabel)
            
            let countLabel = UILabel()
            countLabel.translatesAutoresizingMaskIntoConstraints = false
            countLabel.text                      = "0"
            countLabel.textAlignment             = .center
            countLabel.font                      = UIFont.boldSystemFont(ofSize: 12)
            countArray.append(countLabel)
            countStack.addArrangedSubview(countArray[index])
            
            let chartProgressView = ChartProgressView()
            progressArray.append(chartProgressView)
            progressStack.addArrangedSubview(chartProgressView)
        }
        
        
        yearLabel.translatesAutoresizingMaskIntoConstraints = false
        yearLabel.font = UIFont.boldSystemFont(ofSize: 16)
        yearLabel.textAlignment = .left
    }
    
    // TODO: - crerate custom stack
    private func configureStackView() {
        monthStack.translatesAutoresizingMaskIntoConstraints = false
        monthStack.axis         = .horizontal
        monthStack.distribution = .fillEqually
        monthStack.spacing      = 10
        
        countStack.translatesAutoresizingMaskIntoConstraints = false
        countStack.axis         = .horizontal
        countStack.distribution = .fillEqually
        countStack.spacing      = 10
        
        progressStack.translatesAutoresizingMaskIntoConstraints = false
        progressStack.axis = .vertical
        progressStack.distribution = .fillEqually
        progressStack.spacing = 10
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


//
//  HabitDetailsChartView.swift
//  Habits
//
//  Created by Alexander Thompson on 15/9/21.
//

import UIKit

class DetailsChartView: UIView {

    // MARK: - Properties
    
    var collectionView  = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    var collectionImage = UIImageView()
    let collectionLabel = BodyLabel(textInput: "Monthly Count", textAlignment: .left, fontSize: 18)
    let infoLabel       = BodyLabel(textInput: "Swipe to see more", textAlignment: .right, fontSize: 12)
    let line            = UIView()

    // MARK: - Class Methods

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        layoutUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Methods

    func setColor(colors: [CGColor] ) {
        DispatchQueue.main.async { [weak self] in
            self?.collectionImage.image = UIImage(systemName: "chart.bar.xaxis")?.addTintGradient(colors: colors)
        }
    }

    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor    = BackgroundColors.secondaryBackground
        layer.cornerRadius = 10

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection   = .horizontal
        layout.estimatedItemSize = CGSize(width: collectionView.frame.width, height: collectionView.frame.height)

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = BackgroundColors.secondaryBackground
        collectionView.isScrollEnabled = true

        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = .label

        collectionImage.layer.cornerRadius = 10
        collectionImage.backgroundColor = UIColor.clear
        collectionImage.translatesAutoresizingMaskIntoConstraints = false
    }

    private func layoutUI() {
        addSubviews(collectionImage, collectionLabel, infoLabel, collectionView, line)
        let padding: CGFloat = 20

        NSLayoutConstraint.activate([
            collectionImage.topAnchor.constraint(equalTo: self.topAnchor, constant: padding / 2),
            collectionImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            collectionImage.trailingAnchor.constraint(equalTo: collectionLabel.leadingAnchor, constant: -5),
            collectionImage.heightAnchor.constraint(equalToConstant: 30),
            collectionImage.widthAnchor.constraint(equalToConstant: 30),

            collectionLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: padding / 2),
            collectionLabel.leadingAnchor.constraint(equalTo: collectionImage.trailingAnchor, constant: 5),
            collectionLabel.trailingAnchor.constraint(equalTo: infoLabel.leadingAnchor, constant: -padding),
            collectionLabel.heightAnchor.constraint(equalToConstant: 40),

            infoLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: padding / 2),
            infoLabel.leadingAnchor.constraint(equalTo: collectionLabel.trailingAnchor, constant: padding),
            infoLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            infoLabel.heightAnchor.constraint(equalToConstant: 40),

            line.topAnchor.constraint(equalTo: collectionLabel.bottomAnchor, constant: 5),
            line.leadingAnchor.constraint(equalTo: collectionImage.leadingAnchor),
            line.trailingAnchor.constraint(equalTo: infoLabel.trailingAnchor),
            line.heightAnchor.constraint(equalToConstant: 1),

            collectionView.topAnchor.constraint(equalTo: line.bottomAnchor, constant: 5),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding / 2)
        ])
    }

}

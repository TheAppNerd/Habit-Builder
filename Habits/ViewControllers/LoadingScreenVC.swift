//
//  IntroScreenViewController.swift
//  Habits
//
//  Created by Alexander Thompson on 29/11/21.
//

import UIKit

class LoadingScreenVC: UIViewController {

    // MARK: - Properties

    let iconCircle = UIImageView(image: UIImage(named: "iconCircle")?.addTintGradient(colors: Gradients.array[5]))
    let icontick   = UIImageView(image: UIImage(named: "iconTick")?.addTintGradient(colors: Gradients.array[5]))

    // MARK: - Class Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        presentHabitVC()
        layoutUI()
    }

    // MARK: - Methods

    private func configure() {
        view.backgroundColor = BackgroundColors.mainBackGround
        iconCircle.rotate()
        iconCircle.translatesAutoresizingMaskIntoConstraints = false
        icontick.translatesAutoresizingMaskIntoConstraints = false
    }

    private func presentHabitVC() {
        let destVC = UINavigationController(rootViewController: HabitHomeVC())
        destVC.modalPresentationStyle = .fullScreen
        destVC.modalTransitionStyle = .crossDissolve

        let seconds = 1.2

        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            self.iconCircle.layer.removeAllAnimations()
            self.present(destVC, animated: true)
        }
    }

    private func layoutUI() {
        view.addSubviews(iconCircle, icontick)

        NSLayoutConstraint.activate([
            iconCircle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            iconCircle.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            iconCircle.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25),
            iconCircle.widthAnchor.constraint(equalTo: iconCircle.heightAnchor),

            icontick.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            icontick.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            icontick.heightAnchor.constraint(equalTo: iconCircle.heightAnchor, multiplier: 0.45),
            icontick.widthAnchor.constraint(equalTo: icontick.heightAnchor)
        ])
    }

}

//
//  IntroScreenViewController.swift
//  Habits
//
//  Created by Alexander Thompson on 29/11/21.
//

import UIKit

class LoadingScreenVC: UIViewController {
    
    let iconCircle = UIImageView(image: UIImage(named: "iconCircle")?.addTintGradient(colors: GradientArray.array[5]))
    let icontick = UIImageView(image: UIImage(named: "iconTick")?.addTintGradient(colors: GradientArray.array[5]))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        iconCircle.rotate()
        presentHabitVC()
    }
    
    
    private func configure() {
        view.backgroundColor = .systemBackground
        
        iconCircle.translatesAutoresizingMaskIntoConstraints = false
        icontick.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubviews(iconCircle, icontick)
        
        NSLayoutConstraint.activate([
            iconCircle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            iconCircle.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            iconCircle.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25),
            iconCircle.widthAnchor.constraint(equalTo: iconCircle.heightAnchor),
            
            icontick.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            icontick.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            icontick.heightAnchor.constraint(equalTo: iconCircle.heightAnchor, multiplier: 0.45),
            icontick.widthAnchor.constraint(equalTo: icontick.heightAnchor),
        ])
    }
    
    func presentHabitVC() {
        let destVC = UINavigationController(rootViewController: HabitHomeVC())
        destVC.modalPresentationStyle = .fullScreen
        
        let seconds = 1.8
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            self.present(destVC, animated: true)
        }
    }
    
}





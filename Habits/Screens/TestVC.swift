//
//  TestVC.swift
//  Habits
//
//  Created by Alexander Thompson on 7/5/21.
//

import UIKit

class TestVC: UIViewController {

    var circle = HabitProgressView()
    var a: Float = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()

    configureCircle()
    }
    
    @objc func handleTap() {
        a += 0.1
        
        //circle.progress += 0.1
        UIView.animate(withDuration: 3) {
            self.circle.setProgress(self.a, animated: true)
        }
    }
    
    func configureCircle() {
        
        circle.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        circle.progressTintColor = .red
        view.addSubview(circle)
        circle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        
            circle.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            circle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            circle.heightAnchor.constraint(equalToConstant: 100),
            circle.widthAnchor.constraint(equalToConstant: 100)
        
        ])
        
        
        
    }
    
    
    

}

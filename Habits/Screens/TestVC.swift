//
//  TestVC.swift
//  Habits
//
//  Created by Alexander Thompson on 7/5/21.
//

import UIKit

class TestVC: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()


       gradient(gradientView: view)
    }
    
   
        
    func gradient(gradientView: UIView) {
    
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = gradientView.bounds
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.colors = [UIColor(red: 0.18, green: 0.19, blue: 0.57, alpha: 1).cgColor, UIColor(red: 0.11, green: 1.00, blue: 1.00, alpha: 1.00).cgColor]
        gradientLayer.shouldRasterize = true
        gradientView.layer.insertSublayer(gradientLayer, at: 0)
    }
    

}

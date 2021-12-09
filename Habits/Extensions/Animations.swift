//
//  Animations.swift
//  Habits
//
//  Created by Alexander Thompson on 7/9/21.
//

import UIKit

extension UIButton {
    
    func bounceAnimation() {
        UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: .curveEaseIn) {
            self.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        } completion: { (_) in
            UIView.animate(withDuration: 0.05, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 2, options: .curveEaseIn) {
                self.transform = CGAffineTransform(scaleX: 1, y: 1)
            }
        }
    }
}


extension UIImageView {
    
    func bounceAnimation() {
        UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: .curveEaseIn) {
            self.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        } completion: { (_) in
            UIView.animate(withDuration: 0.05, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 2, options: .curveEaseIn) {
                self.transform = CGAffineTransform(scaleX: 1, y: 1)
            }
            
            
        }
    }
}


extension UIView {
    
    func rotate() {
        let rotation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 2
        rotation.isCumulative = true
        rotation.repeatCount = Float.greatestFiniteMagnitude
        self.layer.add(rotation, forKey: "rotationAnimation")
    }
}




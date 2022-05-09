//
//  Animations.swift
//  Habits
//
//  Created by Alexander Thompson on 7/9/21.
//

import UIKit

// TODO: Move these to extensions

extension UIButton {
    
    ///Adds a bounce animation to buttons.
    func bounceAnimation() {
        UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: .curveEaseInOut) { [weak self] in
            self?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        } completion: { [weak self] _ in
            UIView.animate(withDuration: 0.05, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 2, options: .curveEaseInOut) {
                self?.transform = CGAffineTransform(scaleX: 1, y: 1)
            }
        }
    }
}


extension UIImageView {
    
    ///Adds a bounce animation to images.
    func bounceAnimation() {
        UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: .curveEaseInOut) {
            [weak self] in
            self?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        } completion: { [weak self] _ in
            UIView.animate(withDuration: 0.05, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 2, options: .curveEaseInOut) {
                self?.transform = CGAffineTransform(scaleX: 1, y: 1)
            }
        }
    }
}


extension UIView {
    
    ///Rotates a view in place clockwork direction.
    func rotate() {
        let rotation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue      = NSNumber(value: Double.pi * 2)
        rotation.duration     = 2
        rotation.isCumulative = true
        rotation.repeatCount  = Float.greatestFiniteMagnitude
        self.layer.add(rotation, forKey: "rotationAnimation")
    }
    
    func bounce() {
        UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: .curveEaseInOut) { [weak self] in
            self?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        } completion: { [weak self] _ in
            UIView.animate(withDuration: 0.05, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 2, options: .curveEaseInOut) {
                self?.transform = CGAffineTransform(scaleX: 1, y: 1)
            }
        }
    }
}




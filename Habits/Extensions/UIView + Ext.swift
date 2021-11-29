//
//  UIView + Ext.swift
//  Habits
//
//  Created by Alexander Thompson on 11/5/21.
//

import UIKit

extension UIView {
    
    func edgeTo(_ view: UIView, padding: CGFloat) {
        view.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
       
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding)
        ])
    }
    
    func pinMenuTo(_ view: UIView, with constant: CGFloat) {
        view.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.topAnchor),
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -constant),
            bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
    
    func rotate() {
        let rotation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 2
        rotation.isCumulative = true
        rotation.repeatCount = Float.greatestFiniteMagnitude
        self.layer.add(rotation, forKey: "rotationAnimation")
    }
    
}

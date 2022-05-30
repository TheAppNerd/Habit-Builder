//
//  UIView + Ext.swift
//  Habits
//
//  Created by Alexander Thompson on 11/5/21.
//

import UIKit

extension UIView {

    /// Utilises side menu bounce functionality.
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

    /// Utilises side menu bounce functionality.
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

    /// Funcs to add all subviews in one line.
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }

    /// Allows a view to set a gradient background.
    func addGradient(colors: [CGColor]) {
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.frame        = bounds
        gradientLayer.startPoint   = CGPoint(x: 1, y: 0)
        gradientLayer.endPoint     = CGPoint(x: 0, y: 1)
        gradientLayer.cornerRadius = layer.cornerRadius
        gradientLayer.colors       = colors
        layer.insertSublayer(gradientLayer, at: 0)
    }

    /// Adds Shadow to virew that works in light or dark mode.
    func addShadow() {
        layer.shadowPath    = UIBezierPath(roundedRect: bounds, cornerRadius: 10).cgPath
        layer.shadowRadius  = 3
        layer.shadowOffset  = CGSize(width: 2, height: 2)
        layer.shadowOpacity = 0.7
        layer.shadowColor   = UIColor.label.cgColor
    }

    /// Rotates a view in place in a clockwork direction.
    func rotate() {
        let rotation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue      = NSNumber(value: Double.pi * 2)
        rotation.duration     = 2
        rotation.isCumulative = true
        rotation.repeatCount  = Float.greatestFiniteMagnitude
        self.layer.add(rotation, forKey: "rotationAnimation")
    }

    /// Adds a bounce animation to views.
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

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
    
    func setupDetailViews(superView: UIView, viewOne: UIView, viewTwo: UIView, viewThree: UIView) {
        let line = UIView()
        line.backgroundColor = .systemGray2
        
        superview!.addSubviews(viewOne, viewTwo, viewThree, line)
        for subview in superview!.subviews {
            subview.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let padding: CGFloat = 20
        NSLayoutConstraint.activate([
            viewOne.leadingAnchor.constraint(equalTo: superview!.leadingAnchor, constant: padding),
            viewOne.trailingAnchor.constraint(equalTo: viewTwo.leadingAnchor, constant: -padding),
            viewOne.topAnchor.constraint(equalTo: superview!.topAnchor, constant: padding),
            viewOne.heightAnchor.constraint(equalToConstant: padding * 2),
            
            viewTwo.leadingAnchor.constraint(equalTo: viewOne.trailingAnchor, constant: padding),
            viewTwo.trailingAnchor.constraint(equalTo: superview!.trailingAnchor, constant: -padding),
            viewTwo.topAnchor.constraint(equalTo: superview!.topAnchor, constant: padding),
            viewTwo.heightAnchor.constraint(equalToConstant: padding * 2),
            
            line.leadingAnchor.constraint(equalTo: viewOne.leadingAnchor),
            line.topAnchor.constraint(equalTo: viewOne.bottomAnchor, constant: 5),
            line.trailingAnchor.constraint(equalTo: viewTwo.trailingAnchor),
            line.heightAnchor.constraint(equalToConstant: 1),
            
            viewThree.leadingAnchor.constraint(equalTo: superview!.leadingAnchor, constant: padding),
            viewThree.trailingAnchor.constraint(equalTo: superview!.trailingAnchor, constant: -padding),
            viewThree.topAnchor.constraint(equalTo: line.bottomAnchor, constant: 5),
            viewThree.bottomAnchor.constraint(equalTo: superview!.bottomAnchor, constant: -padding)
        ])
        
        
        
        
    }

    
    
}

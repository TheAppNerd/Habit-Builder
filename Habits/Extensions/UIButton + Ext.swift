//
//  UIButton + Ext.swift
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



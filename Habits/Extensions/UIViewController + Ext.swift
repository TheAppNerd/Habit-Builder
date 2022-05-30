//
//  UIViewController + Ext.swift
//  Habits
//
//  Created by Alexander Thompson on 27/5/2022.
//

import UIKit

extension UIViewController {
    
    func loadSocialMedia(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        UIApplication.shared.open(url)
    }
    
}

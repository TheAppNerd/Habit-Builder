//
//  MenuView.swift
//  Habits
//
//  Created by Alexander Thompson on 11/5/21.
//

import UIKit

class MenuView: UIViewController {
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
    }
    
    let menuItems = ["Contact Us", "Share App", "Leave Rating", "Privacy", "Dark Mode", "Go Pro"]
    var menuImages = ["envelope.fill", "square.and.arrow.up.fill", "hand.thumbsup.fill", "scroll.fill", "moon.fill", "star.fill"]
    
    
    func configureTableView() {
        tableView.backgroundColor = .secondarySystemBackground
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 70
        tableView.register(MenuTableViewCell.self, forCellReuseIdentifier: MenuTableViewCell.reuseID)
        tableView.separatorStyle = .none
    }
    
}


extension MenuView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MenuTableViewCell.reuseID) as! MenuTableViewCell
        cell.cellImage.image = UIImage(systemName: menuImages[indexPath.row])
        cell.cellLabel.text = menuItems[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 4 {
            
            if #available(iOS 13.0, *) {
                if traitCollection.userInterfaceStyle == .dark {
                    UIApplication.shared.windows.forEach { window in
                        window.overrideUserInterfaceStyle = .light
                        menuImages[4] = "moon"
                        tableView.reloadData()
                    } } else {
                        UIApplication.shared.windows.forEach { window in
                            window.overrideUserInterfaceStyle = .dark
                            menuImages[4] = "moon.fill"
                            tableView.reloadData()
                        }
                    }
                
            }
            
        }
    }
}

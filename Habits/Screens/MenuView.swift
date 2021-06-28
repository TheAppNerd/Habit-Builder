//
//  MenuView.swift
//  Habits
//
//  Created by Alexander Thompson on 11/5/21.
//

import UIKit

class MenuView: UIViewController {
let tableView = UITableView()
    let mySwitch = UISwitch()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       configureTableView()
    }
    
    let menuItems = ["Contact Us", "Share App", "Leave Rating", "Privacy", "Dark Mode", "Go Pro"]
    let menuImages = ["envelope.fill", "square.and.arrow.up.fill", "hand.thumbsup.fill", "scroll.fill", "moon.fill", "star.fill"]
    
    

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
    
    //move this func to model
    @objc func darkModePressed(_ sender: UISwitch) {
    if sender.isOn == true {
        UIApplication.shared.windows.forEach { window in
            window.overrideUserInterfaceStyle = .dark
        }
    } else {
        UIApplication.shared.windows.forEach { window in
            window.overrideUserInterfaceStyle = .light
        }
   }
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
        if indexPath.row == 4 {
            cell.cellSwitch.isHidden = false

        }
        cell.cellSwitch.addTarget(self, action: #selector(darkModePressed), for: .valueChanged)
        return cell
    }

}

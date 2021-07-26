//
//  MenuView.swift
//  Habits
//
//  Created by Alexander Thompson on 11/5/21.
//

import UIKit

protocol SettingsPush {
    func pushSettings(row: Int)
}

class MenuView: UIViewController {
    
    let tableView = UITableView()
    var delegate: SettingsPush?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
    }
    
    let menuItems = [ "Share App", "Leave Rating", "Contact Us", "Save to icloud", "How it Works","Donate to Creator", "Settings"]
    var menuImages = [ "square.and.arrow.up", "heart.text.square", "envelope", "icloud.circle", "questionmark.circle", "dollarsign.circle", "gearshape"]
    
    
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
            delegate?.pushSettings(row: 4)
        }
        if indexPath.row == 5 {
            delegate?.pushSettings(row: 5)
        }
       
    }
    
    
}

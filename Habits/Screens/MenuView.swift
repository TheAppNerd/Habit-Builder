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
    
    let menuItems = ["Contact Us", "Share App", "Leave Rating", "Privacy", "Dark Mode", "How it Works", "Save to icloud"]
    var menuImages = ["envelope", "square.and.arrow.up", "heart.text.square", "scroll", "moon", "questionmark.circle", "icloud.circle"]
    
    
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
            //make this an enum/switch for each row
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
        
        if indexPath.row == 5 {
            //change this to non popover
            let vc = HelpScreenViewController()
        vc.modalPresentationStyle = .popover
       vc.popoverPresentationController?.sourceRect = CGRect(x: 0, y: 0, width: self.view.frame.width - 100, height: self.view.frame.height - 100)
//        present(HelpScreenViewController(), animated: true)
            present(SettingsTableViewController(), animated: true)
        }
        if indexPath.row == 0 {
        //create a delegate to present setting page from main view controller
        }
       
    }
    
    
}

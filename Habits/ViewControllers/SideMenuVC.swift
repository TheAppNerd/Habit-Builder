//
//  MenuView.swift
//  Habits
//
//  Created by Alexander Thompson on 11/5/21.
//

import UIKit

protocol SettingsPush {
    func sideMenuItemPressed(row: Int)
}

class SideMenuVC: UIViewController {
    
    
    //MARK: - Properties
    
    let tableView     = UITableView()
    var delegate: SettingsPush?
    
    
    //MARK: - Class Funcs
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    func configureTableView() {
        tableView.backgroundColor    = BackgroundColors.secondaryBackground
        tableView.frame              = view.bounds
        tableView.delegate           = self
        tableView.dataSource         = self
        tableView.estimatedRowHeight = 70
        tableView.separatorStyle     = .none
        tableView.register(MenuCell.self, forCellReuseIdentifier: MenuCell.reuseID)
        view.addSubview(tableView)
    }
    
}

//MARK: - TableView - UITableViewDelegate, UITableViewDataSource
extension SideMenuVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuPage.menuTitles.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MenuCell.reuseID) as! MenuCell
        if indexPath.row < 7 {
            cell.cellImage.image = UIImage(systemName: menuPage.menuImages[indexPath.row])?.addTintGradient(colors: gradients.array[indexPath.row])
        } else {
            cell.cellImage.image = UIImage(systemName: menuPage.menuImages[indexPath.row])?.addTintGradient(colors: gradients.array[indexPath.row - 7])
        }
        cell.cellLabel.text  = menuPage.menuTitles[indexPath.row]
        return cell
    }
    
    ///Calls all the side menu menu methods from HomeVC to show VC's properly in navigation.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentCell = tableView.cellForRow(at: indexPath)! as! MenuCell
        currentCell.cellImage.bounceAnimation()
        
        delegate?.sideMenuItemPressed(row: indexPath.row)
    }
    
}

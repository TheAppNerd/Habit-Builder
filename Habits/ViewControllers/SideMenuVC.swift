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
        TableViewFuncs().setupTableView(for: .SideMenuVC, using: tableView)
        tableView.frame              = view.bounds
        tableView.delegate           = self
        tableView.dataSource         = self
        
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
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
    }
    
    ///Calls all the side menu menu methods from HomeVC to show VC's properly in navigation.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentCell = tableView.cellForRow(at: indexPath) as! MenuCell
        currentCell.cellImage.bounce()
        
        delegate?.sideMenuItemPressed(row: indexPath.row)
    }
    
}

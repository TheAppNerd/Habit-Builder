     //
//  ViewSettingsTableViewController.swift
//  Habits
//
//  Created by Alexander Thompson on 21/7/21.
//

import UIKit

class ViewSettingsTableViewController: UITableViewController {

    var direction: Int?
    let colors = [UIColor.label, .systemRed, .systemBlue, .systemYellow, .systemGreen, .systemPurple, .systemOrange, .systemIndigo, .systemTeal]
    let colorName = ["Black / White", "Red","Blue","Yellow","Green","Purple","Orange", "Indigo", "Teal"]
    
    //let font = []
    //let icons = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(direction)
        tableView.register(VisualsCell.self, forCellReuseIdentifier: VisualsCell.reuseID)
        tableView.separatorStyle = .none
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
      
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      //create a switch case here dependent on which previous cell was selected to get here.
        return colors.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: VisualsCell.reuseID, for: indexPath) as! VisualsCell
       
        switch direction {
        case 0 : cell.cellLabel.text = colorName[indexPath.row]
                 cell.cellImage.backgroundColor = colors[indexPath.row]
        case 1: print("hi")
        case 2: print("cheese")
        default:
            print("error")
        }
        cell.accessoryType = .none
        
        return cell
    }

    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "hello"
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
}

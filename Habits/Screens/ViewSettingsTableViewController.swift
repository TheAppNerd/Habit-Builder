     //
//  ViewSettingsTableViewController.swift
//  Habits
//
//  Created by Alexander Thompson on 21/7/21.
//

import UIKit

class ViewSettingsTableViewController: UITableViewController {

    var direction: Int?
    var titleString: String?
    
    let colors = [UIColor.label, .systemRed, .systemBlue, .systemYellow, .systemGreen, .systemPurple, .systemOrange, .systemIndigo, .systemTeal, .systemPink]
    let colorName = ["Black / White (Default)", "Red","Blue","Yellow","Green","Purple","Orange", "Indigo", "Teal", "Pink"]
   
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = titleString
        tableView.register(VisualsCell.self, forCellReuseIdentifier: VisualsCell.reuseID)
        tableView.separatorStyle = .none
        tableView.rowHeight = 70
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
      
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch direction {
        case 0: return colors.count
        
        case 1: return 0
        
        default:
            return 0
        }
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: VisualsCell.reuseID, for: indexPath) as! VisualsCell
       
        switch direction { //change these cases to names for clarity
        case 0 : cell.cellLabel.text = colorName[indexPath.row]
                 cell.cellImage.backgroundColor = colors[indexPath.row]
            cell.cellImage.layer.cornerRadius = 10
        
        case 1: print("hi")
            
        default:
            print("error")
        }
        cell.accessoryType = .none
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        
        switch direction {
        case 0: UIApplication.shared.windows.forEach { window in
            window.tintColor = colors[indexPath.row]
        }
        case 1: print("hi")
        
        default:
            print("error")
        
        }
    }
    
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
}

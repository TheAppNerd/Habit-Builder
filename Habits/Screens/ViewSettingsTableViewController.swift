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
    let colorName = ["Black / White (Default)", "Red","Blue","Yellow","Green","Purple","Orange", "Indigo", "Teal"]
    
    let font = ["System","Helveltica Neue", "Chalkduster", "Arial", "Futara", "Papyrus", "Times New Roman"]
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(VisualsCell.self, forCellReuseIdentifier: VisualsCell.reuseID)
        tableView.separatorStyle = .none
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
      
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch direction {
        case 0: return colors.count
        
        case 1: return 0
        
        case 2: return font.count
        
        default:
            return 0
        }
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: VisualsCell.reuseID, for: indexPath) as! VisualsCell
       
        switch direction {
        case 0 : cell.cellLabel.text = colorName[indexPath.row]
                 cell.cellImage.backgroundColor = colors[indexPath.row]
        
        case 1: print("hi")
            
        case 2: cell.cellLabel.text = font[indexPath.row]
            cell.cellLabel.font = UIFont(name: font[indexPath.row], size: 16)
                //cell.cellImage.backgroundColor = colors[indexPath.row]
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
        
        switch direction {
        case 0: UIApplication.shared.windows.forEach { window in
            window.tintColor = colors[indexPath.row]
        }
        case 1: print("hi")
        
        case 2: HabitArray.font = UIFont(name: font[indexPath.row], size: 16)
            //determine a way to make this global.
        default:
            print("error")
        
        }
    }
    
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
}

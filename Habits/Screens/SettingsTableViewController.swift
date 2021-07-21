//
//  SettingsTableViewController.swift
//  Habits
//
//  Created by Alexander Thompson on 20/7/21.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    static let reuseIdentifier = "reuseID"
    
    let text = ["Change tint color", "Change app icon", "Change Font", "change color scheme"]
    let images = ["paintbrush", "paperplane.circle", "textformat", "paintpalette"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Appearance"
        tableView.register(DarkModeCell.self, forCellReuseIdentifier: DarkModeCell.reuseID)
        tableView.register(VisualsCell.self, forCellReuseIdentifier: VisualsCell.reuseID)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.isUserInteractionEnabled = true
//tint, dark mode, app icon, color scheme, eg / neon, pastel, etc, font

    }

    
    @objc func darkModeValueChanged(sender: UISegmentedControl) {
        var mode = traitCollection.userInterfaceStyle
        
        switch sender.selectedSegmentIndex {
        case 0: mode = UITraitCollection.current.userInterfaceStyle
        case 1: mode = UIUserInterfaceStyle.light
        case 2: mode = UIUserInterfaceStyle.dark
        default: mode = UITraitCollection.current.userInterfaceStyle
        }
        UIApplication.shared.windows.forEach { window in
            window.overrideUserInterfaceStyle = mode
        }
    }
    
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return 4
        default:
            return 0
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: DarkModeCell.reuseID, for: indexPath) as! DarkModeCell
            cell.darkModeSegment.addTarget(self, action: #selector(darkModeValueChanged), for: .valueChanged)
            return cell
        case 1: let cell = tableView.dequeueReusableCell(withIdentifier: VisualsCell.reuseID, for: indexPath) as! VisualsCell
            cell.cellImage.image = UIImage(systemName: images[indexPath.row])
            cell.cellLabel.text = text[indexPath.row]
            
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: DarkModeCell.reuseID, for: indexPath)
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch section {
        case 0: return "Dark Mode"
        case 1: return "Visual Settings"
        default:
            return ""
        }
    }

 
}

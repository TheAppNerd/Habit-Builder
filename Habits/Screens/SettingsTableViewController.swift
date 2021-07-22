//
//  SettingsTableViewController.swift
//  Habits
//
//  Created by Alexander Thompson on 20/7/21.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    static let reuseIdentifier = "reuseID"
    
    let oneText = ["Change tint color", "Change app icon", "Change font"]
    let oneImages = ["paintbrush", "paperplane.circle", "textformat", ]
    
    let twoText = ["Privacy", "About App"]
    let twoImages = ["hand.raised", "note.text"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Appearance"
        tableView.register(DarkModeCell.self, forCellReuseIdentifier: DarkModeCell.reuseID)
        tableView.register(VisualsCell.self, forCellReuseIdentifier: VisualsCell.reuseID)
 
        tableView.separatorStyle = .none
    }

    
    @objc func darkModeValueChanged(sender: UISegmentedControl) {
        var mode = traitCollection.userInterfaceStyle
        if #available(iOS 13.0, *) {
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
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return 3
        case 2: return 2
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
            cell.cellImage.image = UIImage(systemName: oneImages[indexPath.row])
            cell.cellLabel.text = oneText[indexPath.row]
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: VisualsCell.reuseID, for: indexPath) as! VisualsCell
                cell.cellImage.image = UIImage(systemName: twoImages[indexPath.row])
                cell.cellLabel.text = twoText[indexPath.row]
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
        case 2: return "App Details"
        default:
            return ""
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
        let ViewSettings = ViewSettingsTableViewController()
            ViewSettings.direction = indexPath.row
        navigationController?.pushViewController(ViewSettings, animated: true)
        }
    }
 
}

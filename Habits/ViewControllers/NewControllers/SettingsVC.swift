//
//  settingsVC.swift
//  Habits
//
//  Created by Alexander Thompson on 16/5/2022.
//

import UIKit

class SettingsVC: UIViewController {

    //MARK: - Properties
    
    var tableView = UITableView()
    
    //MARK: - Class Funcs
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureTableView()
    }
    
    //MARK: - Functions
    
    private func configure() {
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Settings"
        
        let dismissButton = UIBarButtonItem(image: UIImage(systemName: "xmark.circle"), style: .plain, target: self, action: #selector(dismissPressed))
        navigationItem.setRightBarButtonItems([dismissButton], animated: true)
    }
    
    
    private func configureTableView() {
        tableView = UITableView(frame: view.bounds, style: .insetGrouped)
        TableViewFuncs().setupTableView(for: .SettingsVC, using: tableView)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
    }
    
    //MARK: - @objc Funcs
    
    @objc func dismissPressed() {
        dismiss(animated: true, completion: nil)
    }
    
}

//MARK: - TableView - UITableViewDataSource, UITableViewDelegate

extension SettingsVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 2
        case 1: return 2
        case 2: return 2
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath {
        case [0,0]: let cell = tableView.dequeueReusableCell(withIdentifier: SettingsDarkModeCell.reuseID) as! SettingsDarkModeCell
                    return cell
        case [0,1]: let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTintCell.reuseID) as! SettingsTintCell
            return cell
        case [1,0]: let cell = tableView.dequeueReusableCell(withIdentifier: SettingsThemeCell.reuseID) as! SettingsThemeCell
            return cell
        case [1,1]: let cell = tableView.dequeueReusableCell(withIdentifier: SettingIconsCell.reuseID) as! SettingIconsCell
            return cell
        case [2,0]: let cell = tableView.dequeueReusableCell(withIdentifier: SettingsSwitchCell.reuseID) as! SettingsSwitchCell
            cell.set(switchSetting: .privacy)
            return cell
        case [2,1]: let cell = tableView.dequeueReusableCell(withIdentifier: SettingsSwitchCell.reuseID) as! SettingsSwitchCell
            cell.set(switchSetting: .haptics)
            return cell
        default:let cell = tableView.dequeueReusableCell(withIdentifier: SettingsSwitchCell.reuseID) as! SettingsSwitchCell
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath == [1,1] {
            return view.frame.height / 5
        } else {
            return view.frame.height / 15
        }
    }
    
    
    
}

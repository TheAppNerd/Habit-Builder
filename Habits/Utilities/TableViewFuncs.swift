//
//  TableViewFuncs.swift
//  Habits
//
//  Created by Alexander Thompson on 10/5/2022.
//

import UIKit

struct TableViewFuncs {
    
    enum selectedVC {
        case HabitHomeVC
        case NewHabitVC
        case SideMenuVC
        case AboutAppVC
        case SettingsVC
    }
    
    
    /// User selects which VC & tableview they are calling this func for and it will apply numerous tableView settings which bloat up the main VC.
    ///
    /// ```
    /// TableViewFuncs().setupTableView(for: .HabitHomeVC, using: tableView)
    /// ```
    ///
    /// - Warning: TableViewDelegate and DataSource still need to be called in the view controller.
    /// - Parameter selectedVC: enum to select which VC this method will apply to.
    /// - Parameter tableView: which tableView this method will apply to.
    func setupTableView(for viewController: selectedVC, using tableView: UITableView) {
        switch viewController {
        case .HabitHomeVC:
            tableView.register(HabitCell.self, forCellReuseIdentifier: HabitCell.reuseID)
            tableView.backgroundColor        = BackgroundColors.mainBackGround
            tableView.separatorStyle         = .none
            tableView.dragInteractionEnabled = true
            
        case .NewHabitVC:
            tableView.backgroundColor = BackgroundColors.mainBackGround
            tableView.allowsSelection = false
            tableView.separatorStyle  = .none
            tableView.register(HabitNameCell.self, forCellReuseIdentifier: HabitNameCell.reuseID)
            tableView.register(HabitFrequencyCell.self, forCellReuseIdentifier: HabitFrequencyCell.reuseID)
            tableView.register(HabitIconCell.self, forCellReuseIdentifier: HabitIconCell.reuseID)
            tableView.register(HabitReminderCell.self, forCellReuseIdentifier: HabitReminderCell.reuseID)
            tableView.register(HabitColorCell.self, forCellReuseIdentifier: HabitColorCell.reuseID)
            tableView.register(HabitSaveCell.self, forCellReuseIdentifier: HabitSaveCell.reuseID)
            
        case .SideMenuVC:
            tableView.backgroundColor    = BackgroundColors.secondaryBackground
            tableView.estimatedRowHeight = 70
            tableView.separatorStyle     = .none
            tableView.register(MenuCell.self, forCellReuseIdentifier: MenuCell.reuseID)
            
        case .AboutAppVC:
            tableView.separatorStyle     = .none
            tableView.rowHeight          = 50
            tableView.backgroundColor    = BackgroundColors.secondaryBackground
            tableView.bounces            = false
            tableView.layer.cornerRadius = 10
            tableView.translatesAutoresizingMaskIntoConstraints = false
            tableView.register(MenuCell.self, forCellReuseIdentifier: MenuCell.reuseID)
            
        case.SettingsVC:
            tableView.translatesAutoresizingMaskIntoConstraints = false
            tableView.allowsSelection = false
            tableView.register(SettingsSwitchCell.self, forCellReuseIdentifier: SettingsSwitchCell.reuseID)
            tableView.register(SettingsDarkModeCell.self, forCellReuseIdentifier: SettingsDarkModeCell.reuseID)
            tableView.register(SettingsDisclosureCell.self, forCellReuseIdentifier: SettingsDisclosureCell.reuseID)
        }
        
    }
    
}

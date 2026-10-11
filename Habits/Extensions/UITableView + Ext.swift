//
//  UITableView + Ext.swift
//  Habits
//
//  Created by Alexander Thompson on 27/5/2022.
//

import UIKit

extension UITableView {

    enum SelectedVC {
        case habitHomeVC
        case newHabitVC
        case sideMenuVC
        case aboutAppVC
    }

    /// User selects which VC & tableview they are calling this func for and it will apply numerous tableView settings which bloat up the main VC.
    ///
    /// ```
    /// tableView.setupTableView(for: .HabitHomeVC)
    /// ```
    ///
    /// - Warning: TableViewDelegate and DataSource still need to be called in the view controller.
    /// - Parameter selectedVC: enum to select which VC this method will apply to.
    /// - Parameter tableView: which tableView this method will apply to.
    func setup(for viewController: SelectedVC) {
        switch viewController {
        case .habitHomeVC:
            register(HabitCell.self, forCellReuseIdentifier: HabitCell.reuseID)
            backgroundColor        = BackgroundColors.mainBackGround
            separatorStyle         = .none
            dragInteractionEnabled = true

        case .newHabitVC:
            backgroundColor = BackgroundColors.mainBackGround
            allowsSelection = false
            separatorStyle  = .none
            register(HabitNameCell.self, forCellReuseIdentifier: HabitNameCell.reuseID)
            register(HabitFrequencyCell.self, forCellReuseIdentifier: HabitFrequencyCell.reuseID)
            register(HabitIconCell.self, forCellReuseIdentifier: HabitIconCell.reuseID)
            register(HabitReminderCell.self, forCellReuseIdentifier: HabitReminderCell.reuseID)
            register(HabitColorCell.self, forCellReuseIdentifier: HabitColorCell.reuseID)
            register(HabitSaveCell.self, forCellReuseIdentifier: HabitSaveCell.reuseID)

        case .sideMenuVC:
            backgroundColor    = BackgroundColors.secondaryBackground
            estimatedRowHeight = 70
            separatorStyle     = .none
            register(MenuCell.self, forCellReuseIdentifier: MenuCell.reuseID)

        case .aboutAppVC:
            separatorStyle     = .none
            rowHeight          = 50
            backgroundColor    = BackgroundColors.secondaryBackground
            bounces            = false
            layer.cornerRadius = 10
            translatesAutoresizingMaskIntoConstraints = false
            register(MenuCell.self, forCellReuseIdentifier: MenuCell.reuseID)
        }

        if #available(iOS 15, *) {
            self.sectionHeaderTopPadding = 0
        }
    }
}

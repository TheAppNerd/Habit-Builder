//
//  HabitVC.swift
//  Habits
//
//  Created by Alexander Thompson on 26/4/21.
//

import UIKit
import CoreData
import MessageUI

class HabitVC: UIViewController, SettingsPush {
    
    let context          = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let tableView        = UITableView()
    let menu             = MenuView()
    let generator        = UIImpactFeedbackGenerator(style: .medium)
    let emptyStateView   = EmptyStateView()
    
    var habitArray           = [HabitCoreData]()
    var isSlideInMenuPressed = false
    lazy var slideInMenuPadding: CGFloat = self.view.frame.width * 0.50
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showEmptyStateView()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCoreData()
        configureViewController()
        configureBarButtonItems()
        configureTableView()
    }
    
    
    func configureViewController() {
        title = Labels.homeTitle
        self.navigationController?.navigationBar.titleTextAttributes = [.font: UIFont.systemFont(ofSize: 25)]
        
        menuView.pinMenuTo(view, with: slideInMenuPadding)
        tableView.edgeTo(view, padding: 0)
        generator.prepare()
        menu.delegate = self
    }
    
    func configureBarButtonItems() {
        let menuButton  = UIBarButtonItem(image: SFSymbols.menuButton, style: .done, target: self, action: #selector(menuBarButtonPressed))
        let addButton   = UIBarButtonItem(image: SFSymbols.addHabitButton, style: .plain, target: self, action: #selector(addHabitPressed))
        navigationItem.setLeftBarButton(menuButton, animated: true)
        navigationItem.setRightBarButton(addButton, animated: true)
    }
    
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.register(HabitCell.self, forCellReuseIdentifier: HabitCell.reuseID)
        
        tableView.delegate        = self
        tableView.dataSource      = self
        tableView.frame           = view.bounds
        tableView.backgroundColor = .systemBackground
        tableView.separatorStyle  = .none
        
        //Sizing fix for older iphone models
        if view.frame.size.height < 800 {
            tableView.rowHeight = tableView.frame.height / 4.5
        } else {
            tableView.rowHeight = tableView.frame.height / 6
        }
    }
    
    lazy var menuView: UIView = {
        let view = UIView()
        view.addSubview(menu.view)
        menu.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            menu.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            menu.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            menu.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            menu.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        return view
    }()
    
    func showEmptyStateView() {
        if habitArray.isEmpty {
            view.addSubview(emptyStateView)
            emptyStateView.frame = tableView.frame
        } else {
            emptyStateView.removeFromSuperview()
        }
    }
    
    //make these extensions
    func getDayOfWeek() -> Int {
        let myCalendar = Calendar(identifier: .gregorian)
        let today = myCalendar.startOfDay(for: Date())
        let weekDay = myCalendar.component(.weekday, from: today)
        return weekDay
    }
    
    
    func pushSettings(row: Int) { // fix all this
        switch row {
        case 5:
            let vc = AboutViewController()
            navigationController?.pushViewController(vc, animated: true)
        case 3: let vc = HelpScreenViewController()
            navigationController?.pushViewController(vc, animated: true)
        case 6: let vc = DarkModeViewController()
            vc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            self.navigationController?.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            vc.modalTransitionStyle = .crossDissolve
            self.present(vc, animated: true, completion: nil)
        default:
            print("Error")
        }
    }
    
    
    @objc func menuBarButtonPressed() {
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
            self.emptyStateView.frame.origin.x = self.isSlideInMenuPressed ? 0 : self.emptyStateView.frame.width - self.slideInMenuPadding
            self.tableView.frame.origin.x      = self.isSlideInMenuPressed ? 0 : self.tableView.frame.width - self.slideInMenuPadding
        } completion: { (finished) in
            self.isSlideInMenuPressed.toggle()
        }
    }
    
    @objc func addHabitPressed() {
        let newHabitVC = NewHabitVC()
        newHabitVC.cellTag = habitArray.count
        show(newHabitVC, sender: self)
    }
    
    
    @objc func dateButtonPressed(_ sender: UIButton) {
        
        let habitCell = HabitCell()
        let selectedDate = DateFuncs.startOfDay(date: habitCell.dateArray[sender.tag])
        let buttonPosition: CGPoint = sender.convert(CGPoint.zero, to: self.tableView)
        guard let indexPath = self.tableView.indexPathForRow(at: buttonPosition) else { return }
        generator.impactOccurred()
        //change below to a switch or a toggle
        
        if sender.backgroundColor == .clear { //change clear to something less breakable
            habitArray[indexPath.row].habitDates?.append(selectedDate)
            CoreDataFuncs.saveCoreData()
            tableView.reloadData()
        } else {
            habitArray[indexPath.row].habitDates = habitArray[indexPath.row].habitDates?.filter {$0 != selectedDate}
            CoreDataFuncs.saveCoreData()
            tableView.reloadData()
        }
    }
    
    //fix this and move to coredata funcs
    func loadCoreData(with request: NSFetchRequest<HabitCoreData> = HabitCoreData.fetchRequest()) {
        
        do {
            let coreDataArray = try context.fetch(request)
            if coreDataArray.count != 0 {
                habitArray = coreDataArray
            }
        } catch {
            print("error loading context: \(error)")
        }
        tableView.reloadData()
    }
    
    
}

//MARK: - TableViewDelegate, TableViewDataSource

extension HabitVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return habitArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HabitCell.reuseID) as!HabitCell
        
        var buttonCount = 0
        var completedDays = 0
        
        let habit = habitArray[indexPath.row]
        habit.habitGradientIndex = habitArray[indexPath.row].habitGradientIndex
        cell.iconImage.image = UIImage(named: habit.iconString ?? "circle")
        cell.habitName.text = habit.habitName
        //to fix duplication issue need to move daybuttons and gradientcolors to a custom class
        cell.gradientColors = GradientArray.array[Int(habit.habitGradientIndex)]
        
        //This prevents duplication issues on reusable cells
        for (index,button) in cell.dayButton.enumerated() {
            button.backgroundColor = .clear
            button.layer.borderColor = UIColor.white.cgColor
            button.setTitle("\(cell.dayArray[index])", for: .normal)
            button.setImage(nil, for: .normal)
        }
        for button in cell.dayButton {
            button.addTarget(self, action: #selector(dateButtonPressed), for: .touchUpInside)
            button.tag = buttonCount
            
            let selectedDate = DateFuncs.startOfDay(date: cell.dateArray[buttonCount])
            
            //test that this resets when next week loads up after data retention added
            if habit.habitDates == nil {
                habit.habitDates = []
            }
            if habit.habitDates!.contains(selectedDate) {
                button.backgroundColor = UIColor.tertiarySystemBackground.withAlphaComponent(0.5)
                button.layer.borderColor = UIColor.tertiarySystemBackground.withAlphaComponent(0.5).cgColor
                button.setTitle(nil, for: .normal)
                button.setImage(UIImage(systemName: "checkmark"), for: .normal)
                completedDays += 1
            } else {
                button.backgroundColor = .clear
                button.layer.borderColor = UIColor.white.cgColor
            }
            buttonCount += 1
            
        }
        // replace with ternary operator?
        switch habit.alarmBool {
        case true: cell.alarmImage.image = UIImage(systemName: "bell.fill")
        case false: cell.alarmImage.image = UIImage(systemName: "bell.slash.fill")
        }
        
        //implement proper completion count here. change to something like 1/5 days per week. change icon to a tick is goal hit.
        
        
        cell.frequencyLabel.text = "\(completedDays) / \(habit.frequency) days"
        
        return cell
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let tableViewFooter = TableViewFooter(tableView: self.tableView)
        tableViewFooter.addHabitButton.addTarget(self, action: #selector(addHabitPressed), for: .touchUpInside)
        
        switch habitArray.isEmpty {
        case true: tableViewFooter.isHidden = true
        case false: tableViewFooter.isHidden = false
    }
        return tableViewFooter
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = HabitDetailsVC()
        vc.cellTag = indexPath.row
        vc.habitCoreData = habitArray[indexPath.row]
        
        let currentCell = tableView.cellForRow(at: indexPath)! as! HabitCell
        
        //move this to an animations file
        UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: .curveEaseIn) {
            currentCell.transform = CGAffineTransform(scaleX: 0.92, y: 0.92)
        } completion: { (_) in
            UIView.animate(withDuration: 0.05, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 2, options: .curveEaseIn) {
                currentCell.transform = CGAffineTransform(scaleX: 1, y: 1)
            } completion: { (_) in
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
    }
    
    





}

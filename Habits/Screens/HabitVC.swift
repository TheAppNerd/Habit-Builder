//
//  HabitVC.swift
//  Habits
//
//  Created by Alexander Thompson on 26/4/21.
//

import UIKit
import KDCalendar
import CoreData

class HabitVC: UIViewController, SettingsPush {
 
    var habitArray = [HabitCoreData]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    

    let tableView = UITableView()
    let menu = MenuView()
    let generator = UIImpactFeedbackGenerator(style: .medium)
    var isSlideInMenuPressed = false
    
    lazy var slideInMenuPadding: CGFloat = self.view.frame.width * 0.50
    var habitName: String = ""
    var dailyNumber: String = ""
    static var cellCount = 1
    var habitData = HabitData()
    static var habitBool = false
    let tableViewFooter = UIView()
    let emptyStateView = EmptyStateView()
  
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showEmptyStateView()
        
            }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadCoreData()
        resetHabits()
        configureViewController()
        configureTableView()
        configureTableViewFooter()
        tableView.reloadData()
    }
    
    func configureViewController() {
        title = "Habits"
        self.navigationController?.navigationBar.titleTextAttributes = [.font: UIFont.systemFont(ofSize: 25)]
        self.tabBarController?.tabBar.isHidden = false
        menuView.pinMenuTo(view, with: slideInMenuPadding)
        tableView.edgeTo(view, padding: 0)
        generator.prepare()
        menu.delegate = self
        let menuButton = UIBarButtonItem(image: UIImage(systemName: "sidebar.leading"), style: .done, target: self, action: #selector(menuBarButtonPressed))
        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus.app"), style: .plain, target: self, action: #selector(addHabitPressed))
        navigationItem.setLeftBarButton(menuButton, animated: true)
        navigationItem.rightBarButtonItems = [addButton]
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.backgroundColor = .systemBackground
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = tableView.frame.height / 6
        tableView.register(HabitCell.self, forCellReuseIdentifier: HabitCell.reuseID)
        tableView.separatorStyle = .none

    }
    
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
       menuBarButtonPressed()
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
    
    func getStartofWeek() -> Date {
        let today = Date()
            let gregorian = Calendar(identifier: .gregorian)
            let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: today))
        return gregorian.date(byAdding: .day, value: 1, to: sunday!)!
    }
    
    func setStartOfWeek() {
        let startOfWeek = getStartofWeek()
        HabitArray.startOfWeek = startOfWeek
    }
    
    func resetHabits() {
        if getStartofWeek() != HabitArray.startOfWeek {
            HabitVC.habitBool = true
            tableView.reloadData()
            setStartOfWeek()
            HabitVC.habitBool = false
        }
    }
    
   
    func pushSettings(row: Int) {
        switch row {
        case 5:
            let vc = SettingsTableViewController()
            navigationController?.pushViewController(vc, animated: true)
        case 4: let vc = HelpScreenViewController()
            navigationController?.pushViewController(vc, animated: true)
        default:
            print("Error")
        }
    }
    

    @objc func menuBarButtonPressed() {
       
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
            self.emptyStateView.frame.origin.x = self.isSlideInMenuPressed ? 0 : self.emptyStateView.frame.width - self.slideInMenuPadding
            self.tableView.frame.origin.x = self.isSlideInMenuPressed ? 0 : self.tableView.frame.width - self.slideInMenuPadding
        } completion: { (finished) in
            self.isSlideInMenuPressed.toggle()
        }

    }
    
   
    @objc func addHabitPressed() {
        HabitArray.habitCreated = false
        let addHabitVC = AddHabitVC()
        addHabitVC.cellTag = HabitVC.cellCount - 1
        navigationController?.pushViewController(addHabitVC, animated: true)
    }
    
    func startOfDay(date: Date) -> Date {
        let calendarView = CalendarView()
        let startDate = calendarView.calendar.startOfDay(for: date)
        return startDate
    }
    
    @objc func dateButtonPressed(_ sender: UIButton) {
        let habitCell = HabitCell()
        let selectedDate = startOfDay(date: habitCell.dateArray[sender.tag])
        let buttonPosition: CGPoint = sender.convert(CGPoint.zero, to: self.tableView)
        guard let indexPath = self.tableView.indexPathForRow(at: buttonPosition) else { return }
        generator.impactOccurred()
        //change below to a bool func which toggles on or off. 
        let decodedColor = habitArray[indexPath.row].habitColor?.decode()
        if sender.backgroundColor == .clear {
            sender.layer.borderColor = decodedColor?.darker(by: 20)?.cgColor
        sender.backgroundColor = decodedColor?.darker(by: 20)
            habitArray[indexPath.row].habitDates?.add(selectedDate)
            saveCoreData()
        } else {
            sender.backgroundColor = .clear
            sender.layer.borderColor = UIColor.white.cgColor
            habitArray[indexPath.row].habitDates?.remove(selectedDate)
            saveCoreData()
        }
        print(habitArray[indexPath.row].habitDates)
    }
    
    func loadCoreData(with request: NSFetchRequest<HabitCoreData> = HabitCoreData.fetchRequest()) {
        
        do {
            let array = try context.fetch(request)
            if array.count != 0 {
                habitArray = array
            }
        } catch {
            print("error loading context: \(error)")
        }
        tableView.reloadData()
    }
    
    func saveCoreData() {
        do {
            try context.save()
        } catch {
            print("error saving context: \(error)")
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
        let dataIndex = habitArray[indexPath.row]
        let decodedColor = dataIndex.habitColor?.decode()
        cell.habitName.text = dataIndex.habitName
        for button in cell.dayButton {
                        button.addTarget(self, action: #selector(dateButtonPressed), for: .touchUpInside)
            button.tag = buttonCount
            
            let selectedDate = startOfDay(date: cell.dateArray[buttonCount])
        
            //tese that this resets when next week loads up after data retention added
            if let dates = dataIndex.habitDates {
            if dates.contains(selectedDate) {
                button.backgroundColor = decodedColor?.darker(by: 30)
                button.layer.borderColor = decodedColor?.darker(by: 20)?.cgColor
            } else {
                button.backgroundColor = decodedColor
                button.layer.borderColor = UIColor.white.cgColor
            }
            }
            buttonCount += 1
        }
        
//        if dataIndex.alarmBool == true {
//            cell.alarmButton.setImage(UIImage(systemName: "bell.fill"), for: .normal)
//        } else {
//            cell.alarmButton.setImage(UIImage(systemName: "bell"), for: .normal)
//        }
        if dataIndex.frequency == 7 {
            cell.frequencyLabel.text = "Everyday"
        } else if dataIndex.frequency == 1 {
        cell.frequencyLabel.text = "1 day a week"
        } else {
            cell.frequencyLabel.text = "\(dataIndex.frequency) days a week"
        }
        
        cell.cellView.backgroundColor = decodedColor
        // Way to determine if target met. need to find a way to ensure it only occurrs once.
//        var truth = 0
//        for bool in HabitArray.array[indexPath.row].dayBool! {
//            if bool == true {
//                truth += 1
//            }
//        }
//        if truth >= Int(HabitArray.array[indexPath.row].weeklyFrequency!)! {
//                cell.cellView.layer.borderWidth = 2
//                cell.cellView.layer.borderColor = dataIndex.buttonColor?.cgColor
//
//
//        }
        
        return cell
    }
    
    func configureTableViewFooter() {
        tableView.tableFooterView = tableViewFooter
        tableViewFooter.frame.size = .init(width: tableView.frame.size.width, height: tableView.frame.size.width / 10)
        let addHabitButton = UIButton()
    addHabitButton.addTarget(self, action: #selector(addHabitPressed), for: .touchUpInside)
    addHabitButton.translatesAutoresizingMaskIntoConstraints = false
    addHabitButton.tintColor = .systemGreen
    addHabitButton.setImage(UIImage(systemName: "plus.app"), for: .normal)
    addHabitButton.setTitle(" Add a new habit", for: .normal)
    addHabitButton.setTitleColor(.systemGreen, for: .normal)
        
        tableViewFooter.addSubview(addHabitButton)
        NSLayoutConstraint.activate([
            addHabitButton.centerYAnchor.constraint(equalTo: tableViewFooter.centerYAnchor),
            addHabitButton.centerXAnchor.constraint(equalTo: tableViewFooter.centerXAnchor),
            addHabitButton.widthAnchor.constraint(equalTo: tableViewFooter.widthAnchor, constant: -20),
            addHabitButton.heightAnchor.constraint(equalTo: tableViewFooter.heightAnchor)
        ])
        if HabitVC.cellCount == 1 {
            tableViewFooter.isHidden = true
        } else {
            tableViewFooter.isHidden = false
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = HabitDetailsVC()
        vc.cellTag = indexPath.row
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
   
}




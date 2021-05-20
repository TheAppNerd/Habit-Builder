//
//  HabitVC.swift
//  Habits
//
//  Created by Alexander Thompson on 26/4/21.
//

import UIKit
import KDCalendar

class HabitVC: UIViewController {
    
    let tableView = UITableView()
    let menu = MenuView()
    let calendarView = CalendarView()
    let generator = UIImpactFeedbackGenerator(style: .medium)
    var isSlideInMenuPressed = false
    lazy var slideInMenuPadding: CGFloat = self.view.frame.width * 0.50
    var buttonCount = 0
    var tablePath = 0
    var habitName: String = ""
    var dailyNumber: String = ""
    static var cellCount = 1
    var habitData = HabitData()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showEmptyStateView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
        self.tabBarController?.tabBar.isHidden = false
        menuView.pinMenuTo(view, with: slideInMenuPadding)
        tableView.edgeTo(view)
        generator.prepare()

    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        let menuButton = UIBarButtonItem(image: UIImage(systemName: "sidebar.leading"), style: .done, target: self, action: #selector(menuBarButtonPressed))
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addHabitPressed))
        let helpButton = UIBarButtonItem(image: UIImage(systemName: "questionmark"), style: .plain, target: self, action: #selector(helpButtonPressed))
        navigationItem.setLeftBarButton(menuButton, animated: true)
        navigationItem.rightBarButtonItems = [addButton, helpButton]
        
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
        let emptyStateView = EmptyStateView()
        if HabitArray.Array.isEmpty {
            emptyStateView.frame = view.bounds
            view.addSubview(emptyStateView)
        } else if !HabitArray.Array.isEmpty {
            emptyStateView.removeFromSuperview()
        }
    }
    
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = tableView.frame.height / 6
        tableView.register(HabitCell.self, forCellReuseIdentifier: HabitCell.reuseID)
        tableView.separatorStyle = .none

    }
    
    @objc func menuBarButtonPressed() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseInOut) {
            self.tableView.frame.origin.x = self.isSlideInMenuPressed ? 0 : self.tableView.frame.width - self.slideInMenuPadding
        } completion: { (finished) in
            print("animation finished: \(finished)")
            self.isSlideInMenuPressed.toggle()
        }

    }
    
    @objc func addHabitPressed() {
        HabitArray.habitCreated = false
        
        navigationController?.pushViewController(AddHabitVC(), animated: true)

    }
    
    @objc func helpButtonPressed() {
        //enter functionality for help screen popup
    }
    
    func startOfDay(date: Date) -> Date {
        let startDate = calendarView.calendar.startOfDay(for: date)
        return startDate
    }
    
    //THESE ALL NEED TO RESET ON NEW WEEK. CLEAR THEM WITHOUT WIPING ARRAY
    @objc func dateButtonPressed(_ sender: UIButton) {
        let habitCell = HabitCell()
        let selectedDate = startOfDay(date: habitCell.dateArray[sender.tag])
        
        if sender.backgroundColor == .clear {
            sender.backgroundColor = UIColor(cgColor: sender.layer.borderColor!)
            HabitArray.Array[tablePath].dates.insert(selectedDate)
        } else {
            sender.backgroundColor = .clear
            HabitArray.Array[tablePath].dates.remove(selectedDate)
        }
        
        print(HabitArray.Array[tablePath].dates)
        
//        let today = calendarView.calendar.startOfDay(for: Date())
//        if !HabitArray.Array[sender.tag].dates.contains(today) {
//            HabitArray.Array[sender.tag].dates.append(today)
//            HabitArray.habitDates.insert(HabitArray.Array[sender.tag].dates, at: sender.tag)
//            print(HabitArray.Array[sender.tag].dates)
//            print(HabitArray.habitDates)
//        }
//        }
    


    func refresh() {
        tableView.reloadData()
    }

}
}
extension HabitVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HabitVC.cellCount - 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HabitCell.reuseID) as!HabitCell
        
        let dataIndex = HabitArray.Array[indexPath.row]
        tablePath = indexPath.row
        cell.habitName.text = dataIndex.habitName
        for button in cell.dayButton {
            button.addTarget(self, action: #selector(dateButtonPressed), for: .touchUpInside)
            button.layer.borderColor = dataIndex.buttonColor?.cgColor
            button.tag = buttonCount
            buttonCount += 1
        }
        cell.alarmButton.tintColor = dataIndex.buttonColor
        
//        cell.completionButton.tag = indexPath.row

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = HabitDetailsVC()
        vc.cellTag = indexPath.row
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}



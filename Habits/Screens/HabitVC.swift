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
        if HabitArray.array.isEmpty {
            emptyStateView.frame = view.bounds
            view.addSubview(emptyStateView)
        } else if !HabitArray.array.isEmpty {
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
        navigationController?.pushViewController(HelpScreenViewController(), animated: true)
    }
    
    func startOfDay(date: Date) -> Date {
        let startDate = calendarView.calendar.startOfDay(for: date)
        return startDate
    }
    
    @objc func dateButtonPressed(_ sender: UIButton) {
        let habitCell = HabitCell()
        let selectedDate = startOfDay(date: habitCell.dateArray[sender.tag])
        let buttonPosition: CGPoint = sender.convert(CGPoint.zero, to: self.tableView)
        guard let indexPath = self.tableView.indexPathForRow(at: buttonPosition) else { return }
        generator.impactOccurred()
        if sender.backgroundColor == .clear {
            sender.backgroundColor = UIColor(cgColor: sender.layer.borderColor!)
            HabitArray.habitDates[indexPath.row].insert(selectedDate)
        } else {
            sender.backgroundColor = .clear
            HabitArray.habitDates[indexPath.row].remove(selectedDate)
        }
    }

    func clearButtonPresses() {
        let currentStartofWeek = HabitCell().dateArray[0]
        print(currentStartofWeek)
    }

}

extension HabitVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HabitVC.cellCount - 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HabitCell.reuseID) as!HabitCell
        var buttonCount = 0
        let dataIndex = HabitArray.array[indexPath.row]
        cell.habitName.text = dataIndex.habitName
        for button in cell.dayButton {
            button.addTarget(self, action: #selector(dateButtonPressed), for: .touchUpInside)
            button.layer.borderColor = dataIndex.buttonColor?.cgColor
            button.tag = buttonCount
            buttonCount += 1
           

        }
    //bug here. bell icons wont change properly and different cells seems to interact with each other. 
//        if dataIndex.alarmBool == true {
//            cell.alarmButton.setImage(UIImage(systemName: "bell.fill"), for: .normal)
//        } else if dataIndex.alarmBool == false {
//            cell.alarmButton.setImage(UIImage(systemName: "bell.slash"), for: .normal)
//        }
        cell.alarmButton.tintColor = dataIndex.buttonColor
        if dataIndex.weeklyFrequency == "7" {
            cell.frequencyLabel.text = "Everyday"
        } else if dataIndex.weeklyFrequency == "1" {
        cell.frequencyLabel.text = "1 day a week"
        } else {
            cell.frequencyLabel.text = "\(dataIndex.weeklyFrequency!) days a week"
        }
        
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = HabitDetailsVC()
        vc.cellTag = indexPath.row
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}



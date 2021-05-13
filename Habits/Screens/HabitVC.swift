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
    
    var isSlideInMenuPressed = false
    lazy var slideInMenuPadding: CGFloat = self.view.frame.width * 0.30
    
    var habitName: String = ""
    var dailyNumber: String = ""
    static var cellCount = 1
    var habitData = HabitData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
        self.tabBarController?.tabBar.isHidden = false
        menuView.pinMenuTo(view, with: slideInMenuPadding)
        tableView.edgeTo(view)
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
    
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
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
    
    
    @objc func completePressed(_ sender: UIButton) {
        let buttonCount = HabitArray.Array[sender.tag].currentDailyCount!
        let totalCount = Int(HabitArray.Array[sender.tag].completionCount ?? "")!
        
        if buttonCount < totalCount {
        HabitArray.Array[sender.tag].currentDailyCount! += 1
            HabitArray.Array[sender.tag].progressCount! += (1.0 / Float(totalCount))
            tableView.reloadData()
        }
        
        let today = calendarView.calendar.startOfDay(for: Date())
        if !HabitArray.Array[sender.tag].dates.contains(today) {
            HabitArray.Array[sender.tag].dates.append(today)
            HabitArray.habitDates.insert(HabitArray.Array[sender.tag].dates, at: sender.tag)
        }
        }
        
    @objc func reducePressed(_ sender: UIButton) {
        let buttonCount = HabitArray.Array[sender.tag].currentDailyCount!
        let totalCount = Int(HabitArray.Array[sender.tag].completionCount ?? "")!
       
        if buttonCount > 0 {
        HabitArray.Array[sender.tag].currentDailyCount! -= 1
        HabitArray.Array[sender.tag].progressCount! -= (1.0 / Float(totalCount))
        tableView.reloadData()
            
            //implement a button to remove checkmark
    }
}
    func refresh() {
        tableView.reloadData()
    }


}
extension HabitVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HabitVC.cellCount - 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HabitCell.reuseID) as!HabitCell
        
        let dataIndex = HabitArray.Array[indexPath.row]
    
        cell.completionButton.addTarget(self, action: #selector(completePressed), for: .touchUpInside)
        cell.reduceButton.addTarget(self, action: #selector(reducePressed), for: .touchUpInside)
        cell.habitName.text = dataIndex.habitName
        cell.completionCount.text = "Daily Target: \(dataIndex.currentDailyCount ?? 0) out of \(dataIndex.completionCount!)"
        cell.completionButton.tintColor = dataIndex.buttonColor
        cell.completionButton.tag = indexPath.row
        cell.progressView.progressTintColor = dataIndex.buttonColor
        UIView.animate(withDuration: 1.0) {
            cell.progressView.setProgress(dataIndex.progressCount!, animated: true)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = HabitDetailsVC()
        vc.cellTag = indexPath.row
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
}


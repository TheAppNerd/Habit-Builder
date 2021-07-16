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
    static var habitBool = false
    
    let emptyStateView = EmptyStateView()
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showEmptyStateView()
        tableView.reloadData()
      resetHabits()
            }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
        self.tabBarController?.tabBar.isHidden = false
        menuView.pinMenuTo(view, with: slideInMenuPadding)
        tableView.edgeTo(view, padding: 0)
        generator.prepare()
       // resetHabits() //need to test this works when setting up core data
    }
    
    func configureViewController() {
        title = "Habits"
        
        view.backgroundColor = .secondarySystemBackground
        let menuButton = UIBarButtonItem(image: UIImage(systemName: "sidebar.leading"), style: .done, target: self, action: #selector(menuBarButtonPressed))
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addHabitPressed))
        let helpButton = UIBarButtonItem(image: UIImage(systemName: "questionmark"), style: .plain, target: self, action: #selector(helpButtonPressed))
        navigationItem.setLeftBarButton(menuButton, animated: true)
        navigationItem.rightBarButtonItems = [addButton, helpButton]
        
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
       
        if HabitArray.array.isEmpty {
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
    
    @objc func helpButtonPressed() {
        
        HelpScreenViewController().modalPresentationStyle = .popover
        HelpScreenViewController().popoverPresentationController?.sourceRect = CGRect(x: 0, y: 0, width: self.view.frame.width - 100, height: self.view.frame.height - 100)
        present(HelpScreenViewController(), animated: true)
        
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
        HabitArray.array[indexPath.row].dayBool![sender.tag] = true
        generator.impactOccurred()
        if sender.backgroundColor == .clear {
            sender.backgroundColor = UIColor(cgColor: sender.layer.borderColor!)
            sender.setTitleColor(.white, for: .normal)
            HabitArray.habitDates[indexPath.row].insert(selectedDate)
            
        } else {
            sender.backgroundColor = .clear
            sender.setTitleColor(UIColor(cgColor: sender.layer.borderColor!), for: .normal)
            HabitArray.habitDates[indexPath.row].remove(selectedDate)
            HabitArray.array[indexPath.row].dayBool![sender.tag] = false

        }
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
            button.setTitleColor(dataIndex.buttonColor, for: .normal) //use diff states to effect changes?
            button.tag = buttonCount
            
            //test this once data retention implemented. this is to reset habits
            if HabitVC.habitBool == true {
                HabitArray.array[indexPath.row].dayBool![buttonCount] = false
            }
            if HabitArray.array[indexPath.row].dayBool![buttonCount] == true {
                button.backgroundColor = UIColor(cgColor: button.layer.borderColor!)
            }
            
            buttonCount += 1
           
            if button.backgroundColor != .clear {
                button.setTitleColor(.white, for: .normal)
            }
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
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let tableViewFooter = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
            let addHabitButton = UIButton()
     
        //this code is to add an image to text but it isnt working. fix later
//        let plusIcon = NSTextAttachment()
//        plusIcon.image = UIImage(systemName: "plus.app")
//        let plusString = NSAttributedString(attachment: plusIcon)
//        let fullString = NSMutableAttributedString(attachment: plusString)
//        fullString.append(NSAttributedString(string: "Add a new habit"))
        addHabitButton.addTarget(self, action: #selector(addHabitPressed), for: .touchUpInside)
        addHabitButton.translatesAutoresizingMaskIntoConstraints = false
        addHabitButton.layer.borderWidth = 1
        addHabitButton.layer.cornerRadius = 10
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
        return tableViewFooter
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = HabitDetailsVC()
        vc.cellTag = indexPath.row
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}




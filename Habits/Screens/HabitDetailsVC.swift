//
//  HabitDetailsVC.swift
//  Habits
//
//  Created by Alexander Thompson on 2/5/21.
//

import UIKit
import KDCalendar

class HabitDetailsVC: UIViewController {

    //implement calendar layout here
    
    var cellTag: Int = 0
    var habitData = HabitData()
    var addHabitVC = AddHabitVC()
    let calendarView = CalendarView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureBarButtons()
        configureCalendarView()
        self.tabBarController?.tabBar.isHidden = true
        calendarView.delegate = self
    }
    
    private func configureBarButtons() {
        let backButton = UIBarButtonItem(barButtonSystemItem: .rewind, target: self, action: #selector(goBack))
        let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editHabit))
        
        navigationItem.leftBarButtonItem = backButton
        navigationItem.rightBarButtonItem = editButton
        
    }
 
    func configureCalendarView() {
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        //calendarView.style = .Default
        calendarView.frame = view.bounds
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
    }

    @objc func goBack() {
        navigationController?.pushViewController(HabitVC(), animated: true)
    }
    
    @objc func editHabit() {
        HabitArray.habitCreated = true
        addHabitVC.cellTag = cellTag
        let destVC = UINavigationController(rootViewController: AddHabitVC())
        destVC.modalPresentationStyle = .fullScreen
        present(destVC, animated: true)
    }
}

extension HabitDetailsVC: CalendarViewDelegate, CalendarViewDataSource {
    func calendar(_ calendar: CalendarView, didScrollToMonth date: Date) {
        <#code#>
    }
    
    func calendar(_ calendar: CalendarView, didSelectDate date: Date, withEvents events: [CalendarEvent]) {
        <#code#>
    }
    
    func calendar(_ calendar: CalendarView, canSelectDate date: Date) -> Bool {
        <#code#>
    }
    
    func calendar(_ calendar: CalendarView, didDeselectDate date: Date) {
        <#code#>
    }
    
    func calendar(_ calendar: CalendarView, didLongPressDate date: Date, withEvents events: [CalendarEvent]?) {
        <#code#>
    }
    
    func startDate() -> Date {
        <#code#>
    }
    
    func endDate() -> Date {
        <#code#>
    }
    
    func headerString(_ date: Date) -> String? {
        <#code#>
    }
    
    
    
}

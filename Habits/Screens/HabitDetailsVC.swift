//
//  HabitDetailsVC.swift
//  Habits
//
//  Created by Alexander Thompson on 2/5/21.
//

import UIKit
import KDCalendar

class HabitDetailsVC: UIViewController {

    
    var cellTag: Int = 0
    var habitData = HabitData()
    var addHabitVC = AddHabitVC()
    let calendarView = CalendarView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let date = Date()
        self.calendarView.setDisplayDate(date)
        
        for date in DateArray.dates {
        calendarView.selectDate(date)
        print(calendarView.selectedDates)
        
    }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureBarButtons()
        configureCalendarView()
        self.tabBarController?.tabBar.isHidden = true
       
    }
    
    private func configureBarButtons() {
        let backButton = UIBarButtonItem(barButtonSystemItem: .rewind, target: self, action: #selector(goBack))
        let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editHabit))
        
        navigationItem.leftBarButtonItem = backButton
        navigationItem.rightBarButtonItem = editButton
        
    }
 
    func configureCalendarView() {
        view.addSubview(calendarView)
        calendarView.delegate = self
        calendarView.dataSource = self
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        calendarView.direction = .horizontal
        calendarView.style.locale = Locale.current
        calendarView.style.weekdaysBackgroundColor = .blue
        
        let myStyle = CalendarView.Style()
        myStyle.cellBorderColor = UIColor.black
        myStyle.cellBorderWidth = 2.0
        self.calendarView.style = myStyle
        myStyle.cellShape = CalendarView.Style.CellShapeOptions.round
        
        myStyle.cellSelectedBorderColor = HabitArray.Array[cellTag].buttonColor!
        myStyle.cellTextColorDefault = .label
        myStyle.cellSelectedTextColor = .label
        

        
        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            calendarView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        
        ])
        
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
    
    }
    
    func calendar(_ calendar: CalendarView, didSelectDate date: Date, withEvents events: [CalendarEvent]) {
        //build in equation to determine current and longest streak based on days selected.
        //use map to put these in chronological order then fidn a way to see how many days are consecutive.
        //make it so dates cannot be unselected manually but you can click dates to edit them
        //make it so the tableview complete button appends the current date to an array if there is no identical date. when this page loads, select all the dates in said array
        //use calendarView.selectedDates which is an array of selected dates. make this array load the dates from the dates tab. 
        
    }
    
    func calendar(_ calendar: CalendarView, canSelectDate date: Date) -> Bool {
        return true
    }
    
    func calendar(_ calendar: CalendarView, didDeselectDate date: Date) {
        
    }
    
    func calendar(_ calendar: CalendarView, didLongPressDate date: Date, withEvents events: [CalendarEvent]?) {
     
    }
    
    func startDate() -> Date {
        var dateComponents = DateComponents()
        dateComponents.month = -24
        let today = Date()
        let twelveMonthsAgo = self.calendarView.calendar.date(byAdding: dateComponents, to: today)
        return twelveMonthsAgo!
    }
    
    func endDate() -> Date {
        var dateComponents = DateComponents()
        dateComponents.month = 24
        
        let today = Date()
        let twelveMonthsFromNow = self.calendarView.calendar.date(byAdding: dateComponents, to: today)
        return twelveMonthsFromNow!
    }
    
    func headerString(_ date: Date) -> String? {
        return nil
    }
    
    
    
}

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
    let currentStreak = BodyLabel()
    let bestStreak = BodyLabel()
    let noteLabel = BodyLabel()
    var biggestStreak: Int = 0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let date = Date()
        self.calendarView.setDisplayDate(date)
        if cellTag <= HabitArray.habitDates.count - 1 {
        for date in HabitArray.habitDates[cellTag] {
        calendarView.selectDate(date)
        }
//            noteLabel.text = HabitArray.Array[cellTag].habitNote ?? ""
    }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureBarButtons()
        configureCalendarView()
        self.tabBarController?.tabBar.isHidden = true
        title = HabitArray.Array[cellTag].habitName
        noteLabel.text = HabitArray.Array[cellTag].habitNote ?? ""
        currentStreak.text = "Current Streak: \(getCurrentStreak())"
        bestStreak.text = "Longest Streak: \(getBiggestStreak())"
    }
    
    private func configureBarButtons() {
        let backButton = UIBarButtonItem(barButtonSystemItem: .rewind, target: self, action: #selector(goBack))
        let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editHabit))
        
        navigationItem.leftBarButtonItem = backButton
        navigationItem.rightBarButtonItem = editButton
        
    }
 
    func configureCalendarView() {
       
        calendarView.delegate = self
        calendarView.dataSource = self
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        calendarView.direction = .horizontal
        calendarView.style.locale = Locale.current
        calendarView.style.weekdaysBackgroundColor = .blue
        
        currentStreak.text = "Current Streak: 10 Days"
        bestStreak.text = "Best Streak: 10 Days"
        
        let myStyle = CalendarView.Style()
        myStyle.cellBorderColor = UIColor.black
        myStyle.cellBorderWidth = 2.0
        self.calendarView.style = myStyle
        myStyle.cellShape = CalendarView.Style.CellShapeOptions.round
        
        myStyle.cellSelectedBorderColor = HabitArray.Array[cellTag].buttonColor!
        myStyle.cellTextColorDefault = .label
        myStyle.cellSelectedTextColor = .label
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        view.addSubview(calendarView)
        view.addSubview(currentStreak)
        view.addSubview(bestStreak)
        view.addSubview(noteLabel)
        
        let padding: CGFloat = 10
        
        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            calendarView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -400),
            
            currentStreak.topAnchor.constraint(equalTo: calendarView.bottomAnchor, constant: padding),
            currentStreak.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            currentStreak.trailingAnchor.constraint(equalTo: bestStreak.leadingAnchor, constant: -padding),
            currentStreak.heightAnchor.constraint(equalToConstant: 20),
            
            bestStreak.topAnchor.constraint(equalTo: calendarView.bottomAnchor, constant: padding),
            bestStreak.leadingAnchor.constraint(equalTo: currentStreak.trailingAnchor, constant: padding),
            bestStreak.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            bestStreak.heightAnchor.constraint(equalToConstant: 20),
            
            noteLabel.topAnchor.constraint(equalTo: bestStreak.bottomAnchor, constant: padding),
            noteLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            noteLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            noteLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80)
        ])
    }

    //move this to habitdata to save to coredata
    func getCurrentStreak() -> Int {
        let today = calendarView.calendar.startOfDay(for: Date())
        var streak = [Date]()
        let array = HabitArray.Array[cellTag].dates
        let sortedArray = array.sorted { $0.compare($1) == .orderedDescending }
        let dayAfter = Calendar.current.date(byAdding: .day, value: -1, to: today)
        for date in sortedArray {
            if array.contains(dayAfter!) {
                streak.append(date)
            } else {
                if HabitArray.Array[cellTag].currentDailyCount == 0 {
                    return streak.count
                } else {
                return streak.count + 1
                }
            }
        }
        return streak.count
    }
    
    //move this to habitdata to save to coredata
    func getBiggestStreak() -> Int {
        if getCurrentStreak() > biggestStreak {
            biggestStreak = getCurrentStreak()
        }
        return biggestStreak
    }
    
    @objc func goBack() {
        let destVC = UINavigationController(rootViewController: HabitVC())
        destVC.modalPresentationStyle = .fullScreen
        present(destVC, animated: true)
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
        return false
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

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
    var streak: Int = 0
    var biggestStreak: Int = 0
 
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let date = Date()
        self.calendarView.setDisplayDate(date)
        //            noteLabel.text = HabitArray.Array[cellTag].habitNote ?? ""
        updateDates()
        updateStreaks()
      
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureBarButtons()
        configureCalendarView()
        self.tabBarController?.tabBar.isHidden = true
        title = HabitArray.Array[cellTag].habitName
        noteLabel.text = HabitArray.Array[cellTag].habitNote ?? ""
        
    }
    
    func updateDates() {
        
        //ensures that index doesnt = nil before calling dates
        if cellTag <= HabitArray.habitDates.count - 1 {
        for date in HabitArray.habitDates[cellTag] {
        calendarView.selectDate(date)
        }
    }
    }
    
    func updateStreaks() {
        currentStreak.text = "Current Streak: \(streak)"
        bestStreak.text = "Longest Streak: \(getBiggestStreak())"
    }
    
    
    func presentAlertToAddHabit(date: Date) {
        
        let alert = UIAlertController(title: "Add Habit?", message: "Would you like to add a habit for this date?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { UIAlertAction in
            self.calendarView.selectDate(date)
            //HabitArray.Array[self.cellTag].dates.append(date)
            //HabitArray.habitDates.insert(HabitArray.Array[self.cellTag].dates, at: self.cellTag)
            //self.streak = self.getCurrentStreak()
            self.updateStreaks()
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { UIAlertAction in
            //self.calendarView.deselectDate(date)
            return
        }))
        present(alert, animated: true)
    }

    
    func presentAlertToRemoveHabit(date: Date) {
        let alert = UIAlertController(title: "Remove Habit?", message: "Would you like to remove the habit for this date?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { UIAlertAction in
            self.calendarView.deselectDate(date)
            //HabitArray.Array[self.cellTag].dates.removeLast()
            HabitArray.habitDates.remove(at: self.cellTag)
            //self.streak = self.getCurrentStreak()
            self.updateStreaks()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { UIAlertAction in
            //self.calendarView.selectDate(date)
            return
        }))
        present(alert, animated: true)
    }
    
    private func configureBarButtons() {
        let backButton = UIBarButtonItem(barButtonSystemItem: .rewind, target: self, action: #selector(goBack))
        let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editHabit))
        
        navigationItem.leftBarButtonItem = backButton
        navigationItem.rightBarButtonItem = editButton
        
    }
 
    //move calendarview to its own VC then input here as a subview.
    
    func configureCalendarView() {
       
        calendarView.delegate = self
        calendarView.dataSource = self
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        calendarView.direction = .horizontal
        calendarView.style.locale = Locale.current
        calendarView.backgroundColor = .clear

        let myStyle = CalendarView.Style()
        myStyle.cellBorderColor = .clear
        myStyle.cellBorderWidth = 1
        self.calendarView.style = myStyle
        myStyle.cellShape = CalendarView.Style.CellShapeOptions.round
        myStyle.cellColorDefault = .secondaryLabel
        myStyle.cellSelectedBorderColor = HabitArray.Array[cellTag].buttonColor!
        myStyle.cellTextColorDefault = .label
        myStyle.cellTextColorWeekend = .label
        myStyle.cellSelectedTextColor = .label
        myStyle.cellSelectedColor = HabitArray.Array[cellTag].buttonColor!
        
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
            calendarView.heightAnchor.constraint(equalToConstant: view.frame.height / 3),
           
            
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

    //move this to habitdata to save to coredata.
    //this doesnt work. redo it. use observers to update streaks as well
//    func getCurrentStreak() -> Int {
//        let startDate = calendarView.calendar.startOfDay(for: Date())
//        var streak = [Date]()
//        let array = HabitArray.Array[cellTag].dates
//        let sortedArray = array.sorted { $0.compare($1) == .orderedDescending }
//        var dateComponents = DateComponents()
//        dateComponents.day = -1
//
//        for date in sortedArray {
//            if sortedArray.contains(calendarView.calendar.date(byAdding: dateComponents, to: date)!)  {
//                streak.append(date)
//                continue
//            } else {
//                if HabitArray.Array[cellTag].currentDailyCount == 0 {
//                    return streak.count
//                } else {
//                return streak.count + 1
//                }
//            }
//        }
//        return streak.count
//    }
//
    
    
    //need to start from today and count backwards. break if nothing.
    
    //move this to habitdata to save to coredata. need to change this to take into account adding streaks manually to previous dates.
    func getBiggestStreak() -> Int {
        if streak > biggestStreak {
            biggestStreak = streak
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
        
    }
    
    func calendar(_ calendar: CalendarView, canSelectDate date: Date) -> Bool {
        if date < Date() {
            if calendarView.selectedDates.contains(date) {
            presentAlertToRemoveHabit(date: date)
            } else {
                presentAlertToAddHabit(date: date)
            }
        }
       return false
    }
    
    func calendar(_ calendar: CalendarView, didDeselectDate date: Date) {
        
    }
    
    func calendar(_ calendar: CalendarView, didLongPressDate date: Date, withEvents events: [CalendarEvent]?) {
     
    }
    
    func startDate() -> Date {
        var dateComponents = DateComponents()
        dateComponents.year = -2
        let today = Date()
        let twoYearsAgo = self.calendarView.calendar.date(byAdding: dateComponents, to: today)
        return twoYearsAgo!
    }
    
    func endDate() -> Date {
        var dateComponents = DateComponents()
        dateComponents.year = 2
        
        let today = Date()
        let twoYearsFromNow = self.calendarView.calendar.date(byAdding: dateComponents, to: today)
        return twoYearsFromNow!
    }
    
    func headerString(_ date: Date) -> String? {
        return nil
    }
    
    
    
}

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

    //var collectionView = UICollectionView()

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.calendarView.setDisplayDate(Date())
        updateDates()
//        updateStreaks()
        //configureCollectionView()
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureBarButtons()
        configureCalendarView()
        self.tabBarController?.tabBar.isHidden = true
        title = HabitArray.Array[cellTag].habitName
    }
    
    func updateDates() {
        //ensures that index doesnt = nil before calling dates
        if cellTag <= HabitArray.habitDates.count - 1 {
        for date in HabitArray.habitDates[cellTag] {
        calendarView.selectDate(date)
        }
    }
    }
    
//    func updateStreaks() {
//        currentStreak.text = "Current Weekly Streak: \(streak)"
//        bestStreak.text = "Longest Weekly Streak: \(getBiggestStreak())"
//        //totalDays.text = "Total days completed: \(getTotalDays())"
//    }
    
    
//    func configureCollectionView() {
//        collectionView = UICollectionView(frame: coll, collectionViewLayout: <#T##UICollectionViewLayout#>)
//        collectionView.register(BarChartCollectionViewCell.self, forCellWithReuseIdentifier: BarChartCollectionViewCell.reuseID)
//        collectionView.dataSource = self
//        collectionView.delegate = self
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
//
//        collectionView.collectionViewLayout = layout
//
//    }
    
    
    func presentAlertToAddHabit(date: Date) {
        let alert = UIAlertController(title: "Add Habit?", message: "Would you like to add a habit for this date?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { UIAlertAction in
            self.calendarView.selectDate(date)
            //HabitArray.Array[self.cellTag].dates.insert(date)
            HabitArray.habitDates[self.cellTag].insert(date)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { UIAlertAction in
            return
        }))
        present(alert, animated: true)
    }

    
    func presentAlertToRemoveHabit(date: Date) {
        let alert = UIAlertController(title: "Remove Habit?", message: "Would you like to remove the habit for this date?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { UIAlertAction in
            self.calendarView.deselectDate(date)
            //HabitArray.Array[self.cellTag].dates.remove(date)
            HabitArray.habitDates[self.cellTag].insert(date)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { UIAlertAction in
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
        myStyle.firstWeekday = .sunday
        myStyle.headerBackgroundColor = .red
        
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        view.addSubview(calendarView)
        view.addSubview(currentStreak)
        view.addSubview(bestStreak)
        //view.addSubview(collectionView)
        
       //collectionView.translatesAutoresizingMaskIntoConstraints = false
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
            
//            collectionView.topAnchor.constraint(equalTo: bestStreak.bottomAnchor, constant: 20),
//            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
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

//MARK: - Calendar View

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
        dateComponents.year = -5
        let today = Date()
        let twoYearsAgo = self.calendarView.calendar.date(byAdding: dateComponents, to: today)
        return twoYearsAgo!
    }
    
    func endDate() -> Date {
        var dateComponents = DateComponents()
        dateComponents.month = 1
        let today = Date()
        let oneMonthFromNow = self.calendarView.calendar.date(byAdding: dateComponents, to: today)
        return oneMonthFromNow!
    }
    
    func headerString(_ date: Date) -> String? {
        return nil
    }
}

extension HabitDetailsVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BarChartCollectionViewCell.reuseID, for: indexPath) as!BarChartCollectionViewCell
        return cell
    }
    
    
    
    
}

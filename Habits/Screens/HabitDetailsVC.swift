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
    
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    let habitCountView = HabitCountView()
    
   
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.calendarView.setDisplayDate(Date())
        updateDates()
//        updateStreaks()
        updateChart()
        addNewYear()

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureViewController()
        configureBarButtons()
        configureCalendarView()
        
      
        
        self.tabBarController?.tabBar.isHidden = true
        title = HabitArray.array[cellTag].habitName
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
    func getDayOfWeek(date: Date) -> Int {
        let myCalendar = Calendar(identifier: .gregorian)
        let today = myCalendar.startOfDay(for: date)
        let weekDay = myCalendar.component(.weekday, from: today)
        
        
        return weekDay
    }
    
    func presentAlertToAddHabit(date: Date) {
        let day = getDayOfWeek(date: date)
        
        let alert = UIAlertController(title: "Add Habit?", message: "Would you like to add a habit for this date?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { UIAlertAction in
            self.calendarView.selectDate(date)
            //HabitArray.Array[self.cellTag].dates.insert(date)
            HabitArray.habitDates[self.cellTag].insert(date)
            HabitArray.array[self.cellTag].dayBool![day - 1] = true
            
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
        calendarView.style.firstWeekday = .sunday
        let myStyle = CalendarView.Style()
        self.calendarView.style = myStyle
        myStyle.cellBorderColor = .clear
        myStyle.cellBorderWidth = 1
        myStyle.firstWeekday = .sunday
        myStyle.cellShape = CalendarView.Style.CellShapeOptions.round
        myStyle.cellColorDefault = .clear
        myStyle.cellSelectedBorderColor = HabitArray.array[cellTag].buttonColor!
        myStyle.cellTextColorDefault = .label
        myStyle.cellTextColorWeekend = .label
        myStyle.cellSelectedTextColor = .label
        myStyle.cellSelectedColor = HabitArray.array[cellTag].buttonColor!
      
        //myStyle.headerBackgroundColor = .red
        
    }
    
    private func configureViewController() {
        
        
        view.backgroundColor = .systemBackground
        view.addSubview(calendarView)
        view.addSubview(currentStreak)
        view.addSubview(bestStreak)
        view.addSubview(collectionView)
      
        
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
            
            collectionView.heightAnchor.constraint(equalToConstant: 200),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding)
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
        let addHabitVC = AddHabitVC()
        addHabitVC.cellTag = cellTag
        //let destVC = UINavigationController(rootViewController: AddHabitVC())
        //destVC.modalPresentationStyle = .fullScreen
        //present(destVC, animated: true)
        navigationController?.pushViewController(addHabitVC, animated: true)
    }
    
    func updateChart() {
        //HabitArray.habitDates[cellTag]
        //habitCountView.monthCount
        
        let calendar = Calendar(identifier: .gregorian)
        for date in HabitArray.habitDates[cellTag] {
            let monthCalc = calendar.dateComponents([.month], from: date)
            let month = monthCalc.month! - 1
            habitCountView.monthCount[month] += 1
        }
        habitCountView.color = HabitArray.array[cellTag].buttonColor!
        habitCountView.configureStackView()
}
    
    func getYear() -> Int { //this is used several times. move to one location for all views.
        let today = Date()
        let calendar = Calendar(identifier: .gregorian)
        let year = calendar.component(.year, from: today)
      
        return year
    }
    
    func addNewYear() {
        //loop through dict keys to get highest value. if current year != highest value append new dict with current year
        let latestYear = HabitArray.array[cellTag].year.keys.max()
        let currentYear = getYear()
        
        //test this
        if currentYear != latestYear {
            HabitArray.array[cellTag].year[currentYear] = [0,0,0,0,0,0,0,0,0,0,0,0]
        }
    }
    
  
    
    
    func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.frame.width - 30, height: 200)
        layout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ChartCell.self, forCellWithReuseIdentifier: ChartCell.reuseID)
        collectionView.isScrollEnabled = true
        collectionView.backgroundColor = .tertiarySystemBackground
        
    }
    
    func addSubView(view: UIView, subView: UIView) {
        view.addSubview(subView)
        
        NSLayoutConstraint.activate([
            subView.topAnchor.constraint(equalTo: view.topAnchor),
            subView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            subView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            subView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
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

//MARK: - collectionview

extension HabitDetailsVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      
        return HabitArray.array[cellTag].year.count
     
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChartCell.reuseID, for: indexPath) as! ChartCell
        for _ in 0...9 {
            let habitView = habitCountView
            addSubView(view: cell.cellView, subView: habitView)
        }
        
        return cell
    }
    
    
}


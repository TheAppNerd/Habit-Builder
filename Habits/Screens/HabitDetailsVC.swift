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
   
    
    let calendarBackgound = DividerView()
    let streakBackground = DividerView()
    let collectionBackground = DividerView()
    //put all these items in a divider view. create an extension with layout constraints to put on all thse and all the views in add habit
    
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    let habitCountView = HabitCountView()
    
   

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.calendarView.setDisplayDate(Date())
        updateDates()
        addNewYear()
        collectionView.reloadData()

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureViewController()
        configureBarButtons()
        configureCalendarView()
        configureStreakView()
        addNewYear()
        self.tabBarController?.tabBar.isHidden = true // is this needed?
        title = HabitArray.array[cellTag].habitName
        
    }
    
    func configureStreakView() {
        let streakImage = UIImageView(image: UIImage(systemName: "flame.fill"))
        streakImage.translatesAutoresizingMaskIntoConstraints = false
        let streakLabel = UILabel()
        streakLabel.translatesAutoresizingMaskIntoConstraints = false
        streakLabel.text = "Total Days Completed: 100"
        streakLabel.textAlignment = .left
        
        streakBackground.addSubviews(streakImage, streakLabel)
        let padding: CGFloat = 20
        NSLayoutConstraint.activate([
        
            streakImage.leadingAnchor.constraint(equalTo: streakBackground.leadingAnchor, constant: padding * 2),
            streakImage.trailingAnchor.constraint(equalTo: streakLabel.leadingAnchor, constant: -20),
            streakImage.topAnchor.constraint(equalTo: streakBackground.topAnchor, constant: padding),
            streakImage.bottomAnchor.constraint(equalTo: streakBackground.bottomAnchor, constant: -padding),
            streakImage.widthAnchor.constraint(equalTo: streakImage.heightAnchor),
            
            streakLabel.leadingAnchor.constraint(equalTo: streakImage.trailingAnchor, constant: padding),
            streakLabel.topAnchor.constraint(equalTo: streakBackground.topAnchor, constant: padding),
            streakLabel.bottomAnchor.constraint(equalTo: streakBackground.bottomAnchor, constant: -padding),
            streakLabel.trailingAnchor.constraint(equalTo: streakBackground.trailingAnchor, constant: padding)
        
        
        ])
    }
    
    
    func updateDates() {
        //ensures that index doesnt = nil before calling dates
        if cellTag <= HabitArray.habitDates.count - 1 {
        for date in HabitArray.habitDates[cellTag] {
        calendarView.selectDate(date)
        }
    }
    }
    

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
            HabitArray.habitDates[self.cellTag].insert(date)
            HabitArray.array[self.cellTag].dayBool![day - 1] = true
            self.viewDidLoad()
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
            HabitArray.habitDates[self.cellTag].remove(date)
            HabitArray.array[self.cellTag].chartDates = HabitArray.array[self.cellTag].chartDates.filter{$0 != date}
        
            self.viewDidLoad()
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
        
    }
    
    private func configureViewController() {
        
        
        view.backgroundColor = .secondarySystemBackground //change overall system background in assetts rather than here.
        view.addSubview(calendarBackgound)
        view.addSubview(streakBackground)
        view.addSubview(collectionBackground)
        
        calendarBackgound.backgroundColor = .tertiarySystemBackground
        streakBackground.backgroundColor = .tertiarySystemBackground
        collectionBackground.backgroundColor = .tertiarySystemBackground

        
        calendarView.edgeTo(calendarBackgound, padding: 20)
        currentStreak.edgeTo(streakBackground, padding: 20)
        collectionView.edgeTo(collectionBackground, padding: 20)
        
        let padding: CGFloat = 10
        
        NSLayoutConstraint.activate([
           calendarBackgound.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
           calendarBackgound.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
           calendarBackgound.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
           calendarBackgound.heightAnchor.constraint(equalToConstant: view.frame.height / 2.8),
           
            streakBackground.topAnchor.constraint(equalTo: calendarBackgound.bottomAnchor, constant: padding),
            streakBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            streakBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            streakBackground.bottomAnchor.constraint(equalTo: collectionBackground.topAnchor, constant: -padding),
            
            
            collectionBackground.heightAnchor.constraint(equalToConstant: view.frame.height / 2.8 + 30),
            collectionBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            collectionBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            collectionBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding * 2)
        ])
    }


    
    @objc func goBack() {
        let destVC = UINavigationController(rootViewController: HabitVC())
        destVC.modalPresentationStyle = .fullScreen
        
        present(destVC, animated: true)
    }
    
    @objc func editHabit() {
        HabitArray.habitCreated = true
        let addHabitVC = AddHabitVC()
        addHabitVC.cellTag = cellTag
       
        navigationController?.pushViewController(addHabitVC, animated: true)
    }
    
    func updateChart(habitView: HabitCountView) {
        //had to create a seperate array to insert dates into only if they hadnt already been added. stopped dates being counted twice.
        let calendar = Calendar(identifier: .gregorian)
        for date in HabitArray.habitDates[cellTag] {
            
            let monthCalc = calendar.dateComponents([.month], from: date)
            let yearCalc = calendar.dateComponents([.year], from: date)
            let year = yearCalc.year!
            let month = monthCalc.month! - 1
            
            //this code loops through all saved dates and assigns them to dict by going through year and then month and adding 1 to the count
            if !HabitArray.array[cellTag].chartDates.contains(date) {
            HabitArray.array[cellTag].year[year]![month] += 1
                HabitArray.array[cellTag].chartDates.append(date)
            }
        }
        
        habitView.color = HabitArray.array[cellTag].buttonColor!
        habitView.configureStackView()
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
    
  
    func getTotalDays() {
        var totalAmount = 0
        for year in HabitArray.array[cellTag].year {
            let yearTotal = year.value.reduce(0, +)
            totalAmount += yearTotal
        }
        print(totalAmount)
    }
   
    
    
    func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.frame.width - 40, height: view.frame.height / 2.8) // make this into a variable that also goes into nslayout constraint
        layout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ChartCell.self, forCellWithReuseIdentifier: ChartCell.reuseID)
        collectionView.isScrollEnabled = true
        collectionView.backgroundColor = .tertiarySystemBackground
        
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

extension HabitDetailsVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      
        return HabitArray.array[cellTag].year.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChartCell.reuseID, for: indexPath) as! ChartCell
       
    let earliestYear = HabitArray.array[cellTag].year.keys.min()
        let year = earliestYear! + indexPath.row
        cell.habitView.year = year
        cell.habitView.monthCount = HabitArray.array[cellTag].year[year]!
        updateChart(habitView: cell.habitView)
        cell.habitView.backgroundColor = .tertiarySystemBackground
        getTotalDays() // why does this only work from here? figure out how to update year dict properly. 
        return cell
        
    }
    
}


//
//  HabitDetailsVC.swift
//  Habits
//
//  Created by Alexander Thompson on 2/5/21.
//

import UIKit
import KDCalendar
import CoreData

class HabitDetailsVC: UIViewController {

    var habitCoreData: HabitCoreData?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var decodedColor: UIColor?

    var chartYears: [Int: [Int]] = [:]
    
    var cellTag: Int?
    var habitData = HabitData()
    let calendarView = CalendarView()
    let currentStreak = BodyLabel()
    let streakLabel = UILabel()
    let calendarBackgound = DividerView()
    let streakBackground = DividerView()
    let collectionBackground = DividerView()
    //put all these items in a divider view. create an extension with layout constraints to put on all thse and all the views in add habit
    
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    let habitCountView = HabitCountView()
   

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.calendarView.setDisplayDate(Date())
       
     
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewDidLoadlayout()
        configureViewController()
        configureBarButtons()
        configureCalendarView()
        configureStreakView()
        addNewYear()
        //self.tabBarController?.tabBar.isHidden = true // is this needed?
        title = habitCoreData?.habitName
        setupCalendarArea()
        updateDates()
       
    }
    
    func viewDidLoadlayout() {
        configureCollectionView()
    setupCollectionArea()
        streakLabel.text = "Total Days Completed: \(habitCoreData?.habitDates?.count ?? 0)"
    }
    
    
    
    private func saveCoreData() {
        do {
            try context.save()
        } catch {
            print("error saving context: \(error)")
        }
    }
        
    func configureStreakView() {
        let streakImage = UIImageView(image: UIImage(systemName: "flame.fill"))
        streakImage.translatesAutoresizingMaskIntoConstraints = false
        streakLabel.text = "Total Days Completed: \(habitCoreData?.habitDates?.count ?? 0)"
        streakLabel.translatesAutoresizingMaskIntoConstraints = false
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
    
    
    override func viewDidLayoutSubviews() {
        //loads the collection view as current year
        let section = 0
        let lastItemIndex = self.collectionView.numberOfItems(inSection: section) - 1
        let indexPath = IndexPath(item: lastItemIndex, section: section)
        self.collectionView.scrollToItem(at: indexPath, at: .right, animated: false)
    }
    
    func updateDates() {
        for date in habitCoreData!.habitDates! {
            calendarView.selectDate(date)
        }
    }
    
    
    func addDate(date: Date) {
        let calendar = Calendar(identifier: .gregorian)
        let monthCalc = calendar.dateComponents([.month], from: date)
        let yearCalc = calendar.dateComponents([.year], from: date)
        let year =  Int16(yearCalc.year!)
        let month = monthCalc.month
        habitCoreData?.habitDates?.append(date)
        }
    
    
    func removeDate(date: Date) {
        let calendar = Calendar(identifier: .gregorian)
        let monthCalc = calendar.dateComponents([.month], from: date)
        let yearCalc = calendar.dateComponents([.year], from: date)
        let year =  Int16(yearCalc.year!)
        let month = monthCalc.month
        habitCoreData?.habitDates = habitCoreData?.habitDates?.filter {$0 != date}
    }
    
    func presentAlertToAddHabit(date: Date) {
       // let day = getDayOfWeek(date: date)
        
        let alert = UIAlertController(title: "Add Habit?", message: "Would you like to add a habit for this date?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { UIAlertAction in
            self.calendarView.selectDate(date)
            self.addDate(date: date)
            self.saveCoreData()
            self.viewDidLoadlayout()
            
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
            self.removeDate(date: date)
            self.viewDidLoadlayout()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { UIAlertAction in
            return
        }))
        present(alert, animated: true)
    }
    
    func addNewYear() {
        if chartYears.count == 0 {
            chartYears[getYear()] = [0,0,0,0,0,0,0,0,0,0,0,0]
            chartYears[getYear()-1] = [0,0,0,0,0,0,0,0,0,0,0,0]
        }
            
        //loop through dict keys to get highest value. if current year != highest value append new dict with current year
        let latestYear = chartYears.keys.max()
        let currentYear = getYear()
        //test this
        if currentYear > latestYear! {
            chartYears[currentYear] = [0,0,0,0,0,0,0,0,0,0,0,0]
        }
    }
    
    func updateChart() {
        let calendar = Calendar(identifier: .gregorian)
        for year in chartYears.keys {
            chartYears[year] = [0,0,0,0,0,0,0,0,0,0,0,0]
        }
        //use guard here
        guard habitCoreData?.habitDates != nil else { return }
        for date in habitCoreData!.habitDates! {
                    
                    let monthCalc = calendar.dateComponents([.month], from: date)
                    let yearCalc = calendar.dateComponents([.year], from: date)
                    let year = yearCalc.year!
                    let month = monthCalc.month!-1
                    
                    chartYears[year]![month] += 1
                    }
                        }
        
    
    
    private func configureBarButtons() {
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left" ), style: .plain, target: self, action: #selector(goBack))
        let editButton = UIBarButtonItem(image: UIImage(systemName: "pencil.circle"), style: .plain, target: self, action: #selector(editHabit))
        
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
        myStyle.cellSelectedBorderColor = decodedColor ?? .clear
        myStyle.cellTextColorDefault = .label
        myStyle.cellTextColorWeekend = .label
        myStyle.cellSelectedTextColor = .label
        myStyle.cellSelectedColor = .blue
        
    }
    
    private func configureViewController() {
        
        
        view.backgroundColor = .secondarySystemBackground //change overall system background in assetts rather than here.
        view.addSubview(calendarBackgound)
        view.addSubview(streakBackground)
        view.addSubview(collectionBackground)
        
        calendarBackgound.backgroundColor = .tertiarySystemBackground
        streakBackground.backgroundColor = .tertiarySystemBackground
        collectionBackground.backgroundColor = .tertiarySystemBackground

        //calendarView.edgeTo(calendarBackgound, padding: 20)
        currentStreak.edgeTo(streakBackground, padding: 20)
//        collectionView.edgeTo(collectionBackground, padding: 20)
        
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

    //MARK: - collection view layout
    func setupCollectionArea() {
        
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = .white
        
        
        let collectionImage = UIImageView(image: UIImage(systemName: "chart.bar.xaxis"))
        collectionImage.layer.cornerRadius = 10
        collectionImage.tintColor = decodedColor
        collectionImage.backgroundColor = . clear
        collectionImage.translatesAutoresizingMaskIntoConstraints = false
        
        let collectionLabel = BodyLabel(textInput: "Monthly Count", textAlignment: .left, fontSize: 18)
    let infoLabel = BodyLabel(textInput: "Swipe to see more", textAlignment: .right, fontSize: 18)
    
    collectionBackground.addSubviews(collectionImage, collectionLabel, infoLabel, collectionView, line)
    let padding2: CGFloat = 20
    NSLayoutConstraint.activate([
        
        collectionImage.leadingAnchor.constraint(equalTo: collectionBackground.leadingAnchor, constant: padding2),
        collectionImage.topAnchor.constraint(equalTo: collectionBackground.topAnchor, constant: padding2),
        collectionImage.trailingAnchor.constraint(equalTo: collectionLabel.leadingAnchor, constant: -5),
        collectionImage.heightAnchor.constraint(equalToConstant: 40),
        collectionImage.widthAnchor.constraint(equalToConstant: 40),
        
        collectionLabel.leadingAnchor.constraint(equalTo: collectionImage.trailingAnchor, constant: 5),
        collectionLabel.trailingAnchor.constraint(equalTo: infoLabel.leadingAnchor, constant: -padding2),
        collectionLabel.topAnchor.constraint(equalTo: collectionBackground.topAnchor, constant: padding2),
        collectionLabel.heightAnchor.constraint(equalToConstant: 40),
        
        infoLabel.leadingAnchor.constraint(equalTo: collectionLabel.trailingAnchor, constant: padding2),
        infoLabel.trailingAnchor.constraint(equalTo: collectionBackground.trailingAnchor, constant: -20),
        infoLabel.topAnchor.constraint(equalTo: collectionBackground.topAnchor, constant: padding2),
        infoLabel.heightAnchor.constraint(equalToConstant: 40),
        
        line.leadingAnchor.constraint(equalTo: collectionImage.leadingAnchor),
        line.topAnchor.constraint(equalTo: collectionLabel.bottomAnchor, constant: 5),
        line.trailingAnchor.constraint(equalTo: infoLabel.trailingAnchor),
        line.heightAnchor.constraint(equalToConstant: 1),
        
        collectionView.leadingAnchor.constraint(equalTo: collectionBackground.leadingAnchor, constant: padding2),
        collectionView.trailingAnchor.constraint(equalTo: collectionBackground.trailingAnchor, constant: -padding2),
        collectionView.topAnchor.constraint(equalTo: line.bottomAnchor, constant: 5),
        collectionView.bottomAnchor.constraint(equalTo: collectionBackground.bottomAnchor, constant: -20)
    ])
    }
    //MARK: - calendarview layout
    func setupCalendarArea() {
    let line = UIView()
    line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = UIColor.white
    
        let calendarLabel = BodyLabel(textInput: "Habits Calendar", textAlignment: .left, fontSize: 18)

        let infoLabel = BodyLabel(textInput: "Swipe to see more", textAlignment: .right, fontSize: 18)
        
        let calendarImage = UIImageView(image: UIImage(systemName: "calendar"))
        calendarImage.layer.cornerRadius = 10
        calendarImage.tintColor = decodedColor
        calendarImage.backgroundColor = . clear
        calendarImage.translatesAutoresizingMaskIntoConstraints = false
        
        calendarBackgound.addSubviews(calendarImage, calendarLabel, infoLabel, calendarView, line)
        let padding2: CGFloat = 20
        NSLayoutConstraint.activate([
            
            calendarImage.leadingAnchor.constraint(equalTo: calendarBackgound.leadingAnchor, constant: padding2),
            calendarImage.topAnchor.constraint(equalTo: calendarBackgound.topAnchor, constant: padding2),
            calendarImage.trailingAnchor.constraint(equalTo: calendarLabel.leadingAnchor, constant: -5),
            calendarImage.heightAnchor.constraint(equalToConstant: 40),
            calendarImage.widthAnchor.constraint(equalToConstant: 40),
            
            calendarLabel.leadingAnchor.constraint(equalTo: calendarImage.trailingAnchor, constant: 5),
            calendarLabel.trailingAnchor.constraint(equalTo: infoLabel.leadingAnchor, constant: -padding2),
            calendarLabel.topAnchor.constraint(equalTo: calendarBackgound.topAnchor, constant: padding2),
            calendarLabel.heightAnchor.constraint(equalToConstant: 40),
            
            infoLabel.leadingAnchor.constraint(equalTo: calendarLabel.trailingAnchor, constant: padding2),
            infoLabel.trailingAnchor.constraint(equalTo: calendarBackgound.trailingAnchor, constant: -padding2),
            infoLabel.topAnchor.constraint(equalTo: calendarBackgound.topAnchor, constant: padding2),
            infoLabel.heightAnchor.constraint(equalToConstant: 40),
            
            line.leadingAnchor.constraint(equalTo: calendarImage.leadingAnchor),
            line.topAnchor.constraint(equalTo: calendarLabel.bottomAnchor, constant: 5),
            line.trailingAnchor.constraint(equalTo: infoLabel.trailingAnchor),
            line.heightAnchor.constraint(equalToConstant: 1),
            
            calendarView.leadingAnchor.constraint(equalTo: calendarBackgound.leadingAnchor, constant: padding2),
            calendarView.trailingAnchor.constraint(equalTo: calendarBackgound.trailingAnchor, constant: -padding2),
            calendarView.topAnchor.constraint(equalTo: line.bottomAnchor, constant: 10),
            calendarView.bottomAnchor.constraint(equalTo: calendarBackgound.bottomAnchor)
        ])
    }

    
    @objc func goBack() {
        let destVC = UINavigationController(rootViewController: HabitVC())
        destVC.modalPresentationStyle = .fullScreen
        
        present(destVC, animated: true)
    }
    
    @objc func editHabit() {
        let newHabitVC = NewHabitVC()
        newHabitVC.cellTag = cellTag!
        navigationController?.pushViewController(newHabitVC, animated: true)
    }
    
    
    
    
    func getYear() -> Int { //this is used several times. move to one location for all views.
        let today = Date()
        let calendar = Calendar(identifier: .gregorian)
        let year = calendar.component(.year, from: today)
      
        return year
    }
    
    func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.frame.width - 40, height: view.frame.height / 3.5) // make this into a variable that also goes into nslayout constraint
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
        if date < Date()
{
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
        dateComponents.year = -10
        let today = Date()
        let pastEndDate = self.calendarView.calendar.date(byAdding: dateComponents, to: today)
        return pastEndDate!
    }
    
    func endDate() -> Date {
        var dateComponents = DateComponents()
        dateComponents.year = 10
        let today = Date()
        let futureEndDate = self.calendarView.calendar.date(byAdding: dateComponents, to: today)
        return futureEndDate!
    }
    
    func headerString(_ date: Date) -> String? {
        return nil
    }
}

//MARK: - collectionview

extension HabitDetailsVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      
        return chartYears.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChartCell.reuseID, for: indexPath) as! ChartCell
        updateChart()
        let earliestYear = chartYears.keys.min()!
        let year = earliestYear + indexPath.row
        cell.habitView.year = year
        cell.habitView.monthCount = chartYears[year]!
        cell.habitView.color = .blue
        cell.habitView.configureStackView()
        cell.habitView.backgroundColor = .tertiarySystemBackground
        return cell
        
    }
    
}


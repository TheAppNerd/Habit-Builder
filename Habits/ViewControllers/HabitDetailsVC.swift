//
//  DetailsVCViewController.swift
//  Habits
//
//  Created by Alexander Thompson on 15/9/21.
//

import UIKit

import FSCalendar 

class HabitDetailsVC: UIViewController {
    
    //rewrite everything up to view did load
    
    //MARK: - Properties
    var habitEntity: HabitEnt? //naming conventions
    
    var habitIndex: Int? {
        didSet { // TODO: move these to a func
            habitEntity = coreData.loadHabitArray()[habitIndex!]
            let gradientColor = gradients.array[Int(habitEntity!.gradient)]
            habitDetailsChartView.setColor(colors: gradientColor)
            habitDetailsCalendarView.setColor(colors: gradientColor)
            habitDetailsStreakView.setColor(colors: gradientColor)
            chartYears = ChartModel.setChartData(habit: habitEntity!)
        }
    }
    
    
    var chartYears: [ChartYear]  = []
    var coreData            = CoreDataMethods()
    let habitDetailsCalendarView = HabitDetailsCalendarView()
    let habitDetailsStreakView   = HabitDetailsStreakView()
    let habitDetailsChartView    = HabitDetailsChartView()
    
    
    //MARK: - Class Funcs
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateStreaks()
        configureCalendarDates()
        configureViews()
        configureBarButtons()
        configureCollectionView()
        layoutUI()
    }
    
    override func viewDidLayoutSubviews() {
        //loads the collection view as current year
        habitDetailsChartView.collectionView.isPagingEnabled = false //paging turned off due to xcode bug which prevents scroll to item working when it is active.
        let section = 0
        let lastItemIndex = habitDetailsChartView.collectionView.numberOfItems(inSection: section) - 1
        let indexPath = IndexPath(item: lastItemIndex, section: section)
        habitDetailsChartView.collectionView.scrollToItem(at: indexPath, at: .right, animated: false)
        habitDetailsChartView.collectionView.isPagingEnabled = true
        
    }
    
    //MARK: - Functions
    
    private func configureViews() {
        title = habitEntity?.name
        view.backgroundColor = BackgroundColors.mainBackGround
        habitDetailsCalendarView.calendarView.dataSource = self
        habitDetailsCalendarView.calendarView.delegate = self
    }
    
    private func layoutUI() {
        view.addSubviews(habitDetailsCalendarView, habitDetailsStreakView, habitDetailsChartView)
        
        let padding: CGFloat = 10
        
        NSLayoutConstraint.activate([
            habitDetailsCalendarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            habitDetailsCalendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            habitDetailsCalendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            habitDetailsCalendarView.bottomAnchor.constraint(equalTo: habitDetailsStreakView.topAnchor,constant: -padding * 2),
            habitDetailsCalendarView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.31),
            
            habitDetailsStreakView.topAnchor.constraint(equalTo: habitDetailsCalendarView.bottomAnchor, constant: padding * 2),
            habitDetailsStreakView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            habitDetailsStreakView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            habitDetailsStreakView.bottomAnchor.constraint(equalTo: habitDetailsChartView.topAnchor,constant: -padding * 2),
            
            habitDetailsChartView.topAnchor.constraint(equalTo: habitDetailsStreakView.bottomAnchor, constant: padding * 2),
            habitDetailsChartView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            habitDetailsChartView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            habitDetailsChartView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -padding * 2),
            habitDetailsChartView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.31)
        ])
    }
    
   
    
    func configureCollectionView() {
        habitDetailsChartView.collectionView.dataSource = self
        habitDetailsChartView.collectionView.delegate = self
        habitDetailsChartView.collectionView.register(ChartCollectionViewCell.self, forCellWithReuseIdentifier: ChartCollectionViewCell.reuseID)
    }
    
    func configureCalendarDates() {
        let dateArray = CoreDataMethods().loadHabitDates(habit: habitEntity!)
        for date in dateArray {
            habitDetailsCalendarView.calendarView.select(date)
        }
    }
    
    
    func updateStreaks() {
        let dateCreated = habitEntity?.dateCreated ?? Date()
        let daysCompleted = CoreDataMethods().loadHabitDates(habit: habitEntity!).count
        
        // TODO: make a date func
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        let date = dateFormatter.string(from: dateCreated)
        
        let timeSinceCreated = Date().timeIntervalSince(dateCreated)
        let week: Double = 86400 * 7
        var totalWeeks = timeSinceCreated / week
        if totalWeeks < 1 {
            totalWeeks = 1
        }
        
        let averagePerWeek = Double(daysCompleted) / totalWeeks
        let averageString = String(format: "%.1f", averagePerWeek)
        
        habitDetailsStreakView.setLabels(date: date, count: daysCompleted, average: averageString)
    }
    
    // TODO: remove alert. make it happen on button press
    func presentAlertToAddHabit(date: Date) {
        let alert = UIAlertController(title: "Add Habit?", message: "Would you like to add a habit for this date?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { UIAlertAction in
            
            self.habitDetailsCalendarView.calendarView.select(date)
            self.coreData.addHabitDate(habit: self.habitEntity!, date: date)
            self.updateStreaks()
            self.chartYears = ChartModel.setChartData(habit: self.habitEntity!)
            self.habitDetailsChartView.collectionView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { UIAlertAction in
            self.habitDetailsCalendarView.calendarView.deselect(date)
            return
        }))
        present(alert, animated: true)
    }
    // TODO: remove alert. make it happen on button press
    func presentAlertToRemoveHabit(date: Date) {
        let alert = UIAlertController(title: "Remove Habit?", message: "Would you like to remove the habit for this date?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { UIAlertAction in
            self.habitDetailsCalendarView.calendarView.deselect(date)
            self.coreData.removeHabitDate(habit: self.habitEntity!, date: date)
            self.updateStreaks()
            self.chartYears = ChartModel.setChartData(habit: self.habitEntity!)
            self.habitDetailsChartView.collectionView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { UIAlertAction in
            self.habitDetailsCalendarView.calendarView.select(date)
            return
        }))
        present(alert, animated: true)
    }
    
    
    private func configureBarButtons() {
        let editButton = UIBarButtonItem(image: UIImage(systemName: "slider.horizontal.3"), style: .plain, target: self, action: #selector(editHabit))
        
        navigationItem.rightBarButtonItem = editButton
    }
    
    //MARK: - @Objc Funcs
    
    @objc func editHabit() {
        let newHabitVC = NewHabitVC()
        newHabitVC.habitIndex = habitIndex
        show(newHabitVC, sender: self)
    }
    
}

//MARK: - CollectionView - UICollectionViewDelegate, UICollectionViewDataSource

extension HabitDetailsVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return chartYears.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: habitDetailsChartView.collectionView.bounds.width, height: habitDetailsChartView.collectionView.bounds.height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChartCollectionViewCell.reuseID, for: indexPath) as! ChartCollectionViewCell
        let chartYear = chartYears[indexPath.row]
        cell.set(chartYear: chartYear)
        return cell
    }
}

//MARK: - FSCalendar

extension HabitDetailsVC: FSCalendarDataSource, FSCalendarDelegate {
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        presentAlertToAddHabit(date: date)
    }
    
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        presentAlertToRemoveHabit(date: date)
    }
    
}


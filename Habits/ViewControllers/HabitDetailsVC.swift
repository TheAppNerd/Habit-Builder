//
//  DetailsVCViewController.swift
//  Habits
//
//  Created by Alexander Thompson on 15/9/21.
//

import UIKit

import FSCalendar 

class HabitDetailsVC: UIViewController {
    
    //MARK: - Properties
    
    var habitIndex: Int?
    var habitEntity = HabitEnt()
    var chartYears: [ChartYear]  = []
    var coreData                 = CoreDataMethods.shared
    let habitDetailsCalendarView = HabitDetailsCalendarView()
    let habitDetailsStreakView   = HabitDetailsStreakView()
    let habitDetailsChartView    = HabitDetailsChartView()
    
    
    //MARK: - Class Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCalendarDates()
        configureViews()
        configureBarButtons()
        configureCollectionView()
        layoutUI()
        setColors()
        updateStreaks()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //loads the collection view as current year
        habitDetailsChartView.collectionView.isPagingEnabled = false //paging turned off due to xcode bug which prevents scroll to item working when it is active.
        let section = 0
        let lastItemIndex = habitDetailsChartView.collectionView.numberOfItems(inSection: section) - 1
        let indexPath = IndexPath(item: lastItemIndex, section: section)
        habitDetailsChartView.collectionView.scrollToItem(at: indexPath, at: .right, animated: false)
        habitDetailsChartView.collectionView.isPagingEnabled = true
    }
    
    //MARK: - Methods
    
    ///Takes all dates from habits dates in core data and selects them in the calendar.
    private func configureCalendarDates() {
        let dateArray = coreData.loadHabitDates(habit: habitEntity)
        for date in dateArray {
            habitDetailsCalendarView.calendarView.select(date)
        }
        habitDetailsCalendarView.calendarView.setCurrentPage(Date(), animated: false)
    }
    
    private func configureViews() {
        title = habitEntity.name
        view.backgroundColor = BackgroundColors.mainBackGround
        habitDetailsCalendarView.calendarView.dataSource = self
        habitDetailsCalendarView.calendarView.delegate = self
    }
    
    private func configureBarButtons() {
        let editButton = UIBarButtonItem(image: UIImage(systemName: "slider.horizontal.3"), style: .plain, target: self, action: #selector(editHabit))
        navigationItem.rightBarButtonItem = editButton
    }
    
    func configureCollectionView() {
        habitDetailsChartView.collectionView.dataSource = self
        habitDetailsChartView.collectionView.delegate = self
        habitDetailsChartView.collectionView.register(ChartCollectionViewCell.self, forCellWithReuseIdentifier: ChartCollectionViewCell.reuseID)
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
    
    ///Called from homeVC to setup this VC.
    func set(index: Int) {
        let habit = coreData.loadHabitArray()[index]
        habitEntity = habit
        habitIndex = index
        chartYears = ChartModel().setChartData(habit: habit)
        setColors()
    }
    
    ///Sets gradient colors in all views.
    func setColors() {
        let gradientColor = gradients.array[Int(habitEntity.gradient)]
        habitDetailsChartView.setColor(colors: gradientColor)
        habitDetailsCalendarView.setColor(colors: gradientColor)
        habitDetailsStreakView.setColor(colors: gradientColor)
    }
    
    ///Updates streak numbers whenever dates changed.
    func updateStreaks() {
        
        guard let dateCreated = habitEntity.dateCreated else { return }
        let daysCompleted     = coreData.loadHabitDates(habit: habitEntity).count
        let averageString     = dateCreated.calculateAverageStreak(days: daysCompleted)
        let dateString        = dateCreated.convertDateToString()
        
        habitDetailsStreakView.setLabels(date: dateString, count: daysCompleted, average: averageString)
    }
    
    /// Using FS calendar didSelect and didDeselect methods this updates everything with new habit date data.
    ///
    /// ```
    /// updateDates(amend: .addDate, date: date)
    /// ```
    ///
    /// - Parameter amend: amendDates enum to choose between adding or removing date
    /// - Parameter date: the date being added or removed. Listed in the FSCalendar method.
    func updateDates(amend: amendDates, date: Date) {
        switch amend {
        case .addDate:
            habitDetailsCalendarView.calendarView.select(date)
            coreData.addHabitDate(habit: habitEntity, date: date)
        case .removeDate:
            habitDetailsCalendarView.calendarView.deselect(date)
            coreData.removeHabitDate(habit: habitEntity, date: date)
        }
        updateStreaks()
        chartYears = ChartModel().setChartData(habit: self.habitEntity)
        habitDetailsChartView.collectionView.reloadData()
    }
    
    
    //MARK: - @Objc Funcs
    
    @objc func editHabit() {
        let newHabitVC        = NewHabitVC()
        if let index = habitIndex {
        newHabitVC.set(index: index)
        }
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

//MARK: - FSCalendar - FSCalendarDataSource, FSCalendarDelegate

extension HabitDetailsVC: FSCalendarDataSource, FSCalendarDelegate {
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        updateDates(amend: .addDate, date: date)
    }
    
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        updateDates(amend: .removeDate, date: date)
    }
}



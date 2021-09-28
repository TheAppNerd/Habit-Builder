//
//  DetailsVCViewController.swift
//  Habits
//
//  Created by Alexander Thompson on 15/9/21.
//

import UIKit

import FSCalendar // needed?

class DetailsVCViewController: UIViewController {
    
    var habitCoreData: HabitCoreData? {
        didSet {
            dates = (habitCoreData?.habitDates)! // needed?
        }
    }
    
    
    var chartArray = [ChartYear]()
    var chartYears: [Int: [Int]] = [:]
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var dates: [Date] = []
    
    
    
    //put all these items in a divider view. create an extension with layout constraints to put on all thse and all the views in add habit
    let habitDetailsCalendarView = HabitDetailsCalendarView()
    let habitDetailsStreakView = HabitDetailsStreakView()
    let habitDetailsChartView = HabitDetailsChartView()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateStreaks()
        //updateChartView()
        configureViews()
        updateCalendar()
        configureBarButtons()
        addNewYear()
        title = habitCoreData?.habitName
        configureCollectionView()
        updateChart()
    }

    func configureViews() {
        habitDetailsCalendarView.calendarView.dataSource = self
        habitDetailsCalendarView.calendarView.delegate = self
        view.addSubviews(habitDetailsCalendarView, habitDetailsStreakView, habitDetailsChartView)
        
        let padding: CGFloat = 10
        
        NSLayoutConstraint.activate([
        habitDetailsCalendarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
        habitDetailsCalendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
        habitDetailsCalendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
        habitDetailsCalendarView.bottomAnchor.constraint(equalTo: habitDetailsStreakView.topAnchor,constant: -padding),
        habitDetailsCalendarView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.35),
                                                                                         
        habitDetailsStreakView.topAnchor.constraint(equalTo: habitDetailsCalendarView.bottomAnchor, constant: padding),
        habitDetailsStreakView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
        habitDetailsStreakView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
        habitDetailsStreakView.bottomAnchor.constraint(equalTo: habitDetailsChartView.topAnchor,constant: -padding),
            
        habitDetailsChartView.topAnchor.constraint(equalTo: habitDetailsStreakView.bottomAnchor, constant: padding),
        habitDetailsChartView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
        habitDetailsChartView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
        habitDetailsChartView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -padding),
        habitDetailsChartView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.35)
        ])
        
        }
    
    override func viewDidLayoutSubviews() { //needed?
        //loads the collection view as current year
        let section = 0
        let lastItemIndex = habitDetailsChartView.collectionView.numberOfItems(inSection: section) - 1
        let indexPath = IndexPath(item: lastItemIndex, section: section)
        habitDetailsChartView.collectionView.scrollToItem(at: indexPath, at: .right, animated: false)
    }
    
    func configureCollectionView() {

        habitDetailsChartView.collectionView.dataSource = self
        habitDetailsChartView.collectionView.delegate = self
        habitDetailsChartView.collectionView.register(ChartCollectionCell.self, forCellWithReuseIdentifier: ChartCollectionCell.reuseID)
    }
    
    func updateCalendar() {
        habitDetailsCalendarView.gradientIndex = Int(habitCoreData!.habitGradientIndex)
        for date in dates {
            habitDetailsCalendarView.calendarView.select(date)
        }
    }
    
    func updateChartView() {
        //habitDetailsChartView.gradientIndex = Int(habitCoreData!.habitGradientIndex)
    }
    
    func updateStreaks() {
        habitDetailsStreakView.viewControllerHeight = Int(view.frame.size.height)
        habitDetailsStreakView.streakLabel.text = "Total Days Completed: \(dates.count)"
    }
    
    func presentAlertToAddHabit(date: Date) { //move this externally. to present add ability to link vc to func.
        // let day = getDayOfWeek(date: date)
        
        let alert = UIAlertController(title: "Add Habit?", message: "Would you like to add a habit for this date?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { UIAlertAction in
            self.habitDetailsCalendarView.calendarView.select(date)
            self.habitCoreData?.habitDates?.append(date)
            CoreDataFuncs.saveCoreData()
            self.habitDetailsStreakView.streakLabel.text = "Total Days Completed: \(self.habitCoreData?.habitDates?.count ?? 0)"
            self.updateChart()

            
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { UIAlertAction in
            self.habitDetailsCalendarView.calendarView.deselect(date)
            return
        }))
        present(alert, animated: true)
    }
    
    func presentAlertToRemoveHabit(date: Date) {
        let alert = UIAlertController(title: "Remove Habit?", message: "Would you like to remove the habit for this date?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { UIAlertAction in
            self.habitDetailsCalendarView.calendarView.deselect(date)
            self.habitCoreData?.habitDates = self.habitCoreData?.habitDates?.filter {$0 != date}
            self.habitDetailsStreakView.streakLabel.text = "Total Days Completed: \(self.habitCoreData?.habitDates?.count ?? 0)"
            self.updateChart()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { UIAlertAction in
            self.habitDetailsCalendarView.calendarView.select(date)
            return
        }))
        present(alert, animated: true)
    }
    
    
    private func configureBarButtons() {
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left" ), style: .plain, target: self, action: #selector(goBack))
        let editButton = UIBarButtonItem(image: UIImage(systemName: "slider.horizontal.3"), style: .plain, target: self, action: #selector(editHabit))
        
        navigationItem.leftBarButtonItem = backButton
        navigationItem.rightBarButtonItem = editButton
        
    }
    
    
    @objc func goBack() {
        CoreDataFuncs.saveCoreData() //stops tableview loading in random order on habitvc
        let destVC = UINavigationController(rootViewController: HabitVC())
        destVC.modalPresentationStyle = .fullScreen
        
        present(destVC, animated: true)
    }
    
    @objc func editHabit() {
        let newHabitVC = NewHabitVC()
        newHabitVC.habitCoreData = habitCoreData
        show(newHabitVC, sender: self)
    }
    
    //MARK: - chart funcs
    
    func addNewYear() { //move to class
        if chartYears.count == 0 {
            chartYears[DateModel().getYear()] = [0,0,0,0,0,0,0,0,0,0,0,0]
            chartYears[DateModel().getYear()-1] = [0,0,0,0,0,0,0,0,0,0,0,0]
        }
        
        //loop through dict keys to get highest value. if current year != highest value append new dict with current year
        let latestYear = chartYears.keys.max()
        let currentYear = DateModel().getYear()
        //test this
        if currentYear > latestYear! {
            chartYears[currentYear] = [0,0,0,0,0,0,0,0,0,0,0,0]
        }
    }
    
    func updateChart() { //move to class
        let calendar = Calendar.current
        
        //resets all charts to 0
        for year in chartYears.keys {
            chartYears[year] = [0,0,0,0,0,0,0,0,0,0,0,0]
        }
      
        guard habitCoreData?.habitDates != nil else { return }
        for date in habitCoreData!.habitDates! {
            
            let monthCalc = calendar.dateComponents([.month], from: date)
            let yearCalc = calendar.dateComponents([.year], from: date)
            let year = yearCalc.year!
            let month = monthCalc.month!-1
            
            chartYears[year]![month] += 1
        }
        
        for year in chartYears {
            
            let chartYear = ChartYear(year: year.key, monthCount: year.value, color: GradientArray.array[Int(habitCoreData!.habitGradientIndex)])
                
            chartArray.append(chartYear)
        }
        habitDetailsChartView.collectionView.reloadData()
    }
    
   
    
}

//MARK: - collectionview

extension DetailsVCViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return chartYears.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: habitDetailsChartView.collectionView.bounds.width, height: habitDetailsChartView.collectionView.bounds.height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChartCollectionCell.reuseID, for: indexPath) as! ChartCollectionCell
        
    
        let chartYear = chartArray[indexPath.row]
        cell.year = chartYear.year
        cell.monthCount = chartYear.monthCount
        cell.color = chartYear.color
        return cell
        
    }
    
}
//MARK: - calendar

extension DetailsVCViewController: FSCalendarDataSource, FSCalendarDelegate {
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        presentAlertToAddHabit(date: date)
    }
    
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        presentAlertToRemoveHabit(date: date)
    }
    
}


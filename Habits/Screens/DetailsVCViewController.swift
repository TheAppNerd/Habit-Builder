//
//  DetailsVCViewController.swift
//  Habits
//
//  Created by Alexander Thompson on 15/9/21.
//

import UIKit
import CoreData
import FSCalendar // needed?

class DetailsVCViewController: UIViewController {
    
    var habitCoreData: HabitCoreData? {
        didSet {
            dates = (habitCoreData?.habitDates)!
        }
    }
        
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var dates: [Date] = []

    var chartYears: [Int: [Int]] = [:]
    var cellTag: Int?
  
    //put all these items in a divider view. create an extension with layout constraints to put on all thse and all the views in add habit
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    let habitDetailsCalendarView = HabitDetailsCalendarView()
    let habitDetailsStreakView = HabitDetailsStreakView()
    let habitDetailsChartView = HabitDetailsChartView()

    override func viewDidLoad() {
        super.viewDidLoad()
        updateStreaks()
        updateChartView()
        configureViews()
        updateCalendar()
        configureBarButtons()
        
    }
    
    func configureViews() {
        habitDetailsCalendarView.calendarView.dataSource = self
        habitDetailsCalendarView.calendarView.delegate = self
        view.addSubviews(habitDetailsCalendarView)
        
        NSLayoutConstraint.activate([
            habitDetailsCalendarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            habitDetailsCalendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            habitDetailsCalendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            habitDetailsCalendarView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -400)
        ])
        
    }
    
    override func viewDidLayoutSubviews() {
        //loads the collection view as current year
        let section = 0
        let lastItemIndex = self.collectionView.numberOfItems(inSection: section) - 1
        let indexPath = IndexPath(item: lastItemIndex, section: section)
        self.collectionView.scrollToItem(at: indexPath, at: .right, animated: false)
    }
    
    func updateCalendar() {
        habitDetailsCalendarView.gradientIndex = Int(habitCoreData!.habitGradientIndex)
        for date in dates {
            habitDetailsCalendarView.calendarView.select(date)
        }
    }
    
    func updateChartView() {
        habitDetailsChartView.gradientIndex = Int(habitCoreData!.habitGradientIndex)
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
            //self.viewDidLoadlayout()
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
//            self.viewDidLoadlayout()
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
        let destVC = UINavigationController(rootViewController: HabitVC())
        destVC.modalPresentationStyle = .fullScreen
        
        present(destVC, animated: true)
    }
    
    @objc func editHabit() {
        let newHabitVC = NewHabitVC()
        newHabitVC.cellTag = cellTag!
        show(newHabitVC, sender: self)
    }
    
    //MARK: - chart funcs
    
    func addNewYear() { //move to class
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
    
    func updateChart() { //move to class
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
    
    func getYear() -> Int { //this is used several times. move to one location for all views.
        let today = Date()
        let calendar = Calendar(identifier: .gregorian)
        let year = calendar.component(.year, from: today)
      
        return year
    }
    
    func configureCollectionView() { //move this externally. refer to sean allen.
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.frame.width - 40, height: view.frame.height / 3.5) // make this into a variable that also goes into nslayout constraint
        layout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ChartCollectionCell.self, forCellWithReuseIdentifier: ChartCollectionCell.reuseID)
        collectionView.isScrollEnabled = true
        collectionView.backgroundColor = .tertiarySystemBackground
        
    }
    
}

//MARK: - collectionview

extension DetailsVCViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      
        return chartYears.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChartCollectionCell.reuseID, for: indexPath) as! ChartCollectionCell
        updateChart()
        let earliestYear = chartYears.keys.min()!
        let year = earliestYear + indexPath.row
        cell.year = year
        cell.color = GradientArray.array[Int(habitCoreData!.habitGradientIndex)]
        cell.monthCount = chartYears[year]!
        cell.configureStackView()

        
        return cell
        
    }
    
}

extension DetailsVCViewController: FSCalendarDataSource, FSCalendarDelegate {
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        presentAlertToAddHabit(date: date)
    }
    
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        presentAlertToRemoveHabit(date: date)
    }
    
}


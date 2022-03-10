//
//  DetailsVCViewController.swift
//  Habits
//
//  Created by Alexander Thompson on 15/9/21.
//

import UIKit

import FSCalendar 

class HabitDetailsVC: UIViewController {
    
    var habitEntity: HabitEnt? //naming conventions
    
    var habitIndex: Int? {
        didSet {
        habitEntity = habitEntities.loadHabitArray()[habitIndex!]
            let gradientColor = GradientArray.array[Int(habitEntity!.gradient)]
            habitDetailsChartView.setColor(colors: gradientColor)
            habitDetailsCalendarView.setColor(colors: gradientColor)
            habitDetailsStreakView.setColor(colors: gradientColor)
            chartYears = ChartModel.setChartData(habit: habitEntity!)
        }
    }
    

    var chartYears: [ChartYear] = []
    
    var habitEntities = HabitEntityFuncs()
    
    let habitDetailsCalendarView = HabitDetailsCalendarView()
    let habitDetailsStreakView = HabitDetailsStreakView()
    let habitDetailsChartView = HabitDetailsChartView()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateStreaks()
        configureCalendarDates()
        configureViews()
        configureBarButtons()
        
    }

    func configureViews() {
        title = habitEntity?.name
        configureCollectionView()
        view.backgroundColor = BackgroundColors.mainBackGround
        habitDetailsCalendarView.calendarView.dataSource = self
        habitDetailsCalendarView.calendarView.delegate = self
        view.addSubviews(habitDetailsCalendarView, habitDetailsStreakView, habitDetailsChartView)
        
        let padding: CGFloat = 10
        
        NSLayoutConstraint.activate([
        habitDetailsCalendarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
        habitDetailsCalendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
        habitDetailsCalendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
        habitDetailsCalendarView.bottomAnchor.constraint(equalTo: habitDetailsStreakView.topAnchor,constant: -padding * 2),
        habitDetailsCalendarView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.32),
                                                                                    
        habitDetailsStreakView.topAnchor.constraint(equalTo: habitDetailsCalendarView.bottomAnchor, constant: padding * 2),
        habitDetailsStreakView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
        habitDetailsStreakView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
        habitDetailsStreakView.bottomAnchor.constraint(equalTo: habitDetailsChartView.topAnchor,constant: -padding * 2),
            
        habitDetailsChartView.topAnchor.constraint(equalTo: habitDetailsStreakView.bottomAnchor, constant: padding * 2),
        habitDetailsChartView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
        habitDetailsChartView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
        habitDetailsChartView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -padding * 2),
        habitDetailsChartView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.32)
        ])
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
    
    func configureCollectionView() {
        habitDetailsChartView.collectionView.dataSource = self
        habitDetailsChartView.collectionView.delegate = self
        habitDetailsChartView.collectionView.register(ChartCollectionViewCell.self, forCellWithReuseIdentifier: ChartCollectionViewCell.reuseID)
    }
    
    func configureCalendarDates() {
        let dateArray = HabitEntityFuncs().loadHabitDates(habit: habitEntity!)
            for date in dateArray {
                habitDetailsCalendarView.calendarView.select(date)
                }
    }
    
    
    func updateStreaks() {
        let dateCreated = habitEntity?.dateCreated ?? Date()
        let daysCompleted = HabitEntityFuncs().loadHabitDates(habit: habitEntity!).count
        
        //make an extension?
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        let date = dateFormatter.string(from: dateCreated)
        
        let timeSinceCreated = Date().timeIntervalSince(dateCreated)
        let week: Double = 86400 * 7
        var totalWeeks = timeSinceCreated / week
        if totalWeeks < 1 {
            totalWeeks = 1
        }
    
        let averagePerWeek = daysCompleted / Int(totalWeeks)
        let averageString = String(averagePerWeek)
        
        habitDetailsStreakView.setLabels(date: date, count: daysCompleted, average: averageString)
    }
    
    func presentAlertToAddHabit(date: Date) {
        let alert = UIAlertController(title: "Add Habit?", message: "Would you like to add a habit for this date?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { UIAlertAction in
            self.habitDetailsCalendarView.calendarView.select(date)
            self.habitEntities.addHabitDate(habit: self.habitEntity!, date: date)
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
    
    func presentAlertToRemoveHabit(date: Date) {
        let alert = UIAlertController(title: "Remove Habit?", message: "Would you like to remove the habit for this date?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { UIAlertAction in
            self.habitDetailsCalendarView.calendarView.deselect(date)
            self.habitEntities.removeHabitDate(habit: self.habitEntity!, date: date)
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
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left" ), style: .plain, target: self, action: #selector(goBack))
        let editButton = UIBarButtonItem(image: UIImage(systemName: "slider.horizontal.3"), style: .plain, target: self, action: #selector(editHabit))
        
        navigationItem.leftBarButtonItem = backButton
        navigationItem.rightBarButtonItem = editButton
    }
    
    
    @objc func goBack() {
        CoreDataFuncs.saveCoreData() //stops tableview loading in random order on habitvc
        let destVC = UINavigationController(rootViewController: HabitHomeVC())
        destVC.modalPresentationStyle = .fullScreen
        
        present(destVC, animated: true)
    }
    
    @objc func editHabit() {
        let newHabitVC = NewHabitVC()
        newHabitVC.habitIndex = habitIndex
        //newHabitVC.habitEntity = habitEntity
        show(newHabitVC, sender: self)
    }
    
}

//MARK: - CollectionView

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


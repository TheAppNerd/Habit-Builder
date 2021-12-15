//
//  HabitVC.swift
//  Habits
//
//  Created by Alexander Thompson on 26/4/21.
//

import UIKit
import CoreData


class HabitHomeVC: UIViewController, SettingsPush {
    
    let tableView            = UITableView()
    let menu                 = SideMenuVC()
    let generator            = UIImpactFeedbackGenerator(style: .medium)
    let emptyStateView       = EmptyStateView()
    let habitArray = HabitEntities().loadHabitArray()
    
    
    var isSlideInMenuPressed = false
    lazy var slideInMenuPadding: CGFloat = self.view.frame.width * 0.50
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showEmptyStateView()
     
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureBarButtonItems()
        configureTableView()
        configureEmptyState()
        configureTableViewFooter()
        configureMenuView()
        

    }
    
    
    func showEmptyStateView() {
        switch habitArray.isEmpty {
        case true:  view.addSubview(emptyStateView)
            emptyStateView.frame = tableView.frame
        case false: emptyStateView.removeFromSuperview()
        }
    }
    
    
    func configureViewController() {
        title = Labels.HabitVCTitle
        self.navigationController?.navigationBar.titleTextAttributes = [.font: UIFont.systemFont(ofSize: 25)]
        view.backgroundColor = .systemBackground
        
        generator.prepare()
        
    }
    
    
    func configureBarButtonItems() {
        let menuButton  = UIBarButtonItem(image: SFSymbols.menuButton, style: .done, target: self, action: #selector(menuBarButtonPressed))
        let addButton   = UIBarButtonItem(image: SFSymbols.addHabitButton, style: .plain, target: self, action: #selector(addHabitPressed))
        navigationItem.setLeftBarButton(menuButton, animated: true)
        navigationItem.setRightBarButton(addButton, animated: true)
    }
    
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.register(HabitCell.self, forCellReuseIdentifier: HabitCell.reuseID)
        tableView.delegate        = self
        tableView.dataSource      = self
        tableView.frame           = view.bounds
        tableView.backgroundColor = .systemBackground
        tableView.separatorStyle  = .none
        
        //Sizing fix for older iphone models
        if view.frame.size.height < 800 {
            tableView.rowHeight = tableView.frame.height / 4.5
        } else {
            tableView.rowHeight = tableView.frame.height / 6
        }
    }
    
    func configureTableViewFooter() {
        
        let tableViewFooter = TableViewFooter()
        tableViewFooter.addHabitButton.addTarget(self, action: #selector(addHabitPressed), for: .touchUpInside)
        tableView.tableFooterView = tableViewFooter
        switch habitArray.isEmpty {
        case true: tableViewFooter.isHidden = true
        case false: tableViewFooter.isHidden = false
        }
    }
    
    
    
    
    
    func pushSettings(row: Int) {
        switch row {
        case 3: let vc = HowToUseVC()
            navigationController?.pushViewController(vc, animated: true)
        case 5:
            let vc = AboutAppVC()
            navigationController?.pushViewController(vc, animated: true)
        case 6: let vc = DarkModeVC()
            vc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            self.navigationController?.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            vc.modalTransitionStyle = .crossDissolve
            self.present(vc, animated: true, completion: nil)
        default:
            print("Error")
        }
    }
    
    
    @objc func helpButtonPressed() {
        let helpVC = HowToUseVC()
        show(helpVC, sender: self)
    }
    
    @objc func addHabitPressed() {
        let newHabitVC = NewHabitVC()
        show(newHabitVC, sender: self)
    }
    
    
    @objc func dateButtonPressed(_ sender: UIButton) {
        generator.impactOccurred()
        let selectedDate = DateModel.weeklyDateArray()[sender.tag]
        
        let buttonPosition: CGPoint = sender.convert(CGPoint.zero, to: self.tableView)
        guard let indexPath = self.tableView.indexPathForRow(at: buttonPosition) else { return }
        
        if sender.image(for: .normal) == SFSymbols.checkMark {
            //remove habit date
            //save core data
            //habitArray[indexPath.row]
            //if habit date contains selected date (if weeklydateArray[sender.tag)
        } else {
            //add habit date
            //save core data
            //habitArray[indexPath.row]
            //if habit date contains selected date
        }
        tableView.reloadData()
    }
    
    
 
    
    //MARK: - menu view
    
    func configureMenuView() {
        lazy var menuView: UIView = {
            let view = UIView()
            view.addSubview(menu.view)
            menu.view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                menu.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                menu.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                menu.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                menu.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
            return view
        }()
        
        menuView.pinMenuTo(view, with: slideInMenuPadding)
        tableView.edgeTo(view, padding: 0)
        menu.delegate = self
    }
    
    @objc func menuBarButtonPressed() { //change this to a push. can then load button presses from menuview, dismiss back to here and have it much cleaner.
        // move to animation file
        generator.impactOccurred()
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveLinear) {
            self.emptyStateView.frame.origin.x = self.isSlideInMenuPressed ? 0 : self.emptyStateView.frame.width - self.slideInMenuPadding
            self.tableView.frame.origin.x      = self.isSlideInMenuPressed ? 0 : self.tableView.frame.width - self.slideInMenuPadding
        } completion: { (finished) in
            self.isSlideInMenuPressed.toggle()
        }
    }
    
    func configureEmptyState() {
        emptyStateView.addHabitButton.addTarget(self, action: #selector(addHabitPressed), for: .touchUpInside)
        emptyStateView.howToUseButton.addTarget(self, action: #selector(helpButtonPressed), for: .touchUpInside)
    }
}

//MARK: - TableViewDelegate, TableViewDataSource

extension HabitHomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return habitArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HabitCell.reuseID) as!HabitCell
        
        let habit = habitArray[indexPath.row]
        let date = habit.datesSaved
        let habitDate = HabitDates()
        habitDate.date = Date()
        date?.addingObjects(from: [habitDate])
        //cell.habitGradient = [UIColor.clear.cgColor]
        cell.set(habit: habit)
        
        //find a way to search dates and compare them to current days fo week for completion count
        //if habit.datesSaved?.allObjects.contains(where: <#T##(Any) throws -> Bool#>)
        
        for (index,button) in cell.dayButton.enumerated() {
            button.layer.borderColor = UIColor.white.cgColor
            button.setTitle("\(DateModel.weeklyDayArray()[index])", for: .normal)
            button.setImage(nil, for: .normal)
            
            button.addTarget(self, action: #selector(dateButtonPressed), for: .touchUpInside)
            button.tag = index
            
            let selectedDate = DateFuncs.startOfDay(date: cell.dateArray[index])
            
            
//            if habit.habitDates!.contains(selectedDate) {
//                button.layer.borderColor = UIColor.clear.cgColor
//                button.setTitle(nil, for: .normal)
//                button.setImage(SFSymbols.checkMark, for: .normal)
//            } else {
//                button.backgroundColor = .clear
//                button.layer.borderColor = UIColor.white.cgColor
//            }
        }
        
        var completedDays = 0
        for button in cell.dayButton {
            if button.image(for: .normal) == SFSymbols.checkMark {
                completedDays += 1
            }
        }
        cell.habitCompletedDays = completedDays
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = HabitDetailsVC()
        //change this to a protocol instead?
        //vc.habitCoreData = habitArray[indexPath.row]
        
        let currentCell = tableView.cellForRow(at: indexPath)! as! HabitCell
        
        //move this to an animations file
        UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: .curveEaseIn) {
            currentCell.transform = CGAffineTransform(scaleX: 0.92, y: 0.92)
        } completion: { (_) in
            UIView.animate(withDuration: 0.05, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 2, options: .curveEaseIn) {
                currentCell.transform = CGAffineTransform(scaleX: 1, y: 1)
            } completion: { (_) in
                self.show(vc, sender: self)
            }
        }
    }
}

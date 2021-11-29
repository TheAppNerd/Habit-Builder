//
//  HabitVC.swift
//  Habits
//
//  Created by Alexander Thompson on 26/4/21.
//

import UIKit
import CoreData
import MessageUI

class HabitVC: UIViewController, SettingsPush {
    
    let context              = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let tableView            = UITableView()
    let menu                 = MenuView()
    let generator            = UIImpactFeedbackGenerator(style: .medium)
    let emptyStateView       = EmptyStateView()
    let dateModel            = DateModel()
    static var habitArray           = [HabitCoreData]()
    var isSlideInMenuPressed = false
    lazy var slideInMenuPadding: CGFloat = self.view.frame.width * 0.50
    var habitArray = [HabitModel]()
    var habitModelArray = [HabitModel]() //do I actually need this with core data one?
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showEmptyStateView()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCoreData()
        configureViewController()
        configureBarButtonItems()
        configureTableView()
        configureEmptyState()
        configureTableViewFooter()
    }
    
    
    func configureViewController() {
        title = Labels.HabitVCTitle
        self.navigationController?.navigationBar.titleTextAttributes = [.font: UIFont.systemFont(ofSize: 25)]
        view.backgroundColor = .systemBackground
        menuView.pinMenuTo(view, with: slideInMenuPadding)
        tableView.edgeTo(view, padding: 0)
        generator.prepare()
        menu.delegate = self
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
        switch HabitVC.habitArray.isEmpty {
        case true: tableViewFooter.isHidden = true
        case false: tableViewFooter.isHidden = false
        }
    }
    
    
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
    
    func showEmptyStateView() {
        switch HabitVC.habitArray.isEmpty {
        case true:  view.addSubview(emptyStateView)
            emptyStateView.frame = tableView.frame
        case false: emptyStateView.removeFromSuperview()
        }
    }
    
    
    func pushSettings(row: Int) { // fix all this
        switch row {
        case 3: let vc = HelpScreenViewController()
            navigationController?.pushViewController(vc, animated: true)
        case 5:
            let vc = AboutViewController()
            navigationController?.pushViewController(vc, animated: true)
        case 6: let vc = DarkModeViewController()
            vc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            self.navigationController?.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            vc.modalTransitionStyle = .crossDissolve
            self.present(vc, animated: true, completion: nil)
        default:
            print("Error")
        }
    }
    
    func configureEmptyState() {
        emptyStateView.addHabitButton.addTarget(self, action: #selector(addHabitPressed), for: .touchUpInside)
        
        emptyStateView.howToUseButton.addTarget(self, action: #selector(helpButtonPressed), for: .touchUpInside)
    }
    
    @objc func helpButtonPressed() {
        let helpVC = HelpScreenViewController()
        show(helpVC, sender: self)
    }
    
    
    @objc func menuBarButtonPressed() { //change this to a push. can then load button presses from menuview, dismiss back to here and have it much cleaner.
        // move to animation file
        generator.impactOccurred()
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
            self.emptyStateView.frame.origin.x = self.isSlideInMenuPressed ? 0 : self.emptyStateView.frame.width - self.slideInMenuPadding
            self.tableView.frame.origin.x      = self.isSlideInMenuPressed ? 0 : self.tableView.frame.width - self.slideInMenuPadding
        } completion: { (finished) in
            self.isSlideInMenuPressed.toggle()
        }
    }
    
    @objc func addHabitPressed() {
        let newHabitVC = NewHabitVC()
        //        newHabitVC.cellTag = HabitVC.habitArray.count //new method to remove celltags
        show(newHabitVC, sender: self)
    }
    
    
    @objc func dateButtonPressed(_ sender: UIButton) {
        
        let habitCell = HabitCell()
        let selectedDate = DateFuncs.startOfDay(date: habitCell.dateArray[sender.tag])
        let buttonPosition: CGPoint = sender.convert(CGPoint.zero, to: self.tableView)
        guard let indexPath = self.tableView.indexPathForRow(at: buttonPosition) else { return }
        generator.impactOccurred()
        //change below to a switch or a toggle
        
        //change all this to only occur here or in tasbleview func. too much spaghetti code
        if sender.backgroundColor == .clear {
            //change clear to something less breakable like is selected
            HabitVC.habitArray[indexPath.row].habitDates?.append(selectedDate)
            CoreDataFuncs.saveCoreData()
            tableView.reloadData()
        } else {
            HabitVC.habitArray[indexPath.row].habitDates = HabitVC.habitArray[indexPath.row].habitDates?.filter {$0 != selectedDate}
            CoreDataFuncs.saveCoreData()
            tableView.reloadData()
        }
    }
    
    //fix this and move to coredata funcs
    func loadCoreData(with request: NSFetchRequest<HabitCoreData> = HabitCoreData.fetchRequest()) {
        
        do {
            let coreDataArray = try context.fetch(request)
            HabitVC.habitArray = coreDataArray
        } catch {
            print("error loading context: \(error)")
        }
        tableView.reloadData()
    }
 
    
}

//MARK: - TableViewDelegate, TableViewDataSource

extension HabitVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HabitVC.habitArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HabitCell.reuseID) as!HabitCell
        
        let habit                = HabitVC.habitArray[indexPath.row]
       
        
        var completedDays = 0
        var buttonCount          = 0
        
        for (index,button) in cell.dayButton.enumerated() {
            
            //This prevents duplication issues on reusable cells
            //move all of this to set?
            button.backgroundColor   = .clear
            button.layer.borderColor = UIColor.white.cgColor
            button.setTitle("\(cell.dayArray[index])", for: .normal)
            button.setImage(nil, for: .normal)
            
            button.addTarget(self, action: #selector(dateButtonPressed), for: .touchUpInside)
            button.tag = buttonCount //apply tag in cell instead? then wont need buttoncount
            
            let selectedDate = DateFuncs.startOfDay(date: cell.dateArray[buttonCount])
            
            if habit.habitDates!.contains(selectedDate) {
                button.backgroundColor   = Colors.tertiaryWithAlpha
                button.layer.borderColor = UIColor.clear.cgColor //Colors.tertiaryWithAlpha.cgColor
                button.setTitle(nil, for: .normal)
                button.setImage(SFSymbols.checkMark, for: .normal)
            } else {
                button.backgroundColor = .clear
                button.layer.borderColor = UIColor.white.cgColor
            }
            buttonCount += 1
        }
     
        for button in cell.dayButton {
            if button.image(for: .normal) == SFSymbols.checkMark {
                completedDays += 1
        }
        }
        cell.habitCompletedDays = completedDays
        cell.set(habit: habit)
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailsVCViewController()
        vc.habitCoreData = HabitVC.habitArray[indexPath.row]
        
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

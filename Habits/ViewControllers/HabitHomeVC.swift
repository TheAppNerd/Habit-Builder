//
//  HabitVC.swift
//  Habits
//
//  Created by Alexander Thompson on 26/4/21.
//

import UIKit
import CoreData


class HabitHomeVC: UIViewController, SettingsPush {
    
    //MARK: - Properties
    
    let tableView            = UITableView()
    let menu                 = SideMenuVC()
    let generator            = UIImpactFeedbackGenerator(style: .medium) // TODO: move to protocol
    let emptyStateView       = EmptyStateView()
    var quoteButtonTapped    = Bool()
    let habitEntities        = CoreDataMethods() //need to rename
    var quotesManager        = QuotesManager()
    var quotesArray: [Quote] = [] // TODO: move to func
    
    // TODO: - rework side menu
    var isSlideInMenuPressed = false
    lazy var slideInMenuPadding: CGFloat = self.view.frame.width * 0.50
    
    //MARK: - Class Funcs
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showEmptyStateView()
        timerForCloudKit() // TODO: move to completion closure
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureBarButtonItems()
        configureTableView()
        configureEmptyState()
        configureTableViewFooter()
        configureMenuView()
        quoteButtonTapped = false
        
        // TODO: - move these into own func
        quotesManager.delegate = self
        DispatchQueue.global(qos: .background).async {
            self.quotesManager.parse()
        }
        reviewCount()
        
    }
    
    //MARK: - Functions
    
    func showEmptyStateView() { // TODO:  move externally
        switch habitEntities.loadHabitArray().isEmpty {
        case true:  view.addSubview(emptyStateView)
            emptyStateView.frame = tableView.frame
        case false: emptyStateView.removeFromSuperview()
        }
    }
    
    
    func configureViewController() {
        navigationController?.navigationBar.titleTextAttributes = [.font: UIFont.systemFont(ofSize: 25)]
        view.backgroundColor = BackgroundColors.mainBackGround
        generator.prepare()
    }
    
    
    func reviewCount() { // TODO: move externally
        let defaults = UserDefaults.standard
        var retrievedCount = defaults.integer(forKey: "reviewCount") as Int
        retrievedCount += 1
        
        if retrievedCount.isMultiple(of: 10) {
            AppStoreManagerReview.requestReviewIfAppropriate()
        }
        defaults.set(retrievedCount, forKey: "reviewCount")
    }
    
    
    func configureBarButtonItems() {
        let menuButton  = UIBarButtonItem(image: SFSymbols.menuButton, style: .done, target: self, action: #selector(menuBarButtonPressed))
        let addButton   = UIBarButtonItem(image: SFSymbols.addHabitButton, style: .plain, target: self, action: #selector(addHabitPressed))
        let quoteButton = UIBarButtonItem(image: SFSymbols.quoteButton, style: .done, target: self, action: #selector(quoteButtonPressed)) //add to constants?
        navigationItem.setLeftBarButton(menuButton, animated: true)
        
        switch habitEntities.loadHabitArray().isEmpty {
        case true: navigationItem.setRightBarButtonItems([addButton], animated: true)
        case false: navigationItem.setRightBarButtonItems([addButton, quoteButton], animated: true)
        }
    }
    
    
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.register(HabitCell.self, forCellReuseIdentifier: HabitCell.reuseID)
        tableView.delegate        = self
        tableView.dataSource      = self
        tableView.frame           = view.bounds
        tableView.backgroundColor = BackgroundColors.mainBackGround
        tableView.separatorStyle  = .none
        tableView.dragInteractionEnabled = true
        tableView.dragDelegate = self
        
        //Sizing fix for older iphone models. evaluate how to improve upon this?
        if view.frame.size.height < 800 {
            tableView.rowHeight = tableView.frame.height / 4.5
        } else {
            tableView.rowHeight = tableView.frame.height / 6
        }
    }
    
    
    func configureTableViewFooter() {
        tableView.register(QuoteView.self, forHeaderFooterViewReuseIdentifier: "header")
        let tableViewFooter = TableViewFooter()
        tableViewFooter.addHabitButton.addTarget(self, action: #selector(addHabitPressed), for: .touchUpInside)
        tableView.tableFooterView = tableViewFooter
        switch habitEntities.loadHabitArray().isEmpty {
        case true: tableViewFooter.isHidden = true
        case false: tableViewFooter.isHidden = false
        }
    }
    
    // TODO: - change this do a completion closure
    func timerForCloudKit() {
        var count = 0
        //This ensures data loads correctly when cloudkit loads.
        Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { timer in
            let habits = self.habitEntities.loadHabitArray()
            self.tableView.reloadData()
            print("Repeated")
            count += 1
            if habits.isEmpty == false  {
                timer.invalidate()
            }
            if count == 10 {
                timer.invalidate()
            }
            
        }
    }
    
    func pushSettings(row: Int) { // TODO: complete mess. redo this
                                  //change to named funcs so I know what im calling?
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
    
    func configureMenuView() { // TODO: move to class or view
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
    
    func configureEmptyState() {
        emptyStateView.addHabitButton.addTarget(self, action: #selector(addHabitPressed), for: .touchUpInside)
        emptyStateView.howToUseButton.addTarget(self, action: #selector(helpButtonPressed), for: .touchUpInside)
    }
    
   
    //MARK: - @objc Funcs

    @objc func helpButtonPressed() {
        let helpVC = HowToUseVC()
        show(helpVC, sender: self)
    }
    

    @objc func addHabitPressed() {
        let newHabitVC = NewHabitVC()
        show(newHabitVC, sender: self)
    }
    
    ///Toggles the tableViewHeader to appear which shows quotes.
    @objc func quoteButtonPressed() {
        generator.impactOccurred()
        quoteButtonTapped.toggle()
        guard quotesArray.isEmpty == false else { return }
        tableView.reloadData()
    }
    
    
    /// When button is pressed, the selected button's date is saved the the corresponding habits core data dates list. If date is already in there, it is instead removed from the list.
    ///
    /// - Parameter UIButton: This func is attached to all 7 date buttons on tableView Cells.
    @objc func dateButtonPressed(_ sender: UIButton) {
        generator.impactOccurred()
        
        let selectedDate = DateModel.weeklyDateArray()[sender.tag]
        
        let buttonPosition: CGPoint = sender.convert(CGPoint.zero, to: self.tableView)
        guard let indexPath = self.tableView.indexPathForRow(at: buttonPosition) else { return }
        
        let habit = habitEntities.loadHabitArray()[indexPath.row]
        
        // TODO: - dont use image to confirm something.
        if sender.image(for: .normal) == SFSymbols.checkMark {
            habitEntities.removeHabitDate(habit: habit, date: selectedDate)
        } else {
            habitEntities.addHabitDate(habit: habit, date: selectedDate)
        }
        tableView.reloadRows(at: [indexPath], with: .none)
    }
    
    ///Loads new quote on tableview header.
    @objc func quoteNextButtonPressed(_ sender: UIButton) {
        sender.bounceAnimation()
        generator.impactOccurred()
        tableView.reloadData()
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
    
   
}



//MARK: - QuotesManagerDelegate

extension HabitHomeVC: QuotesManagerDelegate {
    
    func updateQuotes(_ quotes: [Quote]) {
        DispatchQueue.main.async {
            self.quotesArray = quotes
            self.tableView.reloadData()
        }
    }
}


//MARK: - TableView - UITableViewDelegate, UITableViewDataSource

extension HabitHomeVC: UITableViewDelegate, UITableViewDataSource, UITableViewDragDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        quoteButtonTapped ? 100 : CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as! QuoteView
        headerView.quoteButton.addTarget(self, action: #selector(quoteNextButtonPressed), for: .touchUpInside)
        
        let randomIndex = (0...quotesArray.count - 1).randomElement() ?? 0
        if quotesArray.isEmpty != true {
            headerView.quoteLabel.text = quotesArray[randomIndex].text
            headerView.nameLabel.text = quotesArray[randomIndex].author
        }
        return headerView
    }
    
    
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        
        generator.impactOccurred()
        let array = habitEntities.loadHabitArray()
        
        let dragItem = UIDragItem(itemProvider: NSItemProvider())
        
        dragItem.localObject = array[indexPath.row]
        return [dragItem]
    }
    
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        habitEntities.updateHabitOrder(sourceIndex: sourceIndexPath.row, destinationIndex: destinationIndexPath.row)
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return habitEntities.loadHabitArray().count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HabitCell.reuseID) as!HabitCell
        
        let habit = habitEntities.loadHabitArray()[indexPath.row]
        
        if habitEntities.loadHabitArray().isEmpty == false {
            emptyStateView.removeFromSuperview()
            title = Labels.HabitVCTitle
        }
        
        let dateArray = habitEntities.loadHabitDates(habit: habit)
        
        // TODO: move all view type data to the cell
        
        for (index,button) in cell.dayButtons.enumerated() {
            button.layer.borderColor = UIColor.white.cgColor
            button.setTitle("\(DateModel.weeklyDayArray()[index])", for: .normal)
            button.setImage(nil, for: .normal)
            
            button.addTarget(self, action: #selector(dateButtonPressed), for: .touchUpInside)
            button.tag = index
            
            let selectedDate = DateFuncs.startOfDay(date: cell.dateArray[index])
            
            
            
            if dateArray.contains(selectedDate) {
                button.layer.borderColor = UIColor.clear.cgColor
                button.setTitle(nil, for: .normal)
                button.setImage(SFSymbols.checkMark, for: .normal)
            } else {
                button.backgroundColor = .clear
                button.layer.borderColor = UIColor.white.cgColor
            }
        }
        
        var completedDays = 0
        for button in cell.dayButtons {
            if button.image(for: .normal) == SFSymbols.checkMark {
                completedDays += 1
            }
        }
        cell.habitCompletedDays = completedDays
        cell.set(habit: habit)
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = HabitDetailsVC()
        
        let currentCell = tableView.cellForRow(at: indexPath)! as! HabitCell
        generator.impactOccurred()
        // TODO: -  move this to an animations file. user a timer combined with animation to show vc.
        UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: .curveEaseIn) {
            currentCell.transform = CGAffineTransform(scaleX: 0.92, y: 0.92)
        } completion: { (_) in
            UIView.animate(withDuration: 0.05, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 2, options: .curveEaseIn) {
                currentCell.transform = CGAffineTransform(scaleX: 1, y: 1)
            } completion: { [weak self] _ in
                
                vc.habitIndex = indexPath.row
                
                self?.show(vc, sender: self)
            }
        }
    }
}

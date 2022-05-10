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
    
    let tableView               = UITableView()
    let sideMenuVC              = SideMenuVC()
    let generator               = UIImpactFeedbackGenerator(style: .medium)
    let emptyStateView          = EmptyStateView()
    let coreData                = CoreDataMethods.shared
    var quotesArray: [Quote]    = []
    var quoteButtonTapped: Bool = false
    var menuButtonPressed       = false
    
    //MARK: - Class Funcs
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
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
        configureQuotesManager()
        AppStoreManagerReview.reviewCount()
    }
    
    //MARK: - Functions
    
    private func configureViewController() {
        navigationController?.navigationBar.titleTextAttributes = [.font: UIFont.systemFont(ofSize: 25)]
        view.backgroundColor = BackgroundColors.mainBackGround
        generator.prepare()
    }
    
    private func configureBarButtonItems() {
        let menuButton  = UIBarButtonItem(image: SFSymbols.menuButton, style: .done, target: self, action: #selector(menuBarButtonPressed))
        let addButton   = UIBarButtonItem(image: SFSymbols.addHabitButton, style: .plain, target: self, action: #selector(addHabitPressed))
        let quoteButton = UIBarButtonItem(image: SFSymbols.quoteButton, style: .done, target: self, action: #selector(quoteButtonPressed))
        navigationItem.setLeftBarButton(menuButton, animated: true)
        
        //This prevents quote button being active when empty state is up as tableview is not active then, thus the quote header view wont function properly.
        switch coreData.loadHabitArray().isEmpty {
        case true: navigationItem.setRightBarButtonItems([addButton], animated: true)
        case false: navigationItem.setRightBarButtonItems([addButton, quoteButton], animated: true)
        }
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        TableViewFuncs().setupTableView(for: .HabitHomeVC, using: tableView)
        tableView.delegate               = self
        tableView.dataSource             = self
        tableView.dragDelegate           = self
        tableView.frame                  = view.bounds
    }
    
    ///Populates an array with quotes for tableview header.
    private func configureQuotesManager() {
        var quotesManager        = QuotesManager()
        quotesManager.delegate = self
        DispatchQueue.global(qos: .background).async {
            quotesManager.parse()
        }
    }
    
    
    private func showEmptyStateView() {
        switch coreData.loadHabitArray().isEmpty {
        case true:  view.addSubview(emptyStateView)
                    emptyStateView.frame = tableView.frame
        case false: emptyStateView.removeFromSuperview()
                    title = Labels.HabitVCTitle
        }
    }
    
    ///Registers TableViewFooter & hides it if empty state view is active.
    func configureTableViewFooter() {
        tableView.register(QuoteView.self, forHeaderFooterViewReuseIdentifier: "header")
        let tableViewFooter = TableViewFooter()
        tableViewFooter.addHabitButton.addTarget(self, action: #selector(addHabitPressed), for: .touchUpInside)
        tableView.tableFooterView = tableViewFooter
        switch coreData.loadHabitArray().isEmpty {
        case true: tableViewFooter.isHidden = true
        case false: tableViewFooter.isHidden = false
        }
    }
    
    ///Protocol func from side menu buttons to load actions from button presses in UINavigation Controller.
    func sideMenuItemPressed(row: Int) {
        let settingsFuncs = SettingsFuncs()
        settingsFuncs.activateSettings(row: row, vc: self)
    }
    
    
    func configureMenuView() {
        let menuBarPadding: CGFloat = self.view.frame.width * 0.50
        lazy var menuView: UIView = {
            let view = UIView()
            view.addSubview(sideMenuVC.view)
            sideMenuVC.view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                sideMenuVC.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                sideMenuVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                sideMenuVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                sideMenuVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
            return view
        }()
        
        menuView.pinMenuTo(view, with: menuBarPadding)
        tableView.edgeTo(view, padding: 0)
        sideMenuVC.delegate = self
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
    /// - Parameter UIButton: This func is attached to all 7 date buttons on tableView Cells.
    @objc func dateButtonPressed(_ sender: UIButton) {
        generator.impactOccurred()
        let selectedDate            = DateModel.weeklyDateArray()[sender.tag]
        let buttonPosition: CGPoint = sender.convert(CGPoint.zero, to: self.tableView)
        guard let indexPath         = self.tableView.indexPathForRow(at: buttonPosition) else { return }
        coreData.updateDates(selectedDate: selectedDate, index: indexPath.row)
        tableView.reloadRows(at: [indexPath], with: .none)
    }
    
    ///Loads new quote on tableview header.
    @objc func quoteNextButtonPressed(_ sender: UIButton) {
        sender.bounceAnimation()
        generator.impactOccurred()
        tableView.reloadData()
    }
    
    ///Animates the SideMenuVC to either slide into view or slide away.
    @objc func menuBarButtonPressed() {
        let menuBarPadding: CGFloat = self.view.frame.width * 0.50
        generator.impactOccurred()
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveLinear) {
            self.menuButtonPressed.toggle()
            self.emptyStateView.frame.origin.x = self.menuButtonPressed ? 0 : self.emptyStateView.frame.width - menuBarPadding
            self.tableView.frame.origin.x      = self.menuButtonPressed ? 0 : self.tableView.frame.width - menuBarPadding
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
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //Sizing fix for older iphone models.
        if view.frame.size.height < 800 {
            return tableView.frame.size.height / 4.5
        } else {
            return tableView.frame.size.height / 6
        }
    }
    
    ///Initialises the current state of the tableView to set it up for changing the order of habits.
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        generator.impactOccurred()
        let array            = coreData.loadHabitArray()
        let dragItem         = UIDragItem(itemProvider: NSItemProvider())
        dragItem.localObject = array[indexPath.row]
        return [dragItem]
    }
    
    ///Updates habit order and saves to core data when user moves habit.
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        coreData.updateHabitOrder(sourceIndex: sourceIndexPath.row, destinationIndex: destinationIndexPath.row)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coreData.loadHabitArray().count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: HabitCell.reuseID) as!HabitCell
        let habit = coreData.loadHabitArray()[indexPath.row]
    
        for (index,button) in cell.dayButtons.enumerated() {
            button.addTarget(self, action: #selector(dateButtonPressed), for: .touchUpInside)
            button.tag = index
        }
        cell.set(habit: habit)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc          = HabitDetailsVC()
        let currentCell = tableView.cellForRow(at: indexPath)! as! HabitCell
        generator.impactOccurred()
        currentCell.bounce()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.20) {
            vc.set(index: indexPath.row)
            self.show(vc, sender: self)
        }
    }
    
}

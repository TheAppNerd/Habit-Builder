//
//  NewHabitVC.swift
//  Habits
//
//  Created by Alexander Thompson on 13/8/21.
//

import UIKit
import CoreData

class NewHabitVC: UITableViewController  {
    
    //MARK: - Properties
    
    let coreData               = CoreDataMethods.shared
    let generator              = UIImpactFeedbackGenerator(style: .medium)
    var habitEntity: HabitEnt? = nil
    var nameTextField          = UITextField()
    var name                   = String()
    var frequency              = 1
    var colorIndex             = Int()
    var iconString: String     = ""
    var alarmItem              = AlarmItem(alarmActivated: false, title: "", days: "", hour: 0, minute: 0)
    
    //MARK: - Class Funcs
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        configure()
        configureBarButtons()
        dismissKeyboard()
    }
    
    
    //MARK: - Functions
    
    func loadData() {
        if habitEntity != nil {
            title = "Edit Habit"
            guard let habit          = habitEntity else { return }
            name                     = habit.name ?? ""
            frequency                = Int(habit.frequency)
            colorIndex               = Int(habit.gradient)
            iconString               = habit.icon ?? ""
            
            alarmItem.title          = habit.name ?? ""
            alarmItem.days           = habit.notificationDays ?? ""
            alarmItem.alarmActivated = habit.notificationBool
            alarmItem.hour           = Int(habit.notificationHour)
            alarmItem.minute         = Int(habit.notificationMinute)
        } else {
            title = "Create Habit"
        }
    }

    
    private func configure() {
        //Fixes a bug with section header padding size.
        if #available(iOS 15.0, *) {
            UITableView.appearance().sectionHeaderTopPadding = CGFloat(0)
        }
        TableViewFuncs().setupTableView(for: .NewHabitVC, using: tableView)
        generator.prepare()
    }
    
    
    private func configureBarButtons() {
        let deleteButton = UIBarButtonItem(image: SFSymbols.trash, style: .done, target: self, action: #selector(deleteHabit))
        switch habitEntity != nil {
        case true: deleteButton.image  = SFSymbols.trash
        case false: deleteButton.image = SFSymbols.trashSlash
        }
        navigationItem.rightBarButtonItem = deleteButton
    }
    
    ///Injects the coreData entity here when page is entered from HabitDetailsVC.
    func set(index: Int) {
        let habit   = coreData.loadHabitArray()[index]
        habitEntity = habit
    }
    
    
    func dismissKeyboard() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    
    ///Prompts alert to delete habit. If user accepts, all userNotifications are cleared, the core data habit is cleared and the user is pushed back to HabitHomeVC.
    @objc func deleteHabit() {
        let deleteAlert = UIAlertController(title: Labels.deleteAlertTitle, message: Labels.deleteAlartMessage, preferredStyle: .alert)
        deleteAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel , handler: { UIAlertAction in }))
        deleteAlert.addAction(UIAlertAction(title: "Delete", style: .default, handler: { UIAlertAction in
            UserNotifications.removeNotifications(title: self.habitEntity?.name ?? self.name)
            if let habit = self.habitEntity {
                self.coreData.deleteHabit(habit)
            }
            let habitVC = HabitHomeVC()
            self.show(habitVC, sender: self)
        }))
        if habitEntity != nil {
            generator.impactOccurred()
            present(deleteAlert, animated: true, completion: nil)
        }
    }
    
    ///Determines whether a new habit is being created or existing habit is being updated. Saves all the relevent data
    func createHabit() {
        let count = coreData.loadHabitArray().count
        switch habitEntity == nil {
        case true:
            coreData.saveHabit(name: name, icon: iconString, frequency: Int16(frequency), index: count, gradient: Int16(colorIndex), dateCreated: Date(), notificationBool: alarmItem.alarmActivated, alarmItem: alarmItem)
        case false: guard let habit = habitEntity else { return }
            habit.name              = name
            habit.frequency         = Int16(frequency)
            habit.icon              = iconString
            habit.gradient          = Int16(colorIndex)
            habit.notificationBool  = alarmItem.alarmActivated
            coreData.saveAlarmData(habit: habit, alarmItem: alarmItem)
            coreData.updateHabit()
        }
    }
    
    ///When save button is pressed this deactivates all existing userNotifications, creates new habit or updates existing habit in core data, sets up any new userNotifications and pushes user to HabitHomeVC.
    @objc func saveButtonPressed(_ sender: GradientButton) {
        sender.bounceAnimation()
        generator.impactOccurred()
        
        guard name != "" else {
            nameTextField.layer.borderWidth = 2
            return
        }
        
        UserNotifications.removeNotifications(title: habitEntity?.name ?? name)
        nameTextField.layer.borderWidth = 0
        createHabit()
        setupNotifications()
        let habitVC = HabitHomeVC()
        show(habitVC, sender: self)
    }
    
    
    func setupNotifications() {
        alarmItem.title = name // This is here to ensure alarm sets properly when habit first created
        if alarmItem.alarmActivated == true {
            UserNotifications.scheduleNotifications(alarmItem: alarmItem)
        }
    }
    
    ///Takes time from datepicker, converts it to two seperate intergers representing hours & minutes to use to set alarms with userNotifications.
    @objc func datePickerTime(_ sender: DatePicker) {
        let time = DateModel().convertDatePickerTime(date: sender.date)
        alarmItem.hour = Int(time[0]) ?? 0
        alarmItem.minute = Int(time[1]) ?? 0
    }
    
    ///Determines whether or not to set userNotifications for a habit. If user selects to activate them a method runs to determine whether user has granted system access and responds accordingly.
    @objc func dateSegmentChanged(_ sender: UISegmentedControl) {
        generator.impactOccurred()
        sender.setGradientColors()
        switch sender.selectedSegmentIndex {
        case 0: alarmItem.alarmActivated = false
        case 1: alarmItem.alarmActivated = true
                UserNotifications().dateSegmentChanged(segment: sender, vc: self)
        default:
                alarmItem.alarmActivated = false
        }
    }
    
    // MARK: - TableView - UITableViewDelegate, UITableViewDataSource
    
    // TODO: - Super required here?
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 6
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "Name"
        case 1: return "How many days per week?"
        case 2: return "Colour"
        case 3: return "Icon"
        case 4: return "Remind Me"
        default:
            return ""
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0: let cell = tableView.dequeueReusableCell(withIdentifier: HabitNameCell.reuseID, for: indexPath) as! HabitNameCell
            cell.nameTextField.delegate = self
            nameTextField = cell.nameTextField
            cell.nameTextField.text = name
            return cell
            
        case 1: let cell = tableView.dequeueReusableCell(withIdentifier: HabitFrequencyCell.reuseID, for: indexPath) as! HabitFrequencyCell
            cell.delegate = self
            cell.frequencyButtonArray[frequency - 1].sendActions(for: .touchUpInside)
            return cell
            
        case 2: let cell = tableView.dequeueReusableCell(withIdentifier: HabitColorCell.reuseID, for: indexPath) as! HabitColorCell
            cell.delegate = self
            cell.buttonArray[colorIndex].sendActions(for: .touchUpInside)
            return cell
            
        case 3: let cell = tableView.dequeueReusableCell(withIdentifier: HabitIconCell.reuseID, for: indexPath) as! HabitIconCell
            cell.delegate = self
            for button in cell.buttonArray {
                if button.imageView?.image == UIImage(named: iconString) {
                    button.sendActions(for: .touchUpInside)
                }
                if iconString == "" {
                    cell.buttonArray[0].sendActions(for: .touchUpInside)
                }
            }
            return cell
            
        case 4: let cell = tableView.dequeueReusableCell(withIdentifier: HabitReminderCell.reuseID, for: indexPath) as! HabitReminderCell
            cell.delegate = self
            cell.alarmSegment.addTarget(self, action: #selector(dateSegmentChanged), for: .valueChanged)
            cell.datePicker.addTarget(self, action: #selector(datePickerTime), for: .valueChanged)
            UserNotifications().confirmRegisteredNotifications(segment: cell.alarmSegment)
            
            switch alarmItem.alarmActivated {
            case true: cell.alarmSegment.selectedSegmentIndex = 1
                cell.datePicker.date = DateFuncs.setupDatePickerDate(hour: alarmItem.hour, minute: alarmItem.minute) //Sets datepicker to previously select alarm time.
            case false: cell.alarmSegment.selectedSegmentIndex = 0
            }
            
            let boolArray = coreData.convertStringArraytoBoolArray(alarmItem: alarmItem) //Converts core data string to bool array as way to store days of week where UserNotifications active.
            for (index, bool) in boolArray.enumerated() {
                if bool == true {
                    cell.buttonArray[index].sendActions(for: .touchUpInside)
                }
            }
            return cell
            
        case 5: let cell = tableView.dequeueReusableCell(withIdentifier: HabitSaveCell.reuseID, for: indexPath) as! HabitSaveCell
            cell.saveButton.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
            return cell
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: HabitNameCell.reuseID, for: indexPath) as! HabitNameCell
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as? UITableViewHeaderFooterView
        header?.textLabel?.textColor = UIColor.label
    }
}


//MARK: - UITextFieldDelegate

extension NewHabitVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        name = textField.text ?? ""
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        name = textField.text ?? ""
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 0
    }
    
}

//MARK: - Protocol Extensions

extension NewHabitVC: passColorsData, passIconData, passDayData, passFrequencyData {
    
    func passFrequencyData(frequency: Int) {
        self.frequency = frequency
    }
    
    func passColorsData(colorIndex: Int) {
        self.colorIndex = colorIndex
    }
    
    func passIconData(iconString: String) {
        self.iconString = iconString
    }
    
    func passDayData(dayArray: String) {
        alarmItem.days = dayArray
    }
}


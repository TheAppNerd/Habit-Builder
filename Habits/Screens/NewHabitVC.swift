//
//  NewHabitVC.swift
//  Habits
//
//  Created by Alexander Thompson on 13/8/21.
//

import UIKit
import CoreData

class NewHabitVC: UITableViewController  {
    
    var habitEntity: HabitEnt?
    
    var habitIndex: Int? {
        didSet {
            habitEntity = habitEntities.loadHabitArray()[habitIndex!]
        }
    }
    
    var habitEntities = HabitEntityFuncs()
    
    //fix nameArray functionality?
   
    let generator            = UIImpactFeedbackGenerator(style: .medium)
    
    var nameArray             = [UITextField]()
    var previousName          = String() //using this prevents alarms from being messed with as name is name of title
    var name                  = String()
    var frequency             = 1
    var colors                = [CGColor]()
    var colorIndex            = Int()
    var iconString: String    = ""
    
    var alarmItem             = AlarmItem(alarmActivated: false, title: "", days: "", hour: 0, minute: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        registerCells()
        configure()
        configureBarButtons()
        dismissKeyboard()
        
        
        
        if #available(iOS 15.0, *) {
            UITableView.appearance().sectionHeaderTopPadding = CGFloat(0)
        }
    }
    
    func loadData() {
            if habitEntity != nil {
                title = "Edit Habit" //move to constants
                
            let habit       = habitEntity!
            name            = habit.name ?? ""
            previousName    = habit.name ?? ""
            frequency       = Int(habit.frequency)
            colorIndex      = Int(habit.gradient)
            colors          = GradientArray.array[colorIndex]
            iconString      = habit.icon ?? ""
            
                alarmItem.title = habit.name ?? ""
                alarmItem.days  = habit.notificationDays ?? ""
            alarmItem.alarmActivated = habit.notificationBool
            alarmItem.hour = Int(habit.notificationHour)
            alarmItem.minute = Int(habit.notificationMinute)
            } else {
                title = "Create Habit" //move to constants
            }
        print(alarmItem)
    }
    
    private func registerCells() {
        tableView.register(HabitNameCell.self, forCellReuseIdentifier: HabitNameCell.reuseID)
        tableView.register(HabitFrequencyCell.self, forCellReuseIdentifier: HabitFrequencyCell.reuseID)
        tableView.register(HabitIconCell.self, forCellReuseIdentifier: HabitIconCell.reuseID)
        tableView.register(HabitReminderCell.self, forCellReuseIdentifier: HabitReminderCell.reuseID)
        tableView.register(HabitColorCell.self, forCellReuseIdentifier: HabitColorCell.reuseID)
        tableView.register(HabitSaveCell.self, forCellReuseIdentifier: HabitSaveCell.reuseID)
    }
    
    private func configure() {
        tableView.backgroundColor = .systemBackground
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        generator.prepare()
    }
    
    private func configureBarButtons() {
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .done, target: self, action: #selector(backButtonPressed))
        let deleteButton = UIBarButtonItem(image: SFSymbols.trash, style: .done, target: self, action: #selector(deleteHabit))
        
        switch habitEntity != nil {
        case true: deleteButton.image = SFSymbols.trash
        case false: deleteButton.image = SFSymbols.trashSlash
        }
        navigationItem.leftBarButtonItem = backButton
        navigationItem.rightBarButtonItem = deleteButton
    }
    
    @objc func backButtonPressed() {
        CoreDataFuncs.saveCoreData() //stops tableview loading in random order on habitvc
        let habitVC = HabitHomeVC()
        show(habitVC, sender: self)
    }
    
    func dismissKeyboard() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func deleteHabit() { //move alerts to enum
        let deleteAlert = UIAlertController(title: Labels.deleteAlertTitle, message: Labels.deleteAlartMessage, preferredStyle: .alert)
        deleteAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel , handler: { UIAlertAction in
        }))
        deleteAlert.addAction(UIAlertAction(title: "Delete", style: .default, handler: { UIAlertAction in
            
        UserNotifications.removeNotifications(title: self.previousName)
            
            if let habit = self.habitEntity {
                self.habitEntities.deleteHabit(habit)
            }
        
        let habitVC = HabitHomeVC()
        self.show(habitVC, sender: self)
        }))
        
        if habitEntity != nil {
            generator.impactOccurred()
            present(deleteAlert, animated: true, completion: nil)
        }
    }
    
    func createHabit() {
        let count = habitEntities.loadHabitArray().count
        
        
        switch habitEntity == nil {
        case true: habitEntities.saveHabit(name: name, icon: iconString, frequency: Int16(frequency), index: count, gradient: Int16(colorIndex), dateCreated: Date(), notificationBool: alarmItem.alarmActivated, alarmItem: alarmItem)
        case false: let habit = habitEntity!
            habit.name          = name
            habit.frequency          = Int16(frequency)
            habit.icon         = iconString
            habit.gradient = Int16(colorIndex)
            habit.notificationBool = alarmItem.alarmActivated
            habitEntities.saveAlarmData(habit: habit, alarmItem: alarmItem)
            habitEntities.updateHabit()
        }
        
    }
    
    
    @objc func saveButtonPressed(_ sender: GradientButton) {
        sender.bounceAnimation()
        generator.impactOccurred()
        guard name != "" else {
            nameArray[0].layer.borderWidth = 2
            return
        }
        nameArray[0].layer.borderWidth = 0
        setupNotifications()
        createHabit()

        
        let habitVC = HabitHomeVC()
        show(habitVC, sender: self)
    }
    
    
    func setupNotifications() {
        UserNotifications.removeNotifications(title: previousName)
        if alarmItem.alarmActivated == true {
            UserNotifications.scheduleNotifications(alarmItem: alarmItem)
        }
    }
    
    
    @objc func datePickerTime(_ sender: DatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        let dateAsString = formatter.string(from: sender.date)
        
        let date = formatter.date(from: dateAsString)
        formatter.dateFormat = "HH:mm"
        
        let twentyFourHourDate = formatter.string(from: date!)
        let time = twentyFourHourDate.components(separatedBy: ":")
        alarmItem.hour = Int(time[0])!
        alarmItem.minute = Int(time[1])!
    }
    
    
    @objc func dateSegmentChanged(_ sender: UISegmentedControl) {
        generator.impactOccurred()
        
        sender.setGradientColors()
        
        
        switch sender.selectedSegmentIndex {
        case 0: alarmItem.alarmActivated = false
        case 1: alarmItem.alarmActivated = true
           
            let current = UNUserNotificationCenter.current()
            
            current.getNotificationSettings { (settings) in
                if settings.authorizationStatus == .authorized {
                    DispatchQueue.main.async {
                        sender.selectedSegmentIndex = 1
                    }
                }
                if settings.authorizationStatus == .denied {
                    
                    let deniedAlert = UIAlertController(title: Labels.notificationDeniedTitle, message: Labels.notificationDeniedMessage, preferredStyle: .alert)
                    deniedAlert.addAction(UIAlertAction(title: "App Settings", style: .default, handler: { (alert) in
                        if let appSettings = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(appSettings) {
                            UIApplication.shared.open(appSettings)
                        }
                    }))
                    deniedAlert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                    DispatchQueue.main.async {
                        self.present(deniedAlert, animated: true) {
                            sender.selectedSegmentIndex = 0
                        }
                    }
                }
            }
        default:
            alarmItem.alarmActivated = false
        }
    }
    
    // MARK: - Table view data source
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
            nameArray.append(cell.nameTextField) // is this still needed?
            if habitEntity != nil {
                cell.nameTextField.text = name
            }
            return cell
            
        case 1: let cell = tableView.dequeueReusableCell(withIdentifier: HabitFrequencyCell.reuseID, for: indexPath) as! HabitFrequencyCell
            cell.delegate = self
            cell.frequencyButtonArray[frequency - 1].sendActions(for: .touchUpInside)
            
            return cell
            
        case 2: let cell = tableView.dequeueReusableCell(withIdentifier: HabitColorCell.reuseID, for: indexPath) as! HabitColorCell
            cell.delegate = self
            for (index, button) in cell.buttonArray.enumerated() {
                if index == colorIndex {
                    button.sendActions(for: .touchUpInside)
                }
            }
            return cell
            
        case 3: let cell = tableView.dequeueReusableCell(withIdentifier: HabitIconCell.reuseID, for: indexPath) as! HabitIconCell
            cell.delegate = self
            cell.colors = colors
            
            
            for (index, button) in cell.buttonArray.enumerated() { //remove index?
                if button.imageView!.image == UIImage(named: iconString) {
                    button.sendActions(for: .touchUpInside)
                }
                if iconString == "" {
                    cell.buttonArray[0].sendActions(for: .touchUpInside)
                }
            }
            return cell
            
        case 4: let cell = tableView.dequeueReusableCell(withIdentifier: HabitReminderCell.reuseID, for: indexPath) as! HabitReminderCell
            cell.colors = colors
            cell.delegate = self
            
            //safety check here if alarms allowed. if no set index to 0
            
            let userNotifications = UserNotifications()
            userNotifications.confirmRegisteredNotifications(segment: cell.dateSegment)
        
            
            switch alarmItem.alarmActivated {
            case true: cell.dateSegment.selectedSegmentIndex = 1
                cell.datePicker.date = DateFuncs.setupDatePickerDate(hour: alarmItem.hour, minute: alarmItem.minute)
            case false: cell.dateSegment.selectedSegmentIndex = 0
            }
            
            cell.dateSegment.addTarget(self, action: #selector(dateSegmentChanged), for: .valueChanged)
            cell.datePicker.addTarget(self, action: #selector(datePickerTime), for: .valueChanged)
            print("testitem\(alarmItem.days)")
            var boolArray = habitEntities.convertStringArraytoBoolArray(alarmItem: alarmItem)
            
            print("bool\(boolArray)")
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
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.label
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
    
    func passColorsData(colors: [CGColor], colorIndex: Int) {
        self.colors = colors
        self.colorIndex = colorIndex
    }
    
    
    func passIconData(iconString: String) {
        self.iconString = iconString
    }
    
    
    func passDayData(dayArray: String) {
        alarmItem.days = dayArray
    }
}


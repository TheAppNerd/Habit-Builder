//
//  NewHabitVC.swift
//  Habits
//
//  Created by Alexander Thompson on 13/8/21.
//

import UIKit
import CoreData

class NewHabitVC: UITableViewController  {
    
//    var habitArray            = [HabitCoreData]()
    var habitCoreData: HabitCoreData?
    let context               = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let generator            = UIImpactFeedbackGenerator(style: .medium)
    
//    var cellTag               = Int()
    var nameArray             = [UITextField]()
    var previousName          = String() //using this prevents alarms from being messed with as name is name of title
    var name                  = String()
    var frequency             = 1
    var colors                = [CGColor]()
    var colorIndex            = Int()
    var iconString: String    = ""
    var dayArray: [Bool]      = [false, false, false, false, false, false, false]
    var alarmsActivated: Bool = false
    var hour                  = Int()
    var minute                = Int()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //loadCoreData()
        loadData()
        registerCells()
        configure()
        configureBarButtons()
        dismissKeyboard()
    }
    
    func loadData() {
            if habitCoreData != nil {
            let habit       = habitCoreData!
            name            = habit.habitName ?? ""
            previousName    = habit.habitName ?? ""
            frequency       = Int(habit.frequency)
            colorIndex      = Int(habit.habitGradientIndex)
            colors          = GradientArray.array[colorIndex]
            iconString      = habit.iconString ?? ""
            dayArray        = habit.alarmDates ?? []
            alarmsActivated = habit.alarmBool
        }
    }
    
    // arrange funcs in same order they are called in viewdidload
    
    private func registerCells() {
        tableView.register(HabitNameCell.self, forCellReuseIdentifier: HabitNameCell.reuseID)
        tableView.register(HabitFrequencyCell.self, forCellReuseIdentifier: HabitFrequencyCell.reuseID)
        tableView.register(IconCell.self, forCellReuseIdentifier: IconCell.reuseID)
        tableView.register(ReminderCell.self, forCellReuseIdentifier: ReminderCell.reuseID)
        tableView.register(ColorCell.self, forCellReuseIdentifier: ColorCell.reuseID)
        tableView.register(SaveCell.self, forCellReuseIdentifier: SaveCell.reuseID)
    }
    
    private func configure() {
        tableView.backgroundColor = .systemBackground
        title = Labels.AddHabitVCTitle
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        generator.prepare()
    }
    
    private func configureBarButtons() {
        //fix back button
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .done, target: self, action: #selector(backButtonPressed))
        
        let deleteButton = UIBarButtonItem(image: SFSymbols.trash, style: .done, target: self, action: #selector(deleteHabit))
        switch habitCoreData != nil {
        case true: deleteButton.image = SFSymbols.trash
        case false: deleteButton.image = SFSymbols.trashSlash
        }
        navigationItem.leftBarButtonItem = backButton
        navigationItem.rightBarButtonItem = deleteButton
    }
    
    @objc func backButtonPressed() {
        CoreDataFuncs.saveCoreData() //stops tableview loading in random order on habitvc
        let habitVC = HabitVC()
        show(habitVC, sender: self)
    }
    
    func dismissKeyboard() { //move to seperate file
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func deleteHabit() {
        let deleteAlert = UIAlertController(title: Labels.deleteAlertTitle, message: Labels.deleteAlartMessage, preferredStyle: .alert)
        deleteAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel , handler: { UIAlertAction in
        }))
        deleteAlert.addAction(UIAlertAction(title: "Delete", style: .default, handler: { UIAlertAction in
            
        UserNotifications.removeNotifications(title: self.previousName)
            
            let habit = self.habitCoreData
            self.context.delete(habit!)
            for (index, habits) in HabitVC.habitArray.enumerated() {
                if habits == habit {
                    let habitIndex = index
                    HabitVC.habitArray.remove(at: habitIndex)
                }
            }
            
        CoreDataFuncs.saveCoreData()
        
        let habitVC = HabitVC()
        self.show(habitVC, sender: self)
        }))
        
        if habitCoreData != nil {
            generator.impactOccurred()
            present(deleteAlert, animated: true, completion: nil)
        }
    }
    
    func createCoreDataHabit() { //create a habit core data struct to contain all the information
        if habitCoreData == nil {
            let newHabit                = HabitCoreData(context: context)
            newHabit.habitName          = name
            newHabit.frequency          = Int16(frequency)
            newHabit.iconString         = iconString
            newHabit.habitGradientIndex = Int16(colorIndex)
            newHabit.alarmDates         = dayArray
            newHabit.habitCreated       = true
            newHabit.habitDates         = []
            newHabit.alarmBool          = alarmsActivated
            newHabit.dateHabitCreated   = Date()
            HabitVC.habitArray.append(newHabit)
        } else if habitCoreData != nil {
            let oldHabit                = habitCoreData!
            oldHabit.habitName          = name
            oldHabit.frequency          = Int16(frequency)
            oldHabit.iconString         = iconString
            oldHabit.habitGradientIndex = Int16(colorIndex)
            oldHabit.alarmDates         = dayArray
            oldHabit.alarmBool          = alarmsActivated
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
        createCoreDataHabit()
        CoreDataFuncs.saveCoreData()
        
        let habitVC = HabitVC()
        show(habitVC, sender: self)
    }
    
    @objc func positiveButtonPressed(_ sender: GradientButton) {
        sender.bounceAnimation()
        generator.impactOccurred()
        if frequency < 7 {
            frequency += 1
        }
        UIView.performWithoutAnimation {
            self.tableView.reloadSections([1], with: .none)
            
        }
    }
    
    @objc func negativeButtonPressed(_ sender: GradientButton) {
        sender.bounceAnimation()
        generator.impactOccurred()
        if frequency > 1 {
            frequency -= 1
        }
        UIView.performWithoutAnimation {
            self.tableView.reloadSections([1], with: .none)
        }
    }
    
//    func loadCoreData(with request: NSFetchRequest<HabitCoreData> = HabitCoreData.fetchRequest()) {
//
//        do {
//            habitArray = try context.fetch(request)
//        } catch {
//            print("error loading context: \(error)")
//        }
//    }
    
    func setupNotifications() {
        UserNotifications.removeNotifications(title: previousName)
        if alarmsActivated == true {
            for (index, bool) in dayArray.enumerated() {
                if bool == true {
                    UserNotifications.scheduleNotification(title: name, day: index, hour: hour, minute: minute)
                }
            }
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
        hour = Int(time[0])!
        minute = Int(time[1])!
    }
    
    
    @objc func dateSegmentChanged(_ sender: UISegmentedControl) {
        generator.impactOccurred()
        switch sender.selectedSegmentIndex {
        case 0: alarmsActivated = false
        case 1: alarmsActivated = true
            let current = UNUserNotificationCenter.current()
            current.getNotificationSettings { (settings) in
                if settings.authorizationStatus == .denied {
                    let deniedAlert = UIAlertController(title: Labels.notificationDeniedTitle, message: Labels.notificationDeniedMessage, preferredStyle: .alert)
                    deniedAlert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                    DispatchQueue.main.async {
                        self.present(deniedAlert, animated: true) {
                            sender.selectedSegmentIndex = 0
                        }
                    }
                }
            }
        default:
            alarmsActivated = false
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
        case 1: return "Frequency"
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
            if habitCoreData != nil {
                cell.nameTextField.text = name
            }
            return cell
            
        case 1: let cell = tableView.dequeueReusableCell(withIdentifier: HabitFrequencyCell.reuseID, for: indexPath) as! HabitFrequencyCell
            cell.frequencyLabel.text = "\(frequency)"
            cell.negativeButton.addTarget(self, action: #selector(negativeButtonPressed), for: .touchUpInside)
            cell.positiveButton.addTarget(self, action: #selector(positiveButtonPressed), for: .touchUpInside)
            return cell
            
        case 2: let cell = tableView.dequeueReusableCell(withIdentifier: ColorCell.reuseID, for: indexPath) as! ColorCell
            cell.delegate = self
            for (index, button) in cell.buttonArray.enumerated() {
                if index == colorIndex {
                    button.sendActions(for: .touchUpInside)
                }
            }
            return cell
            
        case 3: let cell = tableView.dequeueReusableCell(withIdentifier: IconCell.reuseID, for: indexPath) as! IconCell
            cell.delegate = self
            cell.colors = colors
            for (index, button) in cell.buttonArray.enumerated() {
                if button.imageView!.image == UIImage(named: iconString) {
                    button.sendActions(for: .touchUpInside)
                }
                if iconString == "" {
                    cell.buttonArray[0].sendActions(for: .touchUpInside)
                }
            }
            return cell
            
        case 4: let cell = tableView.dequeueReusableCell(withIdentifier: ReminderCell.reuseID, for: indexPath) as! ReminderCell
            cell.colors = colors
            cell.delegate = self
            switch alarmsActivated {
            case true: cell.dateSegment.selectedSegmentIndex = 1
            case false: cell.dateSegment.selectedSegmentIndex = 0
            }
            cell.dateSegment.addTarget(self, action: #selector(dateSegmentChanged), for: .valueChanged)
            cell.datePicker.addTarget(self, action: #selector(datePickerTime), for: .valueChanged)
            for (index, bool) in dayArray.enumerated() {
                if bool == true {
                    cell.buttonArray[index].sendActions(for: .touchUpInside)
                }
            }
            return cell
            
        case 5: let cell = tableView.dequeueReusableCell(withIdentifier: SaveCell.reuseID, for: indexPath) as! SaveCell
            cell.saveButton.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
            return cell
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: HabitNameCell.reuseID, for: indexPath) as! HabitNameCell
            return cell
        }
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
        print("did end editing")
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 0
    }
}

//MARK: - Protocol Extension

//rename protocols to resemble cell names
extension NewHabitVC: reloadTableViewDelegate, passIconData, passDayData {
    
    func passDayData(dayArray: [Bool]) {
        self.dayArray = dayArray
    }
    
    func reloadTableView(colors: [CGColor], colorIndex: Int) {
        self.colors = colors
        self.colorIndex = colorIndex
    }
    
    
    func passIconData(iconString: String) {
        self.iconString = iconString
    }
}


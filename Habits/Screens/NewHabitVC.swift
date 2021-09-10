//
//  NewHabitVC.swift
//  Habits
//
//  Created by Alexander Thompson on 13/8/21.
//

import UIKit
import CoreData

class NewHabitVC: UITableViewController  {
    
    var habitArray = [HabitCoreData]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var cellTag = Int()
    var nameArray = [UITextField]()
    var previousName = String() //using this prevents alarms from being messed with as name is name of title
    var name = String()
    var frequency = 1
    var colors = [CGColor]()
    var colorIndex = Int()
    var iconString: String = ""
    var dayArray: [Bool] = [false, false, false, false, false, false, false]
    var alarmsActivated: Bool = false
    var hour = Int()
    var minute = Int()
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCoreData()
        loadData()
        registerCells()
        configure()
        configureBarButtons()
       dismissKeyboard()
     print("icon \(iconString)")
    print(dayArray)
        
    }

    
    func loadData() {
        if cellTag < habitArray.count {
            let habit = habitArray[cellTag]
            name = habit.habitName ?? ""
            previousName = habit.habitName ?? ""
            frequency = Int(habit.frequency)
            colorIndex = Int(habit.habitGradientIndex)
            colors = GradientArray.array[colorIndex]
            iconString = habit.iconString ?? ""
            dayArray = habit.alarmDates ?? []
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
        tableView.allowsSelection = false
        title = "Add Habit"
        tableView.separatorStyle = .none
    }
    
    
    
    private func configureBarButtons() {
//        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissVC))
        
        let deleteButton = UIBarButtonItem(image: UIImage(systemName: "trash.fill"), style: .done, target: self, action: #selector(deleteHabit))
        //navigationItem.leftBarButtonItem = cancelButton
         navigationItem.rightBarButtonItem = deleteButton
     }
    
    func dismissKeyboard() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    
    
//    @objc func dismissVC() {
//        let destVC = UINavigationController(rootViewController: HabitVC())
//        destVC.modalPresentationStyle = .fullScreen
//        present(destVC, animated: true)
//    }
    
    
    @objc func deleteHabit() {
        let deleteAlert = UIAlertController(title: "Delete Habit?", message: "Are you sure you want to delete this? It cannot be recovered.", preferredStyle: .alert)
        deleteAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel , handler: { UIAlertAction in
        
        }))
        deleteAlert.addAction(UIAlertAction(title: "Delete", style: .default, handler: { UIAlertAction in
           //where do i need to delete. core data here.
            let destVC = UINavigationController(rootViewController: HabitVC())
            destVC.modalPresentationStyle = .fullScreen
            UserNotifications.removeNotifications(title: self.previousName)
            let habit = self.habitArray[self.cellTag]
            self.context.delete(habit)
            self.habitArray.remove(at: self.cellTag)
            self.saveCoreData()
            
            self.present(destVC, animated: true)
            
        }))
        if cellTag < habitArray.count {
        present(deleteAlert, animated: true, completion: nil)
        }
    }
    
    func createCoreDataHabit() {
        if cellTag >= habitArray.count {
        let newHabit = HabitCoreData(context: context)
        newHabit.habitName = name
        newHabit.frequency = Int16(frequency)
        newHabit.iconString = iconString
        newHabit.habitGradientIndex = Int16(colorIndex)
        newHabit.alarmDates = dayArray
        newHabit.habitCreated = true
        newHabit.alarmBool = alarmsActivated
        habitArray.append(newHabit)
        } else if cellTag < habitArray.count {
             let oldHabit = habitArray[cellTag]
           oldHabit.habitName = name
           oldHabit.frequency = Int16(frequency)
           oldHabit.iconString = iconString
           oldHabit.habitGradientIndex = Int16(colorIndex)
            oldHabit.alarmDates = dayArray
            oldHabit.alarmBool = alarmsActivated
        }
    }
    
    func presentDeniedAlert() {
       
        let deniedAlert = UIAlertController(title: "Notifications Denied", message: "If you wish to allow notifications please activate them in your phone settings", preferredStyle: .alert)
        deniedAlert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(deniedAlert, animated: true)
    }
    
    @objc func saveButtonPressed(_ sender: GradientButton) {
        sender.bounceAnimation()
        guard name != "" else {
            nameArray[0].layer.borderWidth = 2
            return
        }
    
        setupNotifications()
    
        nameArray[0].layer.borderWidth = 0
        createCoreDataHabit()
        saveCoreData()
        let destVC = UINavigationController(rootViewController: HabitVC())
                destVC.modalPresentationStyle = .fullScreen
                present(destVC, animated: true)
        
    }
    
    @objc func positiveButtonPressed(_ sender: GradientButton) {
        sender.bounceAnimation()
        if frequency < 7 {
            frequency += 1
        }
        UIView.performWithoutAnimation {
            self.tableView.reloadSections([1], with: .none)
          
        }
    }
    
    @objc func negativeButtonPressed(_ sender: GradientButton) {
        sender.bounceAnimation()
        if frequency > 1 {
            frequency -= 1
        }
        UIView.performWithoutAnimation {
            self.tableView.reloadSections([1], with: .none)
        
        }
    }
    
    func loadCoreData(with request: NSFetchRequest<HabitCoreData> = HabitCoreData.fetchRequest()) {
        
        do {
            habitArray = try context.fetch(request)
        } catch {
            print("error loading context: \(error)")
        }
    }
    
    func saveCoreData() {
        do {
            try context.save()
        } catch {
            print("error saving context: \(error)")
        }
    }
    
    func setupNotifications() {
        UserNotifications.removeNotifications(title: previousName)
    
        if alarmsActivated == true {
        for (index, bool) in dayArray.enumerated() {
            if bool == true {
                UserNotifications.scheduleNotification(title: name, day: index, hour: hour, minute: minute)
                print("true")
                
            }
        }
        }
        print(previousName)
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
    
    //change segment so non selected tint is secondary label and selected tint is white 
    @objc func dateSegmentChanged(_ sender: UISegmentedControl) {
        //let userNotifications = UserNotifications()
        switch sender.selectedSegmentIndex {
        case 0: alarmsActivated = false
        case 1: alarmsActivated = true
            //userNotifications.confirmRegisteredNotifications()
            let current = UNUserNotificationCenter.current()
            current.getNotificationSettings { (settings) in
                if settings.authorizationStatus == .denied {
                    let deniedAlert = UIAlertController(title: "Permission Denied", message: "To enable notifications please activate them in the settings for this app", preferredStyle: .alert)
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
            if cellTag < habitArray.count {
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
            

                //set array to 0 every button press. then get index of selected buttons, append to array and toggle them again.
            
            
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


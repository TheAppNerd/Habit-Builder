//
//  NewHabitVC.swift
//  Habits
//
//  Created by Alexander Thompson on 13/8/21.
//

import UIKit
import CoreData

class NewHabitVC: UITableViewController {

    // MARK: - Properties

    let coreData               = CoreDataMethods.shared
    let userNotifications      = UserNotifications()
    let generator              = UIImpactFeedbackGenerator(style: .medium)
    var habitEntity: HabitEnt?
    var nameTextField          = UITextField()
    var name                   = String()
    var frequency: Int         = 1
    var colorIndex             = Int()
    var iconString             = String()
    var alarmItem              = AlarmItem(alarmActivated: false, title: "", days: "", hour: 0, minute: 0)

    // MARK: - Class Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        loadExistingData()
        configure()
        configureBarButtons()
        dismissKeyboardGesture()
    }

    // MARK: - Methods

    private func configure() {
        tableView.setup(for: .newHabitVC)
        generator.prepare()
    }

    /// If habit entity doesnt equal nil then it means the user came here to edit a preexisting habit. The method then populates all the cells in the tableview with that habits stored data.
    private func loadExistingData() {
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

    private func configureBarButtons() {
        let deleteButton = UIBarButtonItem(image: SFSymbols.trash, style: .done, target: self, action: #selector(deleteHabit))
        switch habitEntity != nil {
        case true:
            deleteButton.image  = SFSymbols.trash
        case false:
            deleteButton.image  = SFSymbols.trashSlash
        }
        navigationItem.rightBarButtonItem = deleteButton
    }

    /// Injects the coreData entity here when page is entered from HabitDetailsVC.
    func set(index: Int) {
        let habit   = coreData.loadHabitArray()[index]
        habitEntity = habit
    }

    private func dismissKeyboardGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    /// Determines whether a new habit is being created or existing habit is being updated. Saves all the relevent data
    private func createHabit() {
        let count = coreData.loadHabitArray().count

        switch habitEntity == nil {
        case true:
            coreData.saveHabit(name: name,
                               icon: iconString,
                               frequency: Int16(frequency),
                               index: count,
                               gradient: Int16(colorIndex),
                               dateCreated: Date(),
                               notificationBool: alarmItem.alarmActivated,
                               alarmItem: alarmItem)
        case false:
            guard let habit         = habitEntity else { return }
            habit.name              = name
            habit.frequency         = Int16(frequency)
            habit.icon              = iconString
            habit.gradient          = Int16(colorIndex)
            habit.notificationBool  = alarmItem.alarmActivated
            coreData.saveAlarmData(habit: habit, alarmItem: alarmItem)
            coreData.updateHabit()
        }
    }

    private func setupNotifications() {
        alarmItem.title = name // This is here to ensure alarm sets properly when habit first created
        if alarmItem.alarmActivated == true {
            userNotifications.scheduleNotifications(alarmItem: alarmItem)
        }
    }

    // MARK: - @Objc Methods

    /// Prompts alert to delete habit. If user accepts, all userNotifications are cleared, the core data habit is cleared and the user is pushed back to HabitHomeVC.
    @objc func deleteHabit() {
        let deleteAlert = UIAlertController(title: Labels.deleteAlertTitle, message: Labels.deleteAlartMessage, preferredStyle: .alert)
        deleteAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        deleteAlert.addAction(UIAlertAction(title: "Delete", style: .default, handler: { _ in
            self.userNotifications.removeNotifications(title: self.habitEntity?.name ?? self.name)
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

    /// When save button is pressed this deactivates all existing userNotifications, creates new habit or updates existing habit in core data, sets up any new userNotifications and pushes user to HabitHomeVC.
    @objc func saveButtonPressed(_ sender: GradientButton) {
        sender.bounce()
        generator.impactOccurred()

        guard name != "" else {
            nameTextField.layer.borderWidth = 2
            return
        }

        userNotifications.removeNotifications(title: habitEntity?.name ?? name)
        nameTextField.layer.borderWidth = 0
        createHabit()
        setupNotifications()
        let habitVC = HabitHomeVC()
        show(habitVC, sender: self)
    }

    /// Takes time from datepicker, converts it to two seperate integers representing hours & minutes to use to set alarms with userNotifications.
    @objc func datePickerTime(_ sender: DatePicker) {
        let time = sender.convertDatePickerTime()
        if let hour = Int(time[0]), let minute = Int(time[1]) {
            alarmItem.hour = hour
            alarmItem.minute = minute
        }
    }

    /// Determines whether or not to set userNotifications for a habit. If user selects to activate them a method runs to determine whether user has granted system access and responds accordingly.
    @objc func dateSegmentChanged(_ sender: UISegmentedControl) {
        generator.impactOccurred()
        sender.setGradientColors()
        switch sender.selectedSegmentIndex {
        case 0:
            alarmItem.alarmActivated = false
        case 1:
            alarmItem.alarmActivated = true
            userNotifications.dateSegmentChanged(segment: sender, vc: self)
        default:
            alarmItem.alarmActivated = false
        }
    }

    // MARK: - TableView - UITableViewDelegate, UITableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Name"
        case 1:
            return "How many days per week?"
        case 2:
            return "Colour"
        case 3:
            return "Icon"
        case 4:
            return "Remind Me"
        default:
            return ""
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: HabitNameCell.reuseID, for: indexPath) as! HabitNameCell
            cell.nameTextField.delegate = self
            nameTextField               = cell.nameTextField
            cell.nameTextField.text     = name

            return cell

        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: HabitFrequencyCell.reuseID, for: indexPath) as! HabitFrequencyCell
            cell.delegate = self
            cell.frequencyButtonArray[frequency - 1].sendActions(for: .touchUpInside)
            return cell

        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: HabitColorCell.reuseID, for: indexPath) as! HabitColorCell
            cell.delegate = self
            cell.buttonArray[colorIndex].sendActions(for: .touchUpInside)
            return cell

        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: HabitIconCell.reuseID, for: indexPath) as! HabitIconCell
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

        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: HabitReminderCell.reuseID, for: indexPath) as! HabitReminderCell
            cell.delegate = self
            cell.alarmSegment.addTarget(self, action: #selector(dateSegmentChanged), for: .valueChanged)
            cell.datePicker.addTarget(self, action: #selector(datePickerTime), for: .valueChanged)
            userNotifications.confirmRegisteredNotifications(segment: cell.alarmSegment)

            switch alarmItem.alarmActivated {
            case true:
                cell.alarmSegment.selectedSegmentIndex = 1
                cell.datePicker.setupDatePickerDate(hour: alarmItem.hour, minute: alarmItem.minute)

            case false:
                cell.alarmSegment.selectedSegmentIndex = 0
            }

            // Converts core data string to bool array as way to store days of week where UserNotifications active.
            let boolArray = coreData.convertStringArraytoBoolArray(alarmItem: alarmItem)
            for (index, bool) in boolArray.enumerated() {
                if bool == true {
                    cell.buttonArray[index].sendActions(for: .touchUpInside)
                }
            }
            return cell

        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: HabitSaveCell.reuseID, for: indexPath) as! HabitSaveCell
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

// MARK: - UITextFieldDelegate

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

// MARK: - Protocol Extensions

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

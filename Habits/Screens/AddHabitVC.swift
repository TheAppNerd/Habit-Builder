//
//  AddHabitVC.swift
//  Habits
//
//  Created by Alexander Thompson on 26/4/21.
//

import UIKit
import CoreData

class AddHabitVC: UIViewController {
    
    var habitArray = [HabitCoreData]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var habitData = HabitData()
    var cellTag = Int()
    
    let nameView = DividerView()
    let frequencyView = DividerView()
    let reminderView = DividerView()
    let reminderDayView = DividerView()
    let colorView = DividerView()
    let iconView = DividerView()
    let deleteView = DividerView()
    let frequencyCount = BodyLabel(textInput: "1", textAlignment: .center, fontSize: 16)
    var frequencyCounter = 1
    let habitNameTextField = HabitTextField()
    let notesTextField = HabitTextField()
    var bellImage = UIImageView(image: UIImage(systemName: "bell.slash"))
    let datePicker = DatePicker()
    let dateSwitch = DateSwitch()
    let padding: CGFloat = 10
    
    let deleteButton = UIButton()
    
    var selectedColor: UIColor?

    let userNotifications = UserNotifications()
    var accessGranted = false
   
    var hour: Int = 0
    var minute: Int = 0
    
    
    //create singular items for all of these. single text field, simple buttons, etc
    var habitColor: UIColor = .systemGreen

    let colorButtons: [ColorButton] = [ColorButton(backgroundColor: .systemBlue),
                                       ColorButton(backgroundColor: .systemOrange),
                                       ColorButton(backgroundColor: .systemPink),
                                       ColorButton(backgroundColor: .systemGreen),
                                       ColorButton(backgroundColor: .systemPurple),
                                       
                                       
    ]
  
    let reminderButtons: [DayButton] = [DayButton(), DayButton(), DayButton(), DayButton(), DayButton(), DayButton(), DayButton()]
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        deleteButton.isHidden = true
        deleteView.isHidden = true
        
        colorButtons[cellTag].sendActions(for: .touchUpInside) //fix this bug to reset back to color 1 when max colors reached.
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCoreData()
        loadPage()
        configure()
        configureBarButtons()
        configureNameView()
        configureFrequencyView()
        configureReminderView()
        configureReminderDays()
        configureColorView()
        configureDeleteView()
        habitNameTextField.delegate = self
        notesTextField.delegate = self
        dimissKeyboard()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
       
        for button in colorButtons {
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        }
        
        for button in reminderButtons {
        button.layer.cornerRadius = 3
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
    
    
    func dimissKeyboard() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func loadPage() {
        if cellTag < habitArray.count {
        habitNameTextField.text = habitArray[cellTag].habitName
        frequencyCount.text = String(habitArray[cellTag].frequency)
        
        let decodedColor = habitArray[cellTag].habitColor?.decode()
        for button in colorButtons {
            if button.backgroundColor == decodedColor {
                button.sendActions(for: .touchUpInside)

            }
        }
            deleteView.isHidden = false
            deleteButton.isHidden = false
        }

//
//            if HabitArray.array[cellTag].alarmBool == true {
//                dateSwitch.isOn = true
//                bellImage.image = UIImage(systemName: "bell.fill")
//                let dateFormatter = DateFormatter()
//                dateFormatter.dateFormat = "HH:mm"
//                hour = HabitArray.array[cellTag].reminderHour!
//                minute = HabitArray.array[cellTag].reminderMinute!
//                if let time = dateFormatter.date(from: "\(hour):\(minute)") {
//                datePicker.date = time
            }
            
            

    
    
    private func configure() {
        view.backgroundColor = .systemBackground
        title = "Add Habit"
        view.addSubviews(nameView, frequencyView, reminderView, reminderDayView, colorView, deleteView)
        self.tabBarController?.tabBar.isHidden = true
        
        for subview in view.subviews {
            NSLayoutConstraint.activate([
                subview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                subview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
                subview.heightAnchor.constraint(equalToConstant: view.frame.height / 18)
            ])}
        
        view.addSubview(iconView)
        iconView.backgroundColor = .red
        
        NSLayoutConstraint.activate([
            nameView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
        
            frequencyView.topAnchor.constraint(equalTo: nameView.bottomAnchor, constant: padding),
        
            iconView.topAnchor.constraint(equalTo: frequencyView.bottomAnchor, constant: padding),
            iconView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            iconView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            iconView.heightAnchor.constraint(equalToConstant: view.frame.height / 6),
            
            reminderView.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: padding),
          
            reminderDayView.topAnchor.constraint(equalTo: reminderView.bottomAnchor, constant: padding),
            
            colorView.topAnchor.constraint(equalTo: reminderDayView.bottomAnchor, constant: padding),
           
            deleteView.topAnchor.constraint(equalTo: colorView.bottomAnchor, constant: padding),
        ])}
    
    private func configureBarButtons() {
         let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissVC))
         let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveHabit))
         navigationItem.leftBarButtonItem = cancelButton
         navigationItem.rightBarButtonItem = saveButton
     }
    
    func configureNameView() {
        let habitNameLabel = BodyLabel(textInput: "Name:", textAlignment: .left, fontSize: 16)
        habitNameTextField.placeholder = "Eg. Workout"
        nameView.addSubviews(habitNameLabel, habitNameTextField)
        
        NSLayoutConstraint.activate([
            habitNameLabel.topAnchor.constraint(equalTo: nameView.topAnchor, constant: padding),
            habitNameLabel.leadingAnchor.constraint(equalTo: nameView.leadingAnchor, constant: padding),
            habitNameLabel.widthAnchor.constraint(equalToConstant: 70),
            habitNameLabel.bottomAnchor.constraint(equalTo: nameView.bottomAnchor, constant: -padding),
            
            habitNameTextField.topAnchor.constraint(equalTo: nameView.topAnchor, constant: padding),
            habitNameTextField.leadingAnchor.constraint(equalTo: habitNameLabel.trailingAnchor, constant: padding),
            habitNameTextField.trailingAnchor.constraint(equalTo: nameView.trailingAnchor, constant: -padding),
            habitNameTextField.bottomAnchor.constraint(equalTo: nameView.bottomAnchor, constant: -padding)
        ])
    }
    
    @objc func negativeButtonPressed() {
        if frequencyCounter > 1 {
            frequencyCounter -= 1
            frequencyCount.text = "\(frequencyCounter)"
        }
    }
    
    @objc func positiveButtonPressed() {
        if frequencyCounter < 7 {
            frequencyCounter += 1
            frequencyCount.text = "\(frequencyCounter)"
        }
    }
    
    func configureFrequencyView() {
        let frequencyLabel = BodyLabel(textInput: "Frequency", textAlignment: .left, fontSize: 16)
        let timesAWeekLabel = BodyLabel(textInput: "Times a week:", textAlignment: .right, fontSize: 16)
        let negativeButton = UIButton()
        let positiveButton = UIButton()
        negativeButton.setImage(UIImage(systemName: "minus"), for: .normal)
        positiveButton.setImage(UIImage(systemName: "plus"), for: .normal)
//        negativeButton.backgroundColor = .systemBlue
//        positiveButton.backgroundColor = .systemBlue
        
        positiveButton.layer.cornerRadius = 10
        negativeButton.layer.cornerRadius = 10
        frequencyCount.layer.cornerRadius = 10
        frequencyCount.layer.masksToBounds = true
        
        frequencyCount.backgroundColor = .secondarySystemBackground
       //frequencyCount.textColor = .label
        
        
        negativeButton.addTarget(self, action: #selector(negativeButtonPressed), for: .touchUpInside)
        positiveButton.addTarget(self, action: #selector(positiveButtonPressed), for: .touchUpInside)
        
        frequencyView.addSubviews(frequencyLabel, timesAWeekLabel, negativeButton, positiveButton, frequencyCount)
        
        for subview in frequencyView.subviews {
            subview.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                subview.topAnchor.constraint(equalTo: frequencyView.topAnchor, constant: padding),
                subview.bottomAnchor.constraint(equalTo: frequencyView.bottomAnchor, constant: -padding)
            ])}
        
        NSLayoutConstraint.activate([
            frequencyLabel.leadingAnchor.constraint(equalTo: frequencyView.leadingAnchor, constant: padding),
            frequencyLabel.widthAnchor.constraint(equalToConstant: 70),
            
            timesAWeekLabel.leadingAnchor.constraint(equalTo: frequencyLabel.trailingAnchor,constant: padding),
            timesAWeekLabel.trailingAnchor.constraint(equalTo: negativeButton.leadingAnchor, constant: -padding),
            
            negativeButton.leadingAnchor.constraint(equalTo: timesAWeekLabel.trailingAnchor, constant: padding),
            negativeButton.trailingAnchor.constraint(equalTo: frequencyCount.leadingAnchor),
            negativeButton.widthAnchor.constraint(equalTo: negativeButton.heightAnchor),
            
            frequencyCount.leadingAnchor.constraint(equalTo: negativeButton.trailingAnchor, constant: padding),
            frequencyCount.trailingAnchor.constraint(equalTo: positiveButton.leadingAnchor),
            frequencyCount.widthAnchor.constraint(equalTo: frequencyCount.heightAnchor),
            
            positiveButton.leadingAnchor.constraint(equalTo: frequencyCount.trailingAnchor),
            positiveButton.trailingAnchor.constraint(equalTo: frequencyView.trailingAnchor, constant: -padding * 2),
            positiveButton.widthAnchor.constraint(equalTo: positiveButton.heightAnchor)
        ])
    }
    
    
    func configureIconView() {
        
    }
    
    func configureReminderView() {
        let reminderLabel = BodyLabel(textInput: "Reminder", textAlignment: .left, fontSize: 16)
        dateSwitch.onTintColor = .systemBlue
        bellImage.tintColor = .systemBlue
        datePicker.addTarget(self, action: #selector(datePickerTime), for: .valueChanged)
        dateSwitch.addTarget(self, action: #selector(dateSwitchPressed), for: .valueChanged)
        
        reminderView.addSubviews(reminderLabel, datePicker, dateSwitch, bellImage)

        for subview in reminderView.subviews {
            subview.translatesAutoresizingMaskIntoConstraints = false
            }
        
        NSLayoutConstraint.activate([
            reminderLabel.leadingAnchor.constraint(equalTo: reminderView.leadingAnchor, constant: padding),
            reminderLabel.trailingAnchor.constraint(equalTo: datePicker.leadingAnchor, constant: -padding),
            reminderLabel.topAnchor.constraint(equalTo: reminderView.topAnchor, constant: padding),
            reminderLabel.bottomAnchor.constraint(equalTo: reminderView.bottomAnchor, constant: -padding),

            datePicker.leadingAnchor.constraint(equalTo: reminderLabel.trailingAnchor, constant: padding),
            datePicker.trailingAnchor.constraint(equalTo: dateSwitch.leadingAnchor, constant: -padding),

            dateSwitch.leadingAnchor.constraint(equalTo: datePicker.trailingAnchor, constant: padding),
            dateSwitch.trailingAnchor.constraint(equalTo: bellImage.leadingAnchor, constant: -padding),
            dateSwitch.centerYAnchor.constraint(equalTo: reminderView.centerYAnchor),

            bellImage.leadingAnchor.constraint(equalTo: dateSwitch.trailingAnchor, constant: padding),
            bellImage.trailingAnchor.constraint(equalTo: reminderView.trailingAnchor, constant: -padding),
            bellImage.widthAnchor.constraint(equalTo: bellImage.heightAnchor),
            bellImage.topAnchor.constraint(equalTo: reminderView.topAnchor, constant: padding),
            bellImage.bottomAnchor.constraint(equalTo: reminderView.bottomAnchor, constant: -padding)
        ])}
    
    
    func configureReminderDays() {
        let reminderDayLabel = BodyLabel(textInput: "Reminder Days:", textAlignment: .left, fontSize: 16) //set font sizes as a let in constants page to keep consistency
        
        let reminderButtonText = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
        
        let reminderStackView = UIStackView()
        reminderStackView.spacing = 2
        reminderDayView.addSubviews(reminderDayLabel, reminderStackView)
        reminderStackView.translatesAutoresizingMaskIntoConstraints = false
        var buttonTag = 0
        reminderStackView.axis = .horizontal
        reminderStackView.distribution = .fillEqually
        
        
        
        for button in reminderButtons {
            reminderStackView.addArrangedSubview(button)
            button.setTitle(reminderButtonText[buttonTag], for: .normal)

            button.tag = buttonTag
            buttonTag += 1
            button.backgroundColor = .systemBlue
            button.addTarget(self, action: #selector(dayTapped), for: .touchUpInside)
            
            if button.isSelected == true {
                button.alpha = 1.0
                button.layer.borderWidth = 2
                button.layer.borderColor = UIColor.label.cgColor
            } else {
                button.layer.borderWidth = 0
                button.alpha = 0.5
                
            }
                    NSLayoutConstraint.activate([
                        button.topAnchor.constraint(equalTo: reminderStackView.topAnchor),
                        button.widthAnchor.constraint(equalTo: button.heightAnchor),
                        button.bottomAnchor.constraint(equalTo: reminderStackView.bottomAnchor)
                    ])
    }
        NSLayoutConstraint.activate([
            reminderDayLabel.leadingAnchor.constraint(equalTo: reminderDayView.leadingAnchor, constant: padding),
            reminderDayLabel.topAnchor.constraint(equalTo: reminderDayView.topAnchor, constant: padding * 2),
            //reminderDayLabel.widthAnchor.constraint(equalToConstant: 70),
            reminderDayLabel.bottomAnchor.constraint(equalTo: reminderDayView.bottomAnchor, constant: -padding * 2),
            
            
            reminderStackView.leadingAnchor.constraint(equalTo: reminderDayLabel.trailingAnchor, constant: padding),
            reminderStackView.topAnchor.constraint(equalTo: reminderDayView.topAnchor, constant: padding),
            reminderStackView.trailingAnchor.constraint(equalTo: reminderDayView.trailingAnchor, constant: -padding),
            reminderStackView.bottomAnchor.constraint(equalTo: reminderDayView.bottomAnchor, constant: -padding)
        ])
    }
        
    @objc func dayTapped(sender: UIButton) {
        sender.isSelected.toggle()
        if sender.isSelected == true {
            sender.alpha = 1.0
            sender.layer.borderWidth = 2
            sender.layer.borderColor = UIColor.label.cgColor
        } else {
            sender.layer.borderWidth = 0
            sender.alpha = 0.5
            
        }
    }
    
    func configureColorView() {
        //add extra row of colors
        let colorLabel = BodyLabel(textInput: "Color:", textAlignment: .left, fontSize: 16)
        colorView.addSubview(colorLabel)
        let colorStackView = UIStackView()
        colorStackView.spacing = 6
        colorView.addSubview(colorStackView)
        colorStackView.translatesAutoresizingMaskIntoConstraints = false
        var buttonTag = 0
        colorStackView.axis = .horizontal
        colorStackView.distribution = .fillEqually
        
        
        for button in colorButtons {
            colorStackView.addArrangedSubview(button)
            button.tag = buttonTag
            buttonTag += 1
            button.addTarget(self, action: #selector(colorTapped), for: .touchUpInside)
                    NSLayoutConstraint.activate([
                        button.topAnchor.constraint(equalTo: colorStackView.topAnchor),
                        button.widthAnchor.constraint(equalTo: button.heightAnchor),
                        button.bottomAnchor.constraint(equalTo: colorStackView.bottomAnchor)
                    ])
    }
        NSLayoutConstraint.activate([
            colorLabel.leadingAnchor.constraint(equalTo: colorView.leadingAnchor, constant: padding),
            colorLabel.topAnchor.constraint(equalTo: colorView.topAnchor, constant: padding),
            colorLabel.widthAnchor.constraint(equalToConstant: 70),
            colorLabel.bottomAnchor.constraint(equalTo: colorView.bottomAnchor, constant: -padding),
            
            
            colorStackView.leadingAnchor.constraint(equalTo: colorLabel.trailingAnchor, constant: padding),
            colorStackView.topAnchor.constraint(equalTo: colorView.topAnchor, constant: padding),
            colorStackView.trailingAnchor.constraint(equalTo: colorView.trailingAnchor, constant: -padding),
            colorStackView.bottomAnchor.constraint(equalTo: colorView.bottomAnchor, constant: -padding)
        ])
    }
    
    func configureDeleteView() {
        deleteView.addSubview(deleteButton)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.backgroundColor = .systemRed
        deleteButton.setTitle("Delete Habit", for: .normal)
        deleteButton.addTarget(self, action: #selector(deleteHabit), for: .touchUpInside)
        deleteButton.layer.cornerRadius = 10

        NSLayoutConstraint.activate([
            deleteButton.leadingAnchor.constraint(equalTo: deleteView.leadingAnchor),
            deleteButton.trailingAnchor.constraint(equalTo: deleteView.trailingAnchor),
            deleteButton.topAnchor.constraint(equalTo: deleteView.topAnchor),
            deleteButton.bottomAnchor.constraint(equalTo: deleteView.bottomAnchor)
        ])
    }
    
    
    
    @objc func dateSwitchPressed() {
        if dateSwitch.isOn == true {
            habitData.alarmBool = true
            bellImage.image = UIImage(systemName: "bell.fill")
        } else if dateSwitch.isOn == false {
            habitData.alarmBool = false
            bellImage.image = UIImage(systemName: "bell.slash")
            userNotifications.scheduleNotification(title: habitNameTextField.text!, hour: hour, minute: minute, onOrOff: false)
           
        }
    }
  
  
    @objc func colorTapped(_ sender: UIButton) {
        deselectButtons()
        sender.layer.borderWidth = 2
        sender.layer.borderColor = UIColor.label.cgColor
        selectedColor = sender.backgroundColor
        habitColor = sender.backgroundColor ?? .clear
       
    }
    
    func deselectButtons() {
        colorButtons.forEach {
            $0.isSelected = false
            $0.layer.borderWidth = 0
        }
    }
    
    @objc func datePickerTime() {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        let dateAsString = formatter.string(from: datePicker.date)
        
        let date = formatter.date(from: dateAsString)
        formatter.dateFormat = "HH:mm"
        
        let twentyFourHourDate = formatter.string(from: date!)
        HabitArray.array.remove(at: cellTag)
        let time = twentyFourHourDate.components(separatedBy: ":")
        hour = Int(time[0])!
        minute = Int(time[1])!
        
        
    }
    
    
    @objc func dismissVC() {
        let destVC = UINavigationController(rootViewController: HabitVC())
        destVC.modalPresentationStyle = .fullScreen
        present(destVC, animated: true)
    }

    @objc func deleteHabit() {
        let deleteAlert = UIAlertController(title: "Delete Habit?", message: "Are you sure you want to delete this? It cannot be recovered.", preferredStyle: .alert)
        deleteAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel , handler: { UIAlertAction in
        
        }))
        deleteAlert.addAction(UIAlertAction(title: "Delete", style: .default, handler: { UIAlertAction in
            HabitArray.array.remove(at: self.cellTag)
            HabitVC.cellCount -= 1
            let destVC = UINavigationController(rootViewController: HabitVC())
            destVC.modalPresentationStyle = .fullScreen
            
            self.present(destVC, animated: true)
            
        }))
        present(deleteAlert, animated: true, completion: nil)
        
    }
    
    func getYear() -> Int {
        let today = Date()
        let calendar = Calendar(identifier: .gregorian)
        let year = calendar.component(.year, from: today)
      
        return year
    }
    
    

    @objc func saveHabit() {
        
        if habitNameTextField.text == "" {
            habitNameTextField.layer.borderWidth = 1
            habitNameTextField.layer.borderColor = UIColor.systemRed.cgColor
        }
        

        if habitNameTextField.text != "" {
            habitNameTextField.layer.borderWidth = 0
            
            let newHabit = HabitCoreData(context: self.context)
            let colorData = habitColor.encode()
            newHabit.habitColor = colorData
            newHabit.habitName = habitNameTextField.text
            newHabit.frequency = Int16(frequencyCounter)
            
            
            let newYear = HabitCoreYear(context: self.context)
            newYear.year = Int16(getYear())
            newYear.parentYears = newHabit
            newYear.january = []
            newYear.february = []
            newYear.march = []
            newYear.april = []
            newYear.may = []
            newYear.june = []
            newYear.july = []
            newYear.august = []
            newYear.september = []
            newYear.october = []
            newYear.november = []
            newYear.december = []
            
            newHabit.addToYears(newYear)
            
            
            let newYear2 = HabitCoreYear(context: self.context)
            newYear2.year = Int16(getYear()-1)
            newYear2.parentYears = newHabit
           newYear2.january = []
           newYear2.february = []
           newYear2.march = []
           newYear2.april = []
           newYear2.may = []
           newYear2.june = []
           newYear2.july = []
           newYear2.august = []
           newYear2.september = []
           newYear2.october = []
           newYear2.november = []
           newYear2.december = []
            newHabit.addToYears(newYear2)
            
            if habitArray.count > cellTag {
                habitArray[cellTag] = newHabit
            } else {
                habitArray.append(newHabit)
            }
            saveCoreData()
            
            
            
            habitData.reminderHour = hour
            habitData.reminderMinute = minute
           if dateSwitch.isOn == true {
            userNotifications.scheduleNotification(title: habitNameTextField.text!, hour: hour, minute: minute, onOrOff: true)
            habitData.habitNumber = cellTag
           }
            
            if HabitArray.habitCreated == true {
                HabitArray.array[cellTag] = habitData

            let destVC = UINavigationController(rootViewController: HabitVC())
            destVC.modalPresentationStyle = .fullScreen
            present(destVC, animated: true)
        } else {
        HabitArray.array.append(habitData)
            HabitVC.cellCount += 1
        let destVC = UINavigationController(rootViewController: HabitVC())
        destVC.modalPresentationStyle = .fullScreen
        present(destVC, animated: true)
        }
        }
    }
}

extension AddHabitVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        habitNameTextField.resignFirstResponder()
        notesTextField.resignFirstResponder()
        return true
    }
    
    
}

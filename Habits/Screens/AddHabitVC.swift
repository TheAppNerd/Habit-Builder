//
//  AddHabitVC.swift
//  Habits
//
//  Created by Alexander Thompson on 26/4/21.
//

import UIKit

class AddHabitVC: UIViewController {
    var habitData = HabitData()
    var cellTag: Int = 0
    
    
    let nameView = DividerView()
    let frequencyView = DividerView()
    let reminderView = DividerView()
    let reminderNoteView = DividerView()
    let colorView = DividerView()
    let deleteView = DividerView()
    let frequencyCount = BodyLabel(textInput: "1", textAlignment: .center, fontSize: 16)
    var frequencyCounter = 1
    let habitNameTextField = HabitTextField()
    let notesTextField = HabitTextField()
    var bellImage = UIImageView(image: UIImage(systemName: "bell.slash"))
    let datePicker = DatePicker()
    let dateSwitch = DateSwitch()
    let padding: CGFloat = 10
    var colorTag = 0
    let deleteButton = UIButton()

    let userNotifications = UserNotifications()
    var accessGranted = false
   
    var hour: Int = 0
    var minute: Int = 0
    
    
    
    var habitColor: UIColor = .systemGreen

    let colorButtons: [ColorButton] = [ColorButton(backgroundColor: .systemRed),
                                       ColorButton(backgroundColor: .systemBlue),
                                       ColorButton(backgroundColor: .systemYellow),
                                       ColorButton(backgroundColor: .systemGreen),
                                       ColorButton(backgroundColor: .systemPurple),
                                       ColorButton(backgroundColor: .systemOrange),
                                       ColorButton(backgroundColor: .systemIndigo),
                                       ColorButton(backgroundColor: .systemTeal)
    ]
  
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadPage()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        frequencyCount.text = habitData.weeklyFrequency ?? "1"
        
        configure()
        configureBarButtons()
        configureNameView()
        configureFrequencyView()
        configureReminderView()
        configureReminderNoteView()
        configureColorView()
        configureDeleteView()
    
    }
    
    func loadPage() {
        if HabitArray.habitCreated == true {
            habitNameTextField.text = HabitArray.Array[cellTag].habitName
            notesTextField.text = HabitArray.Array[cellTag].habitNote
            colorButtons[HabitArray.Array[cellTag].colorTag!].sendActions(for: .touchUpInside)
            
            if HabitArray.Array[cellTag].alarmBool == true {
                dateSwitch.isOn = true
                bellImage.image = UIImage(systemName: "bell.fill")
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "HH:mm"
                hour = HabitArray.Array[cellTag].reminderHour!
                minute = HabitArray.Array[cellTag].reminderMinute!
                if let time = dateFormatter.date(from: "\(hour):\(minute)") {
                datePicker.date = time
            }
            }
            

        }
    }

    
    
    private func configure() {
        view.backgroundColor = .systemBackground
        title = "Add Habit"
        view.addSubviews(nameView, frequencyView, reminderView, reminderNoteView, colorView, deleteView)
        self.tabBarController?.tabBar.isHidden = true
        
        for subview in view.subviews {
            NSLayoutConstraint.activate([
                subview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                subview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
                subview.heightAnchor.constraint(equalToConstant: view.frame.height / 18)
            ])}
        
        NSLayoutConstraint.activate([
            nameView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
        
            frequencyView.topAnchor.constraint(equalTo: nameView.bottomAnchor, constant: padding),
        
            reminderView.topAnchor.constraint(equalTo: frequencyView.bottomAnchor, constant: padding),
          
            reminderNoteView.topAnchor.constraint(equalTo: reminderView.bottomAnchor, constant: padding),
            
            colorView.topAnchor.constraint(equalTo: reminderNoteView.bottomAnchor, constant: padding),
           
            deleteView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
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
        negativeButton.backgroundColor = .blue
        positiveButton.backgroundColor = .blue
        
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
            negativeButton.trailingAnchor.constraint(equalTo: frequencyCount.leadingAnchor, constant: -padding),
            
            frequencyCount.leadingAnchor.constraint(equalTo: negativeButton.trailingAnchor, constant: padding),
            frequencyCount.trailingAnchor.constraint(equalTo: positiveButton.leadingAnchor, constant: -padding),
            
            positiveButton.leadingAnchor.constraint(equalTo: frequencyCount.trailingAnchor, constant: padding),
            positiveButton.trailingAnchor.constraint(equalTo: frequencyView.trailingAnchor, constant: -padding * 2)
        ])
    }
    
    
    func configureReminderView() {
        let reminderLabel = BodyLabel(textInput: "Reminder", textAlignment: .left, fontSize: 16)
        
        datePicker.addTarget(self, action: #selector(datePickerTime), for: .valueChanged)
        dateSwitch.addTarget(self, action: #selector(dateSwitchPressed), for: .valueChanged)
        
        reminderView.addSubviews(reminderLabel, datePicker, dateSwitch, bellImage)

        for subview in reminderView.subviews {
            subview.translatesAutoresizingMaskIntoConstraints = false
            }
        
        NSLayoutConstraint.activate([
            reminderLabel.leadingAnchor.constraint(equalTo: reminderView.leadingAnchor, constant: padding),
            reminderLabel.widthAnchor.constraint(equalToConstant: 70),
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
    
    
    func configureReminderNoteView() {
        let notesLabel = BodyLabel(textInput: "Reminder Note:", textAlignment: .left, fontSize: 16)
        reminderNoteView.addSubviews(notesLabel, notesTextField)
        
        for subview in reminderNoteView.subviews {
            NSLayoutConstraint.activate([
                subview.topAnchor.constraint(equalTo: reminderNoteView.topAnchor, constant: padding),
                subview.bottomAnchor.constraint(equalTo: reminderNoteView.bottomAnchor, constant: -padding)
            ])}
        NSLayoutConstraint.activate([
            notesLabel.leadingAnchor.constraint(equalTo: reminderNoteView.leadingAnchor, constant: padding),
            notesLabel.widthAnchor.constraint(equalToConstant: 100),
        
            notesTextField.leadingAnchor.constraint(equalTo: notesLabel.trailingAnchor, constant: padding),
            notesTextField.trailingAnchor.constraint(equalTo: reminderNoteView.trailingAnchor, constant: -padding),
        ])
        
    }
    
    func configureColorView() {
        //add extra row of colors
        let colorLabel = BodyLabel(textInput: "Color:", textAlignment: .left, fontSize: 16)
        colorView.addSubview(colorLabel)
        let colorStackView = UIStackView()
        colorView.addSubview(colorStackView)
        colorStackView.translatesAutoresizingMaskIntoConstraints = false
        var buttonTag = 0
        colorStackView.axis = .horizontal
        colorStackView.distribution = .equalSpacing
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
        deleteButton.layer.cornerRadius = 10
            
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.backgroundColor = .systemRed
        deleteButton.setTitle("Delete Habit", for: .normal)
        deleteButton.addTarget(self, action: #selector(deleteHabit), for: .touchUpInside)
        
        deleteView.isHidden = true
        if HabitArray.habitCreated == true {
            deleteView.isHidden = false
        } else {
            deleteView.isHidden = true
        }
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
            userNotifications.scheduleNotification(title: habitNameTextField.text!, body: notesTextField.text ?? "", hour: hour, minute: minute, onOrOff: false)
           
        }
    }
  
    @objc func colorTapped(_ sender: UIButton) {
        deselectButtons()
        sender.layer.borderWidth = 2
        sender.layer.borderColor = UIColor.systemGray2.cgColor
        habitColor = sender.backgroundColor ?? .clear
        colorTag = sender.tag
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
            HabitArray.Array.remove(at: self.cellTag)
            HabitArray.habitCreated = false
            HabitVC.cellCount -= 1
            let destVC = UINavigationController(rootViewController: HabitVC())
            destVC.modalPresentationStyle = .fullScreen
            self.present(destVC, animated: true)
        }))
        if HabitArray.habitCreated == true {
        present(deleteAlert, animated: true, completion: nil)
        }
    }
    
    @objc func saveHabit() {
        
        if habitNameTextField.text == "" {
            habitNameTextField.layer.borderWidth = 1
            habitNameTextField.layer.borderColor = UIColor.systemRed.cgColor
            //add if function hjere for color buttons to be selected. make them a horizonal stack first.
        }
        
        
        
        // use guard statement instead
        if habitNameTextField.text != "" {
            habitNameTextField.layer.borderWidth = 0
            habitData.reminderHour = hour
            habitData.reminderMinute = minute
        habitData.weeklyFrequency = "\(frequencyCounter)"
        habitData.habitName = habitNameTextField.text ?? ""
        habitData.habitNote = notesTextField.text ?? ""
        habitData.buttonColor = habitColor
            habitData.colorTag = colorTag
           if dateSwitch.isOn == true {
            userNotifications.scheduleNotification(title: habitNameTextField.text!, body: notesTextField.text ?? "", hour: hour, minute: minute, onOrOff: true)
           }
            
        if HabitArray.habitCreated == true {
            HabitArray.Array.insert(habitData, at: cellTag)
            let destVC = UINavigationController(rootViewController: HabitDetailsVC())
            destVC.modalPresentationStyle = .fullScreen
            present(destVC, animated: true)
            HabitArray.habitCreated = false
        } else {
        HabitArray.Array.append(habitData)
            HabitVC.cellCount += 1
        let destVC = UINavigationController(rootViewController: HabitVC())
        destVC.modalPresentationStyle = .fullScreen
        present(destVC, animated: true)
            HabitArray.habitCreated = false
        }
        }
    }
}


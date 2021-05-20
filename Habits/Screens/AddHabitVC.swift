//
//  AddHabitVC.swift
//  Habits
//
//  Created by Alexander Thompson on 26/4/21.
//

import UIKit

class AddHabitVC: UIViewController {

    let nameView = DividerView()
    let frequencyView = DividerView()
    let colorView = DividerView()
    let reminderView = DividerView()
    let reminderNoteView = DividerView()
    let deleteView = DividerView()
    
    let habitNameTextField = HabitTextField()
    
    let notesLabel = BodyLabel(textInput: "Notes:", textAlignment: .left, fontSize: 16)
    let colorLabel = BodyLabel(textInput: "Color:", textAlignment: .left, fontSize: 16)
    let reminderLabel = BodyLabel(textInput: "Set Reminder?", textAlignment: .left, fontSize: 16)
    let datePicker = DatePicker()
    let dateSwitch = DateSwitch()
    
    let notesTextField = HabitTextField()
    
    let padding: CGFloat = 10
    
    //add a clear habit button
    let deleteButton = UIButton()

    let userNotifications = UserNotifications()
    var accessGranted = false
    var hour: Int = 0
    var minute: Int = 0
    
    var cellTag: Int = 0
    
   

    
    var habitData = HabitData()
    var habitColor: UIColor = .clear
    

    let colorButtons: [ColorButton] = [ColorButton(backgroundColor: .systemRed),
                                       ColorButton(backgroundColor: .systemBlue),
                                       ColorButton(backgroundColor: .systemYellow),
                                       ColorButton(backgroundColor: .systemGreen),
                                       ColorButton(backgroundColor: .systemPurple)
    ]
  
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureBarButtons()
        configureColorButtons()
        editTab()
        if dateSwitch.isOn == false {
            datePicker.isHidden = true
        }
        
        //no tab bars. build nav bar settings button
        self.tabBarController?.tabBar.isHidden = true
        deleteButton.isHidden = true
        if HabitArray.habitCreated == true {
            deleteButton.isHidden = false
        } else {
            deleteButton.isHidden = true
        }
    }
    
    func configureNameView() {
        let habitNameLabel = BodyLabel(textInput: "Name:", textAlignment: .left, fontSize: 16)
        
        nameView.addSubviews(habitNameLabel, habitNameTextField)
        
        NSLayoutConstraint.activate([
            habitNameLabel.leadingAnchor.constraint(equalTo: nameView.leadingAnchor, constant: padding),
            habitNameLabel.centerYAnchor.constraint(equalTo: nameView.centerYAnchor),
            habitNameLabel.heightAnchor.constraint(equalToConstant: nameView.frame.height / 3),
            habitNameLabel.widthAnchor.constraint(equalToConstant: nameView.frame.width / 6),
            
            habitNameTextField.leadingAnchor.constraint(equalTo: habitNameLabel.trailingAnchor, constant: padding),
            habitNameTextField.centerYAnchor.constraint(equalTo: nameView.centerYAnchor),
            habitNameTextField.heightAnchor.constraint(equalToConstant: nameView.frame.height / 3),
            habitNameTextField.trailingAnchor.constraint(equalTo: nameView.trailingAnchor, constant: -padding)
        ])
    }
    
    func configureFrequencyView() {
        let frequencyLabel = BodyLabel(textInput: "Frequency", textAlignment: .left, fontSize: 16)
        let timesAWeekLabel = BodyLabel(textInput: "Times a week:", textAlignment: .right, fontSize: 16)
        let negativeButton = UIButton()
        let positiveButton = UIButton()
        let frequencyCount = BodyLabel(textInput: "0", textAlignment: .center, fontSize: 16)
        negativeButton.setImage(UIImage(systemName: "minus"), for: .normal)
        positiveButton.setImage(UIImage(systemName: "plus"), for: .normal)
        //add button targets here.
        
        frequencyView.addSubviews(frequencyLabel, timesAWeekLabel, negativeButton, positiveButton, frequencyCount)
        
        NSLayoutConstraint.activate([
            frequencyLabel.leadingAnchor.constraint(equalTo: frequencyView.leadingAnchor, constant: padding),
            frequencyLabel.centerYAnchor.constraint(equalTo: frequencyView.centerYAnchor),
            frequencyLabel.heightAnchor.constraint(equalToConstant: frequencyView.frame.height / 3),
            frequencyLabel.widthAnchor.constraint(equalToConstant: frequencyView.frame.width / 4),
            
            timesAWeekLabel.leadingAnchor.constraint(equalTo: frequencyLabel.trailingAnchor,constant: padding),
            timesAWeekLabel.centerYAnchor.constraint(equalTo: frequencyView.centerYAnchor),
            timesAWeekLabel.heightAnchor.constraint(equalToConstant: frequencyView.frame.height / 3),
            timesAWeekLabel.trailingAnchor.constraint(equalTo: negativeButton.leadingAnchor, constant: -padding),
            
            negativeButton.leadingAnchor.constraint(equalTo: timesAWeekLabel.trailingAnchor, constant: padding),
            negativeButton.centerYAnchor.constraint(equalTo: frequencyView.centerYAnchor),
            negativeButton.heightAnchor.constraint(equalToConstant: frequencyView.frame.height / 3),
            negativeButton.trailingAnchor.constraint(equalTo: frequencyCount.leadingAnchor, constant: -padding),
            
            frequencyCount.leadingAnchor.constraint(equalTo: negativeButton.trailingAnchor, constant: padding),
            frequencyCount.centerYAnchor.constraint(equalTo: frequencyView.centerYAnchor),
            frequencyCount.heightAnchor.constraint(equalToConstant: frequencyView.frame.height / 3),
            frequencyCount.trailingAnchor.constraint(equalTo: positiveButton.leadingAnchor, constant: -padding),
            
            positiveButton.leadingAnchor.constraint(equalTo: frequencyCount.trailingAnchor, constant: padding),
            positiveButton.centerYAnchor.constraint(equalTo: frequencyCount.trailingAnchor, constant: padding)
        ])
        
    }
    
    func configureReminderView() {
        
    }
    
    func configureReminderNoteView() {
        
    }
    
    func configureColorView() {
        
    }
    
    func configureDeleteView() {
        
    }
    
    
    func configureColorButtons() {
        for button in colorButtons {
            button.addTarget(self, action: #selector(colorTapped), for: .touchUpInside)
            
        }
    }
  
    @objc func colorTapped(_ sender: UIButton) {
        deselectButtons()
        sender.layer.borderWidth = 2
        sender.layer.borderColor = UIColor.systemGray2.cgColor
        habitColor = sender.backgroundColor ?? .clear
    }
    
    func deselectButtons() {
        colorButtons.forEach {
            $0.isSelected = false
            $0.layer.borderWidth = 0
        }
    }
    
    func editTab() {
        if HabitArray.habitCreated == true {
            habitNameTextField.text = HabitArray.Array[cellTag].habitName
            notesTextField.text = HabitArray.Array[cellTag].habitNote
                //select correrct color button
            //dailyNumberTextField.text = HabitArray.Array[cellTag].completionCount

        }
    }
    
   private func configureBarButtons() {
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissVC))
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveHabit))
        
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = saveButton
    }
    
    private func configure() {
        view.backgroundColor = .systemBackground
        title = "Add Habit"
        
        
        
        
        datePicker.addTarget(self, action: #selector(datePickerTime), for: .valueChanged)
        
        for button in colorButtons {
            view.addSubview(button)
            NSLayoutConstraint.activate([
                button.topAnchor.constraint(equalTo: colorLabel.topAnchor),
                button.heightAnchor.constraint(equalTo: colorLabel.heightAnchor),
                button.widthAnchor.constraint(equalTo: button.heightAnchor),
            ])
    }
        
        dateSwitch.addTarget(self, action: #selector(dateSwitchPressed), for: .valueChanged)
        
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.backgroundColor = .systemRed
        deleteButton.setTitle("Delete Habit", for: .normal)
        deleteButton.addTarget(self, action: #selector(deleteHabit), for: .touchUpInside)
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
    
            deleteButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            deleteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            deleteButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            deleteButton.heightAnchor.constraint(equalToConstant: 30),
            
    
        ])
    }

    @objc func dateSwitchPressed() {
        if dateSwitch.isOn == true {
            
            datePicker.isHidden = false
            } else {
            datePicker.isHidden = true
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
       // let components = DateComponents(hour: <#T##Int?#>, minute: <#T##Int?#>)
    }
    
    
    @objc func dismissVC() {
        let destVC = UINavigationController(rootViewController: HabitVC())
        destVC.modalPresentationStyle = .fullScreen
        present(destVC, animated: true)
    }

    @objc func deleteHabit() {
        //build out button here asking if user is sure and then delete.
        
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
           
            
        habitData.habitName = habitNameTextField.text ?? ""
        habitData.habitNote = notesTextField.text ?? ""
        habitData.buttonColor = habitColor
            // make this an if statement
            userNotifications.scheduleNotification(title: habitNameTextField.text!, body: "TEST", hour: hour, minute: minute)

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


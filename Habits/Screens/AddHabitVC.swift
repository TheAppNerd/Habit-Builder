//
//  AddHabitVC.swift
//  Habits
//
//  Created by Alexander Thompson on 26/4/21.
//

import UIKit

class AddHabitVC: UIViewController {

    let habitNameLabel = BodyLabel(textInput: "Name:", textAlignment: .center, fontSize: 16)
    let notesLabel = BodyLabel(textInput: "Notes:", textAlignment: .center, fontSize: 16)
    let colorLabel = BodyLabel(textInput: "Color:", textAlignment: .center, fontSize: 16)
    let dailyNumberLabel = BodyLabel(textInput: "Daily Target:", textAlignment: .center, fontSize: 16)
    let reminderLabel = BodyLabel(textInput: "Set Reminder?", textAlignment: .center, fontSize: 16)
    var cellTag: Int = 0
    
    let deleteButton = UIButton()
   
    let habitNameTextField = HabitTextField()
    let notesTextField = HabitTextField()
    let dailyNumberTextField = HabitTextField()
    
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
        
        //no tab bars. build nav bar settings button
        self.tabBarController?.tabBar.isHidden = true
        deleteButton.isHidden = true
        if HabitArray.habitCreated == true {
            deleteButton.isHidden = false
        } else {
            deleteButton.isHidden = true
        }
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
            dailyNumberTextField.text = HabitArray.Array[cellTag].completionCount

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
        
        view.addSubview(habitNameLabel)
        view.addSubview(notesLabel)
        view.addSubview(colorLabel)
        view.addSubview(dailyNumberLabel)
        view.addSubview(reminderLabel)
        view.addSubview(deleteButton)
        view.addSubview(habitNameTextField)
        view.addSubview(notesTextField)
        view.addSubview(dailyNumberTextField)
      
        
        
        
        
        for button in colorButtons {
            view.addSubview(button)
            NSLayoutConstraint.activate([
                button.topAnchor.constraint(equalTo: colorLabel.topAnchor),
                button.heightAnchor.constraint(equalTo: colorLabel.heightAnchor),
                button.widthAnchor.constraint(equalTo: button.heightAnchor),
            ])
    }
        
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.backgroundColor = .systemRed
        deleteButton.setTitle("Delete Habit", for: .normal)
        deleteButton.addTarget(self, action: #selector(deleteHabit), for: .touchUpInside)
        dailyNumberTextField.keyboardType = .numberPad
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            habitNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            habitNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            habitNameLabel.widthAnchor.constraint(equalToConstant: 80),
            habitNameLabel.heightAnchor.constraint(equalToConstant: padding),
            
            notesLabel.topAnchor.constraint(equalTo: habitNameLabel.bottomAnchor, constant: padding),
            notesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            notesLabel.widthAnchor.constraint(equalToConstant: 80),
            notesLabel.heightAnchor.constraint(equalToConstant: padding),
            
            colorLabel.topAnchor.constraint(equalTo: notesLabel.bottomAnchor, constant: padding * 2),
            colorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            colorLabel.widthAnchor.constraint(equalToConstant: 80),
            colorLabel.heightAnchor.constraint(equalToConstant: padding),
            
            dailyNumberLabel.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: padding),
            dailyNumberLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            dailyNumberLabel.widthAnchor.constraint(equalToConstant: 80),
            dailyNumberLabel.heightAnchor.constraint(equalToConstant: 30),
            
            reminderLabel.topAnchor.constraint(equalTo: dailyNumberLabel.bottomAnchor, constant: padding),
            reminderLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            reminderLabel.widthAnchor.constraint(equalToConstant: 80),
            reminderLabel.heightAnchor.constraint(equalToConstant: 30),
            
            colorButtons[0].leadingAnchor.constraint(equalTo: colorLabel.trailingAnchor, constant: padding),
            colorButtons[1].leadingAnchor.constraint(equalTo: colorLabel.trailingAnchor, constant: padding * 3),
            colorButtons[2].leadingAnchor.constraint(equalTo: colorLabel.trailingAnchor, constant: padding * 5),
            colorButtons[3].leadingAnchor.constraint(equalTo: colorLabel.trailingAnchor, constant: padding * 7),
            colorButtons[4].leadingAnchor.constraint(equalTo: colorLabel.trailingAnchor, constant: padding * 9),
            
            habitNameTextField.topAnchor.constraint(equalTo: habitNameLabel.topAnchor),
            habitNameTextField.leadingAnchor.constraint(equalTo: habitNameLabel.trailingAnchor, constant: padding),
            habitNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            habitNameTextField.heightAnchor.constraint(equalToConstant: 25),
            
            notesTextField.topAnchor.constraint(equalTo: notesLabel.topAnchor),
            notesTextField.leadingAnchor.constraint(equalTo: notesLabel.trailingAnchor, constant: padding),
            notesTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            notesTextField.heightAnchor.constraint(equalToConstant: padding * 2),
            
            dailyNumberTextField.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: padding),
            dailyNumberTextField.leadingAnchor.constraint(equalTo: dailyNumberLabel.trailingAnchor, constant: padding),
            dailyNumberTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            dailyNumberTextField.heightAnchor.constraint(equalToConstant: 25),
            
            deleteButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            deleteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            deleteButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            deleteButton.heightAnchor.constraint(equalToConstant: 30),
        ])
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
        if dailyNumberTextField.text == "" {
            dailyNumberTextField.layer.borderWidth = 1
            dailyNumberTextField.layer.borderColor = UIColor.systemRed.cgColor
        }
        
        // use guard statement instead
        if habitNameTextField.text != "" && dailyNumberTextField.text != "" {
            habitNameTextField.layer.borderWidth = 0
            dailyNumberTextField.layer.borderWidth = 0
            
        habitData.habitName = habitNameTextField.text ?? ""
        habitData.habitNote = notesTextField.text ?? ""
        habitData.completionCount = dailyNumberTextField.text ?? ""
        habitData.buttonColor = habitColor
        habitData.currentDailyCount = 0
        habitData.progressCount = 0.0

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


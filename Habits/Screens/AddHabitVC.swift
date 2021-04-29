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
    
   
    let habitNameTextField = HabitTextField()
    let notesTextField = HabitTextField()
    let dailyNumberTextField = HabitTextField()
    
    var habitData: HabitData!
    var habitColor: UIColor = .clear
    
    let colorButtons: [ColorButton] = [ColorButton(backgroundColor: .systemRed),
                                       ColorButton(backgroundColor: .systemBlue),
                                       ColorButton(backgroundColor: .systemYellow),
                                       ColorButton(backgroundColor: .systemGreen),
                                       ColorButton(backgroundColor: .systemPink)
    ]
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureBarButtons()
        configureColorButtons()
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
    
    func configureBarButtons() {
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
            habitNameTextField.heightAnchor.constraint(equalToConstant: padding),
            
            notesTextField.topAnchor.constraint(equalTo: notesLabel.topAnchor),
            notesTextField.leadingAnchor.constraint(equalTo: notesLabel.trailingAnchor, constant: padding),
            notesTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            notesTextField.heightAnchor.constraint(equalToConstant: padding * 2),
            
            dailyNumberTextField.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: padding),
            dailyNumberTextField.leadingAnchor.constraint(equalTo: dailyNumberLabel.trailingAnchor, constant: padding),
            dailyNumberTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            dailyNumberTextField.heightAnchor.constraint(equalToConstant: padding),
            
            
        
        ])
    }

    @objc func dismissVC() {
        dismiss(animated: true)
    }

    @objc func saveHabit() {
        
        habitData.habitName = habitNameTextField.text ?? ""
        habitData.habitNote = notesTextField.text ?? ""
        habitData.completionCount = dailyNumberLabel.text ?? ""
        habitData.buttonColor = habitColor
        HabitVC.cellCount += 1
        HabitArray.Array.insert(habitData, at: HabitVC.cellCount)
    }
}

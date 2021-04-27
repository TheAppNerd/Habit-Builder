//
//  AddHabitVC.swift
//  Habits
//
//  Created by Alexander Thompson on 26/4/21.
//

import UIKit

class AddHabitVC: UIViewController {

    let habitNameLabel = BodyLabel(textInput: "Name:", textAlignment: .center, fontSize: 20)
    let notesLabel = BodyLabel(textInput: "Notes:", textAlignment: .center, fontSize: 20)
    let colorLabel = BodyLabel(textInput: "Color", textAlignment: .center, fontSize: 20)
    let dailyNumberLabel = BodyLabel(textInput: "Daily Number", textAlignment: .center, fontSize: 20)
    let reminderLabel = BodyLabel(textInput: "Set Reminder?", textAlignment: .center, fontSize: 20)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureBarButtons()
    }
    
    func configureBarButtons() {
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissVC))
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveHabit))
        
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = saveButton
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        title = "Add Habit"
        
        view.addSubview(habitNameLabel)
        view.addSubview(notesLabel)
        view.addSubview(colorLabel)
        view.addSubview(dailyNumberLabel)
        view.addSubview(reminderLabel)
        
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
            
            colorLabel.topAnchor.constraint(equalTo: notesLabel.bottomAnchor, constant: padding),
            colorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            colorLabel.widthAnchor.constraint(equalToConstant: 80),
            colorLabel.heightAnchor.constraint(equalToConstant: padding),
            
            dailyNumberLabel.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: padding),
            dailyNumberLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            dailyNumberLabel.widthAnchor.constraint(equalToConstant: 80),
            dailyNumberLabel.heightAnchor.constraint(equalToConstant: padding),
            
            reminderLabel.topAnchor.constraint(equalTo: dailyNumberLabel.bottomAnchor, constant: padding),
            reminderLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            reminderLabel.widthAnchor.constraint(equalToConstant: 80),
            reminderLabel.heightAnchor.constraint(equalToConstant: padding)
        ])
    }

    @objc func dismissVC() {
        dismiss(animated: true)
    }

    @objc func saveHabit() {
        //enter functionality to save data here and pass it back to home page
    }
}

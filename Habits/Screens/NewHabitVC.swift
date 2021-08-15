//
//  NewHabitVC.swift
//  Habits
//
//  Created by Alexander Thompson on 13/8/21.
//

import UIKit

class NewHabitVC: UITableViewController {
    
    var textFieldArray = [UITextField]()
    var colors = [CGColor]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        configure()
        
    }

    private func registerCells() {
        tableView.register(HabitNameCell.self, forCellReuseIdentifier: HabitNameCell.reuseID)
        tableView.register(HabitFrequencyCell.self, forCellReuseIdentifier: HabitFrequencyCell.reuseID)
        tableView.register(IconCell.self, forCellReuseIdentifier: IconCell.reuseID)
        tableView.register(ReminderCell.self, forCellReuseIdentifier: ReminderCell.reuseID)
        tableView.register(ColorCell.self, forCellReuseIdentifier: ColorCell.reuseID)
        tableView.register(DeleteCell.self, forCellReuseIdentifier: DeleteCell.reuseID)
    }
    
    private func configure() {
        tableView.allowsSelection = false
        title = "Add Habit"
        tableView.separatorStyle = .none
    }
    
    func reloadTableView() {
        reloadTableView()
    }
    
    private func configureBarButtons() {
         let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissVC))
//         let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveHabit))
         navigationItem.leftBarButtonItem = cancelButton
//         navigationItem.rightBarButtonItem = saveButton
     }
    
    @objc func dismissVC() {
        let destVC = UINavigationController(rootViewController: HabitVC())
        destVC.modalPresentationStyle = .fullScreen
        present(destVC, animated: true)
    }
    
    func saveHabit() {
        
        
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
            textFieldArray.append(cell.nameTextField)
            cell.nameTextField.delegate = self
            return cell
            
        case 1: let cell = tableView.dequeueReusableCell(withIdentifier: HabitFrequencyCell.reuseID, for: indexPath) as! HabitFrequencyCell
            return cell
            
        case 2: let cell = tableView.dequeueReusableCell(withIdentifier: ColorCell.reuseID, for: indexPath) as! ColorCell
            cell.buttonArray[0].sendActions(for: .touchUpInside)
            for (index, button) in cell.buttonArray.enumerated() {
                if button.isSelected == true {
                    colors = cell.gradientArray[index]
                    button.sendActions(for: .touchUpInside)
                }
            }
            return cell
            
        case 3: let cell = tableView.dequeueReusableCell(withIdentifier: IconCell.reuseID, for: indexPath) as! IconCell
            cell.colors = colors
            return cell
        
            
        case 4: let cell = tableView.dequeueReusableCell(withIdentifier: ReminderCell.reuseID, for: indexPath) as! ReminderCell
            cell.colors = colors
            return cell
            
        case 5: let cell = tableView.dequeueReusableCell(withIdentifier: DeleteCell.reuseID, for: indexPath) as! DeleteCell
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
        textFieldArray[0].resignFirstResponder()
        return true
    }
}

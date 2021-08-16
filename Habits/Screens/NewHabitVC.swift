//
//  NewHabitVC.swift
//  Habits
//
//  Created by Alexander Thompson on 13/8/21.
//

import UIKit

class NewHabitVC: UITableViewController, reloadTableViewDelegate {
    
    var textFieldArray = [UITextField]()
    var frequency = 1
    var colors = [CGColor]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        configure()
        configureBarButtons()
    }

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
    
    func reloadTableView() {
        tableView.reloadData()
    }
    
    private func configureBarButtons() {
        let deleteButton = UIBarButtonItem(image: UIImage(systemName: "trash.fill"), style: .done, target: self, action: #selector(deleteHabit))
         navigationItem.rightBarButtonItem = deleteButton
     }
    
    @objc func dismissVC() {
        let destVC = UINavigationController(rootViewController: HabitVC())
        destVC.modalPresentationStyle = .fullScreen
        present(destVC, animated: true)
    }
    
    func saveHabit() {
        
        
    }
    
    @objc func deleteHabit() {
        let deleteAlert = UIAlertController(title: "Delete Habit?", message: "Are you sure you want to delete this? It cannot be recovered.", preferredStyle: .alert)
        deleteAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel , handler: { UIAlertAction in
        
        }))
        deleteAlert.addAction(UIAlertAction(title: "Delete", style: .default, handler: { UIAlertAction in
           //where do i need to delete. core data here.
            let destVC = UINavigationController(rootViewController: HabitVC())
            destVC.modalPresentationStyle = .fullScreen
            
            self.present(destVC, animated: true)
            
        }))
        present(deleteAlert, animated: true, completion: nil)
        
    }
    
    func saveCoreDataHabit() {
        let newHabit = HabitCoreData(context: CoreDataFuncs.context)
        newHabit.habitName = textFieldArray[0].text
        newHabit.frequency = Int16(frequency)
        
        
    }
    
    @objc func saveButtonPressed() {
      
        guard textFieldArray[0].text != "" else {
            textFieldArray[0].layer.borderWidth = 2
            return
        }
        
        textFieldArray[0].layer.borderWidth = 0
        
        
        
    }
    
    @objc func positiveButtonPressed() {
        if frequency < 7 {
            frequency += 1
        }
        UIView.performWithoutAnimation {
            self.tableView.reloadSections([1], with: .none)
          
        }
    }
    
    @objc func negativeButtonPressed() {
        if frequency > 1 {
            frequency -= 1
        }
        UIView.performWithoutAnimation {
            self.tableView.reloadSections([1], with: .none)
        
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
            textFieldArray.append(cell.nameTextField)
            cell.nameTextField.delegate = self
            return cell
            
        case 1: let cell = tableView.dequeueReusableCell(withIdentifier: HabitFrequencyCell.reuseID, for: indexPath) as! HabitFrequencyCell
            cell.frequencyLabel.text = "\(frequency)"
            cell.negativeButton.addTarget(self, action: #selector(negativeButtonPressed), for: .touchUpInside)
            cell.positiveButton.addTarget(self, action: #selector(positiveButtonPressed), for: .touchUpInside)
            return cell
            
        case 2: let cell = tableView.dequeueReusableCell(withIdentifier: ColorCell.reuseID, for: indexPath) as! ColorCell
            cell.delegate = self
            colors = cell.color
            return cell
            
        case 3: let cell = tableView.dequeueReusableCell(withIdentifier: IconCell.reuseID, for: indexPath) as! IconCell
            cell.colors = colors
            
            for button in cell.buttonArray {
                if button.isSelected == true {
                    button.colors = colors
                    button.sendActions(for: .touchUpInside)
                }
            }
            
            return cell
        
            
        case 4: let cell = tableView.dequeueReusableCell(withIdentifier: ReminderCell.reuseID, for: indexPath) as! ReminderCell
            cell.colors = colors
            for button in cell.buttonArray {
                if button.isSelected == true {
                    button.colors = colors
                    button.sendActions(for: .touchUpInside)
                    button.sendActions(for: .touchUpInside)
                }
            }
            cell.colors = colors
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
        textFieldArray[0].resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textFieldArray[0].layer.borderWidth = 0
    }
}

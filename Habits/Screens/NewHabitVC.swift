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
    
    var textFieldArray = [UITextField]()
    var frequency = 1
    var colors = [CGColor]()
    var colorIndex = Int()
    var iconString = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCoreData()
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
    
    private func configureBarButtons() {
        let deleteButton = UIBarButtonItem(image: UIImage(systemName: "trash.fill"), style: .done, target: self, action: #selector(deleteHabit))
         navigationItem.rightBarButtonItem = deleteButton
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
           //where do i need to delete. core data here.
            let destVC = UINavigationController(rootViewController: HabitVC())
            destVC.modalPresentationStyle = .fullScreen
            
            self.present(destVC, animated: true)
            
        }))
        present(deleteAlert, animated: true, completion: nil)
    }
    
    func createCoreDataHabit() {
        let newHabit = HabitCoreData(context: context)
        newHabit.habitName = textFieldArray[0].text
        newHabit.frequency = Int16(frequency)
        newHabit.iconString = iconString
        newHabit.habitGradientIndex = Int16(colorIndex)
        habitArray.append(newHabit)
    }
    
    
//    func getYear() -> Int {
//        let today = Date()
//        let calendar = Calendar(identifier: .gregorian)
//        let year = calendar.component(.year, from: today)
//
//        return year
//    }
    
    @objc func saveButtonPressed() {
      
        guard textFieldArray[0].text != "" else {
            textFieldArray[0].layer.borderWidth = 2
            return
        }
        textFieldArray[0].layer.borderWidth = 0
        createCoreDataHabit()
        saveCoreData()
//        HabitDetailsVC.chartYears[getYear()] = [0,0,0,0,0,0,0,0,0,0,0,0]
//        HabitDetailsVC.chartYears[getYear()-1] = [0,0,0,0,0,0,0,0,0,0,0,0]
        let destVC = UINavigationController(rootViewController: HabitVC())
                destVC.modalPresentationStyle = .fullScreen
                present(destVC, animated: true)
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
            for (index, button) in cell.buttonArray.enumerated() {
                if button.isSelected == true {
                colorIndex = index
                    print(index)
                }
            }
            colors = cell.color
            return cell
            
        case 3: let cell = tableView.dequeueReusableCell(withIdentifier: IconCell.reuseID, for: indexPath) as! IconCell
            
            cell.colors = colors
            cell.delegate = self
            for (index, button) in cell.buttonArray.enumerated() {
                if button.isSelected == true {
                    button.sendActions(for: .touchUpInside)
                    button.colors = colors
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

//MARK: - Protocol Extension

extension NewHabitVC: reloadTableViewDelegate, passIconData {
    func passIconData(iconString: String) {
        self.iconString = iconString
        print(self.iconString)
    }
    
    
    func reloadTableView() {
        tableView.reloadData()
    }
    
    
}


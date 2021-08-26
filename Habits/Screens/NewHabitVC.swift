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
    
    var cellTag = Int()
    var nameArray = [UITextField]()
    var name = String()
    var frequency = 1
    var colors = [CGColor]()
    var colorIndex = Int()
    var iconString = String()
    var dayArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCoreData()
        loadData()
        registerCells()
        configure()
        configureBarButtons()
       dismissKeyboard()
    }
    
    func loadData() {
        if cellTag < habitArray.count {
            let habit = habitArray[cellTag]
            frequency = Int(habit.frequency)
            colorIndex = Int(habit.habitGradientIndex)
            colors = GradientArray.array[colorIndex]
            iconString = habit.iconString ?? ""
        }
    }

    // arrange funcs in same order they are called in viewdidload
    
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
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissVC))
        
        let deleteButton = UIBarButtonItem(image: UIImage(systemName: "trash.fill"), style: .done, target: self, action: #selector(deleteHabit))
        navigationItem.leftBarButtonItem = cancelButton
         navigationItem.rightBarButtonItem = deleteButton
     }
    
    func dismissKeyboard() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    
    
    @objc func dismissVC() {
        let destVC = UINavigationController(rootViewController: HabitVC())
        destVC.modalPresentationStyle = .fullScreen
        print("caencelled")
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
            let habit = self.habitArray[self.cellTag]
            self.context.delete(habit)
            self.habitArray.remove(at: self.cellTag)
            self.saveCoreData()
            self.present(destVC, animated: true)
            
        }))
        if cellTag < habitArray.count {
        present(deleteAlert, animated: true, completion: nil)
        }
    }
    
    func createCoreDataHabit() {
        if cellTag >= habitArray.count {
        let newHabit = HabitCoreData(context: context)
        newHabit.habitName = name
        newHabit.frequency = Int16(frequency)
        newHabit.iconString = iconString
        newHabit.habitGradientIndex = Int16(colorIndex)
        newHabit.habitCreated = true
        habitArray.append(newHabit)
        } else if cellTag < habitArray.count {
             let oldHabit = habitArray[cellTag]
           oldHabit.habitName = name
           oldHabit.frequency = Int16(frequency)
           oldHabit.iconString = iconString
           oldHabit.habitGradientIndex = Int16(colorIndex)
        }
    }
    
    
    @objc func saveButtonPressed() {
      
        guard name != "" else {
            nameArray[0].layer.borderWidth = 2
            return
        }
        nameArray[0].layer.borderWidth = 0
        createCoreDataHabit()
        saveCoreData()
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
            cell.nameTextField.delegate = self
            nameArray.append(cell.nameTextField) // is this still needed?
            if cellTag < habitArray.count {
            cell.nameTextField.text = habitArray[cellTag].habitName ?? ""
            }
    
            return cell
            
        case 1: let cell = tableView.dequeueReusableCell(withIdentifier: HabitFrequencyCell.reuseID, for: indexPath) as! HabitFrequencyCell
            cell.frequencyLabel.text = "\(frequency)"
            cell.negativeButton.addTarget(self, action: #selector(negativeButtonPressed), for: .touchUpInside)
            cell.positiveButton.addTarget(self, action: #selector(positiveButtonPressed), for: .touchUpInside)
            return cell
            
        case 2: let cell = tableView.dequeueReusableCell(withIdentifier: ColorCell.reuseID, for: indexPath) as! ColorCell
            cell.delegate = self
//            for (index, button) in cell.buttonArray.enumerated() {
//                if index == colorIndex {
//                    button.sendActions(for: .touchUpInside)
//                }
//            }
        
            return cell
            
        case 3: let cell = tableView.dequeueReusableCell(withIdentifier: IconCell.reuseID, for: indexPath) as! IconCell
            cell.delegate = self
            cell.colors = colors
            return cell
            
        case 4: let cell = tableView.dequeueReusableCell(withIdentifier: ReminderCell.reuseID, for: indexPath) as! ReminderCell
            cell.colors = colors
            cell.delegate = self
            

                //set array to 0 every button press. then get index of selected buttons, append to array and toggle them again.
            
            
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
        name = textField.text ?? ""
     textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        name = textField.text ?? ""
        print("did end editing")
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
       textField.layer.borderWidth = 0
    }
}

//MARK: - Protocol Extension

//rename protocols to resemble cell names
extension NewHabitVC: reloadTableViewDelegate, passIconData, passDayData {
   
    func passDayData(dayArray: [String]) {
        self.dayArray = dayArray
    }
    
    func reloadTableView(colors: [CGColor], colorIndex: Int) {
        self.colors = colors
        self.colorIndex = colorIndex
        tableView.reloadRows(at: [[3,0], [4,0]], with: .none)
    }

    
    func passIconData(iconString: String) {
        self.iconString = iconString
    }
}


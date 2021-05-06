//
//  HabitVC.swift
//  Habits
//
//  Created by Alexander Thompson on 26/4/21.
//

import UIKit

class HabitVC: UIViewController {
    
    let tableView = UITableView()
    
    var habitName: String = ""
    var dailyNumber: String = ""
    static var cellCount = 1
    var habitData = HabitData()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addHabitPressed))
        let helpButton = UIBarButtonItem(image: UIImage(systemName: "questionmark"), style: .plain, target: self, action: #selector(helpButtonPressed))
        
        navigationItem.rightBarButtonItems = [addButton, helpButton]
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.register(HabitCell.self, forCellReuseIdentifier: HabitCell.reuseID)
        tableView.separatorStyle = .none

    }
    
    
    @objc func addHabitPressed() {
        HabitArray.habitCreated = false
        
        navigationController?.pushViewController(AddHabitVC(), animated: true)

    }
    
    @objc func helpButtonPressed() {
        //enter functionality for help screen popup
    }
    
    @objc func completePressed(_ sender: UIButton) {
        let buttonCount = HabitArray.Array[sender.tag].currentDailyCount!
        let totalCount = Int(HabitArray.Array[sender.tag].completionCount ?? "")!
        
        if buttonCount < totalCount {
        HabitArray.Array[sender.tag].currentDailyCount! += 1
        tableView.reloadData()
            
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            let dateString = formatter.string(from: Date())
            
           
            
            
            if !HabitArray.dateArray.contains(dateString) {
                HabitArray.dateArray.append(dateString)
            }
          
        }
    
        
        //make an enum for this
        
        if buttonCount == totalCount - 1 {
            sender.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
            tableView.reloadData()
        } else if buttonCount < totalCount {
            sender.setImage(nil, for: .normal)
            tableView.reloadData()
        }
            }
    
    @objc func reducePressed(_ sender: UIButton) {
        let buttonCount = HabitArray.Array[sender.tag].currentDailyCount!
       
        if buttonCount > 0 {
        HabitArray.Array[sender.tag].currentDailyCount! -= 1
        tableView.reloadData()
            
            //implement a button to remove checkmark
    }
}
    func refresh() {
        tableView.reloadData()
    }


}
extension HabitVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HabitVC.cellCount - 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HabitCell.reuseID) as!HabitCell
        
        let dataIndex = HabitArray.Array[indexPath.row]
    
        cell.completionButton.addTarget(self, action: #selector(completePressed), for: .touchUpInside)
        cell.reduceButton.addTarget(self, action: #selector(reducePressed), for: .touchUpInside)
        cell.habitName.text = dataIndex.habitName
        cell.streakCount.text = "Current Streak: 12 days"
        cell.completionCount.text = "Daily Target: \(dataIndex.currentDailyCount ?? 0) out of \(dataIndex.completionCount!)"
        cell.completionButton.backgroundColor = dataIndex.buttonColor
        cell.completionButton.tag = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = HabitDetailsVC()
        vc.cellTag = indexPath.row
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
}


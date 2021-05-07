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
            HabitArray.Array[sender.tag].progressCount! += (1.0 / Float(totalCount))
            tableView.reloadData()
        }
        
        let today = Calendar.current.startOfDay(for: Date())
        if !DateArray.dates.contains(today) {
        DateArray.dates.append(today)
        
        }
        print(DateArray.dates)

        //make an enum for this
        
            }
    
    @objc func reducePressed(_ sender: UIButton) {
        let buttonCount = HabitArray.Array[sender.tag].currentDailyCount!
        let totalCount = Int(HabitArray.Array[sender.tag].completionCount ?? "")!
       
        if buttonCount > 0 {
        HabitArray.Array[sender.tag].currentDailyCount! -= 1
        HabitArray.Array[sender.tag].progressCount! -= (1.0 / Float(totalCount))
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
        cell.completionCount.text = "Daily Target: \(dataIndex.currentDailyCount ?? 0) out of \(dataIndex.completionCount!)"
        cell.completionButton.tintColor = dataIndex.buttonColor
        cell.completionButton.tag = indexPath.row
        cell.progressView.progressTintColor = dataIndex.buttonColor
        UIView.animate(withDuration: 1.0) {
            cell.progressView.setProgress(dataIndex.progressCount!, animated: true)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = HabitDetailsVC()
        vc.cellTag = indexPath.row
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
}


//
//  HabitVC.swift
//  Habits
//
//  Created by Alexander Thompson on 26/4/21.
//

import UIKit

class HabitVC: UIViewController {
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addHabitPressed))
        let helpButton = UIBarButtonItem(image: UIImage(systemName: "questionmark"), style: .plain, target: self, action: #selector(helpButtonPressed))
        
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.rowHeight = 80 //refactor this figure
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HabitCell.self, forCellReuseIdentifier: HabitCell.reuseID)

    }
    
    
    @objc func addHabitPressed() {
        //enter functionality to push through to habit creation screen here.
    }
    
    @objc func helpButtonPressed() {
        //enter functionality for help screen popup
    }
}

extension HabitVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HabitCell.reuseID) as!HabitCell
        
        return cell
    }
    
    
    
}

//
//  HabitDetailsVC.swift
//  Habits
//
//  Created by Alexander Thompson on 2/5/21.
//

import UIKit

class HabitDetailsVC: UIViewController {

    //implement calendar layout here
    
    var cellTag: Int = 0
    var habitData = HabitData()
    var addHabitVC = AddHabitVC()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureBarButtons()
        self.tabBarController?.tabBar.isHidden = true
    }
    
    private func configureBarButtons() {
        let backButton = UIBarButtonItem(barButtonSystemItem: .rewind, target: self, action: #selector(goBack))
        let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editHabit))
        
        navigationItem.leftBarButtonItem = backButton
        navigationItem.rightBarButtonItem = editButton
        
    }
 
    private func configureViewController() {
        view.backgroundColor = .systemBackground
    }

    @objc func goBack() {
        navigationController?.pushViewController(HabitVC(), animated: true)
    }
    
    @objc func editHabit() {
        HabitArray.habitCreated = true
        addHabitVC.cellTag = cellTag
        let destVC = UINavigationController(rootViewController: AddHabitVC())
        destVC.modalPresentationStyle = .fullScreen
        present(destVC, animated: true)
    }
}

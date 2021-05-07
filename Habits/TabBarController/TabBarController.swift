//
//  TabBarController.swift
//  Habits
//
//  Created by Alexander Thompson on 26/4/21.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [habitScreen(), testScreen()]
    }
    
    
    func habitScreen() -> UINavigationController {
        let habitVC = HabitVC()
        habitVC.title = "Habits"
        habitVC.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 0) //change the system item image
        return UINavigationController(rootViewController: habitVC)
        
    }
    
    func testScreen() -> UINavigationController {
        let testView = TestVC()
        testView.view.backgroundColor = .systemBackground
        testView.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 1)
        return UINavigationController(rootViewController: testView)
        
    }

//    func summaryScreen() -> UINavigationController {
//
//
//    }
//
//
//    func settingScreen() -> UINavigationController {
//
//
//    }
    
    
    
}

//
//  AboutViewController.swift
//  Habits
//
//  Created by Alexander Thompson on 24/8/21.
//

import UIKit

class AboutViewController: UIViewController {

    let iconImage = UIImageView()
    let versionLabel = UILabel()
    let nameLabel = UILabel()
    let tableView = UITableView()
    
    let iconArray = ["linkedIn", "instagram", "gitHub"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureTableView()
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(MenuTableViewCell.self, forCellReuseIdentifier: MenuTableViewCell.reuseID)
        tableView.separatorStyle = .none
        tableView.rowHeight = 40
        tableView.backgroundColor = .tertiarySystemBackground
        tableView.bounces = false
        tableView.layer.cornerRadius = 10
    }

    private func configure() {
        view.backgroundColor = .systemBackground
        iconImage.image = UIImage(systemName: "swift")
        iconImage.translatesAutoresizingMaskIntoConstraints = false
        
        versionLabel.text = "Habits - Version \(UIApplication.appVersion!)"
        versionLabel.translatesAutoresizingMaskIntoConstraints = false
        versionLabel.textAlignment = .center
        
        nameLabel.text = "Made by Alex Thompson"
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.textAlignment = .center
        
        view.addSubviews(iconImage, versionLabel, nameLabel, tableView)
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
        
            iconImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            iconImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3),
            iconImage.heightAnchor.constraint(equalTo: iconImage.widthAnchor),
            iconImage.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -view.frame.size.height / 3.5),
            iconImage.bottomAnchor.constraint(equalTo: versionLabel.topAnchor, constant: -padding),
            
            versionLabel.topAnchor.constraint(equalTo: iconImage.bottomAnchor, constant: padding),
            versionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            versionLabel.widthAnchor.constraint(equalTo: iconImage.widthAnchor, multiplier: 2),
            versionLabel.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: -padding),
            
            nameLabel.topAnchor.constraint(equalTo: versionLabel.bottomAnchor, constant: padding),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.widthAnchor.constraint(equalTo: iconImage.widthAnchor, multiplier: 2),
            nameLabel.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: -padding),
            
            tableView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: padding),
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.widthAnchor.constraint(equalTo: iconImage.widthAnchor, multiplier: 2),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    
    
}
//MARK: - UITableViewDelegate, UITableViewDataSource
extension AboutViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 1: return 4
        case 2: return 4
        default:
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MenuTableViewCell.reuseID) as! MenuTableViewCell
        if indexPath[0] == 0 {
            cell.cellImage.image = UIImage(named: iconArray[indexPath.row])
        } else {
        cell.cellImage.image = UIImage(systemName: "swift")
        }
        cell.cellLabel.text = "Test"
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "Follow Me"
        case 1: return "Special Thanks"
        default: return ""
        }
    }
  
    
    
    
}

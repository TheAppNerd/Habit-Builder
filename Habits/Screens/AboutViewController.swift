//
//  AboutViewController.swift
//  Habits
//
//  Created by Alexander Thompson on 24/8/21.
//

import UIKit

class AboutViewController: UIViewController {
    
    let iconImage       = UIImageView()
    let versionLabel    = UILabel()
    let nameLabel       = UILabel()
    let tableView       = UITableView()
    let topGradientView = UIView()
    
    let iconArray     = ["linkedIn", "Instagram", "GitHub"]
    let usernameArray = [SocialMedia.linkedInUsername, SocialMedia.instagramUsername, SocialMedia.githubUsername]
    
    let thanksArray   = ["FSCalendar", "FlatIcon", "Angela Yu", "Sean Allen"]
    let urlArray      = [SocialMedia.fSCalendarURL, SocialMedia.flatIconURL, SocialMedia.appBreweryURL, SocialMedia.seanAllenURL]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureTableView()
        
        if #available(iOS 15.0, *) {
            UITableView.appearance().sectionHeaderTopPadding = CGFloat(0)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame.size.height = tableView.contentSize.height
        iconImage.layer.cornerRadius  = iconImage.frame.size.width / 2
        
    }
    
    private func configureTableView() {
        
        tableView.delegate           = self
        tableView.dataSource         = self
        tableView.separatorStyle     = .none
        tableView.rowHeight          = 50
        tableView.backgroundColor    = .secondarySystemBackground
        tableView.bounces            = false
        tableView.layer.cornerRadius = 10
        tableView.frame.size.height  = tableView.contentSize.height
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(MenuTableViewCell.self, forCellReuseIdentifier: MenuTableViewCell.reuseID)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        topGradientView.addGradient(colors: Gradients().darkBlueGradient)
    }
    
    private func configure() {
        
        topGradientView.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        iconImage.image               = UIImage(named: "habitIcon")

        iconImage.layer.masksToBounds = true
        iconImage.translatesAutoresizingMaskIntoConstraints = false
        
        versionLabel.text             = " Habits - Version \(UIApplication.appVersion!)  "
        versionLabel.textAlignment    = .center
        versionLabel.translatesAutoresizingMaskIntoConstraints = false
        versionLabel.backgroundColor = .white
        versionLabel.layer.cornerRadius = 10
        versionLabel.layer.masksToBounds = true
        versionLabel.sizeToFit()
        versionLabel.textColor = .black
        
        nameLabel.text                = " Made by Alex Thompson  "
        nameLabel.textAlignment       = .center
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.backgroundColor = .white
        nameLabel.layer.cornerRadius = 10
        nameLabel.layer.masksToBounds = true
        nameLabel.sizeToFit()
        nameLabel.textColor = .black
        
        view.addSubviews(topGradientView ,iconImage, versionLabel, nameLabel, tableView)
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            
            topGradientView.topAnchor.constraint(equalTo: view.topAnchor),
            topGradientView.widthAnchor.constraint(equalTo: view.widthAnchor),
            topGradientView.heightAnchor.constraint(equalToConstant: view.frame.size.height / 2.5),
            
            iconImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            iconImage.heightAnchor.constraint(equalTo: iconImage.widthAnchor),
            iconImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3),
            iconImage.bottomAnchor.constraint(equalTo: versionLabel.topAnchor, constant: -padding),
            
            versionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            versionLabel.topAnchor.constraint(equalTo: iconImage.bottomAnchor, constant: padding),
            versionLabel.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: -padding),
            versionLabel.heightAnchor.constraint(equalToConstant: 30),
            
            
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: versionLabel.bottomAnchor, constant: padding),
            nameLabel.bottomAnchor.constraint(equalTo: topGradientView.bottomAnchor, constant: -padding),
            nameLabel.heightAnchor.constraint(equalToConstant: 30),
            
            
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.topAnchor.constraint(equalTo: topGradientView.bottomAnchor, constant: padding * 2),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
        ])
    }
    
    func loadInstagram() {
        guard let instagram = URL(string: SocialMedia.instagramURL) else { return }
        UIApplication.shared.open(instagram)
    }
    
    func loadGithub() {
        guard let gitHub = URL(string: SocialMedia.githubURL) else { return }
        UIApplication.shared.open(gitHub)
    }
    
    func loadLinkedIn() {
        guard let linkedIn = URL(string: SocialMedia.linkedInURL) else { return }
        UIApplication.shared.open(linkedIn)
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
            
            cell.cellLabel.text = usernameArray[indexPath.row]
            cell.cellImage.image = UIImage(named: iconArray[indexPath.row])
            
        } else {
            cell.cellImage.image = UIImage(systemName: "heart.circle")?.addTintGradient(colors: GradientArray.array[indexPath.row])
            cell.cellLabel.text = thanksArray[indexPath.row]
        }
        
        cell.cellLabel.font = UIFont.systemFont(ofSize: 12)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath[0] == 0 {
            switch indexPath.row {
            case 0: loadLinkedIn()
            case 1: loadInstagram()
            case 2: loadGithub()
            default:
                print("Error")
            }
        }
        
        if indexPath[0] == 1 {
            if let url = URL(string: urlArray[indexPath.row]) {
                UIApplication.shared.open(url)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
    
}

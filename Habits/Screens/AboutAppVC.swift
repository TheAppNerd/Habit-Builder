//
//  AboutViewController.swift
//  Habits
//
//  Created by Alexander Thompson on 24/8/21.
//

import UIKit

class AboutAppVC: UIViewController {
    
    let iconImage       = UIImageView()
    let versionLabel    = UILabel()
    let nameLabel       = UILabel()
    let tableView       = UITableView()
    let topGradientView = UIView()
    
    let iconArray       = ["linkedIn", "Instagram", "GitHub"]
    let usernameArray   = [SocialMedia.linkedInUsername, SocialMedia.instagramUsername, SocialMedia.githubUsername]
    
    let thanksArray     = ["FSCalendar", "FlatIcon", "Angela Yu", "Sean Allen"]
    let urlArray        = [SocialMedia.fSCalendarURL, SocialMedia.flatIconURL, SocialMedia.appBreweryURL, SocialMedia.seanAllenURL]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureTableView()
        tableViewHeaderPadding()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame.size.height = tableView.contentSize.height
        iconImage.layer.cornerRadius  = iconImage.frame.size.width / 2
    }
    
    
    func tableViewHeaderPadding() {
        //to rectify xcode tableview error
        if #available(iOS 15.0, *) {
            UITableView.appearance().sectionHeaderTopPadding = CGFloat(0)
        }
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
        tableView.register(MenuCell.self, forCellReuseIdentifier: MenuCell.reuseID)
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
        
        versionLabel.text                = " Habits - Version \(UIApplication.appVersion!)  "
        versionLabel.textAlignment       = .center
        versionLabel.backgroundColor     = .white
        versionLabel.layer.cornerRadius  = 10
        versionLabel.layer.masksToBounds = true
        versionLabel.textColor           = .black
        versionLabel.sizeToFit()
        versionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        nameLabel.text                   = " Made by Alex Thompson  "
        nameLabel.textAlignment          = .center
        nameLabel.backgroundColor        = .white
        nameLabel.layer.cornerRadius     = 10
        nameLabel.layer.masksToBounds    = true
        nameLabel.textColor              = .black
        nameLabel.sizeToFit()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
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
    
    
    func loadSocialMedia(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        UIApplication.shared.open(url)
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension AboutAppVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 3
        case 1: return 4
        default:
            return 3
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MenuCell.reuseID) as! MenuCell
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
            case 0: loadSocialMedia(urlString: SocialMedia.linkedInURL)
            case 1: loadSocialMedia(urlString: SocialMedia.instagramURL)
            case 2: loadSocialMedia(urlString: SocialMedia.githubURL)
            default:
                print("Error") //create a default error func to utilise across app
            }
        }
        
        if indexPath[0] == 1 {
            loadSocialMedia(urlString: urlArray[indexPath.row])
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

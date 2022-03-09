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
    let detailsView     = UIView()
    
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
    
    
    private func configure() {
//        let count = 0...GradientArray.array.count - 1
//        let random = count.randomElement() ?? 5
//        view.addGradient(colors: GradientArray.array[random])
        view.backgroundColor = .systemBackground
        
        detailsView.backgroundColor = .secondarySystemBackground
        detailsView.layer.cornerRadius = 10
        detailsView.translatesAutoresizingMaskIntoConstraints = false
        
        iconImage.image               = UIImage(named: "IconClear")
        iconImage.backgroundColor = .secondarySystemBackground
        iconImage.layer.masksToBounds = true
        iconImage.translatesAutoresizingMaskIntoConstraints = false
        
        versionLabel.text                = " Habits - Version \(UIApplication.appVersion!)  "
        versionLabel.textAlignment       = .center
        versionLabel.font                = UIFont.systemFont(ofSize: 18, weight: .bold)
        versionLabel.backgroundColor     = .clear
        versionLabel.textColor           = .label
        versionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        nameLabel.text                   = " Made by Alex Thompson  "
        nameLabel.textAlignment          = .center
        nameLabel.font                   = UIFont.systemFont(ofSize: 18, weight: .bold)
        nameLabel.backgroundColor        = .clear
        nameLabel.textColor              = .label
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubviews(detailsView, iconImage, versionLabel, nameLabel, tableView)
        let padding: CGFloat = 5
        
        NSLayoutConstraint.activate([
            detailsView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -view.frame.size.height / 4),
            detailsView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            detailsView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            detailsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            detailsView.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: -20),
            
            iconImage.topAnchor.constraint(equalTo: detailsView.topAnchor, constant: padding * 4),
            iconImage.centerXAnchor.constraint(equalTo: detailsView.centerXAnchor),
            iconImage.heightAnchor.constraint(equalTo: detailsView.heightAnchor, multiplier: 0.5),
            iconImage.widthAnchor.constraint(equalTo: iconImage.heightAnchor),
            //iconImage.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: 5),
            
            nameLabel.leadingAnchor.constraint(equalTo: detailsView.leadingAnchor, constant: padding),
            nameLabel.topAnchor.constraint(equalTo: iconImage.bottomAnchor, constant: padding * 2),
            nameLabel.trailingAnchor.constraint(equalTo: detailsView.trailingAnchor, constant: -padding),
            nameLabel.bottomAnchor.constraint(equalTo: detailsView.bottomAnchor, constant: -padding * 2),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            versionLabel.leadingAnchor.constraint(equalTo: detailsView.leadingAnchor, constant: padding),
//            versionLabel.topAnchor.constraint(equalTo: nameLabel.topAnchor, constant: 10),
            versionLabel.trailingAnchor.constraint(equalTo: detailsView.trailingAnchor, constant: -padding),
            versionLabel.bottomAnchor.constraint(equalTo: detailsView.bottomAnchor, constant: -padding),
            versionLabel.heightAnchor.constraint(equalToConstant: 20),
            
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.topAnchor.constraint(equalTo: detailsView.bottomAnchor, constant: 40),
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

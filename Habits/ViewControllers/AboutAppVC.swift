//
//  AboutViewController.swift
//  Habits
//
//  Created by Alexander Thompson on 24/8/21.
//

import UIKit

class AboutAppVC: UIViewController {
    
    //MARK: - Properties
    
    let iconImage       = UIImageView()
    let versionLabel    = UILabel()
    let nameLabel       = UILabel()
    let tableView       = UITableView()
    let detailsView     = UIView()
    let iconArray       = ["linkedIn", "Instagram", "GitHub"]
    let usernameArray   = [SocialMedia.linkedInUsername, SocialMedia.instagramUsername, SocialMedia.githubUsername]
    let thanksArray     = ["FSCalendar", "FlatIcon", "Angela Yu", "Sean Allen"]
    let urlArray        = [SocialMedia.fSCalendarURL, SocialMedia.flatIconURL, SocialMedia.appBreweryURL, SocialMedia.seanAllenURL]
    
    
    //MARK: - Class Funcs
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        layoutUI()
        configureTableView()
        tableViewHeaderPadding()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame.size.height   = tableView.contentSize.height
        iconImage.layer.cornerRadius  = iconImage.frame.size.width / 2
    }
    
    //MARK: - Functions
    
    ///Rectifies xcode tableview error.
    func tableViewHeaderPadding() {
        if #available(iOS 15.0, *) {
            UITableView.appearance().sectionHeaderTopPadding = CGFloat(0)
        }
    }
    
    
    private func configureTableView() {
        TableViewFuncs().setupTableView(for: .AboutAppVC, using: tableView)
        tableView.delegate           = self
        tableView.dataSource         = self
        tableView.frame.size.height  = tableView.contentSize.height
    }
    
    
    private func configure() {
        view.backgroundColor = BackgroundColors.mainBackGround
        
        detailsView.backgroundColor      = BackgroundColors.secondaryBackground
        detailsView.layer.cornerRadius   = 10
        detailsView.translatesAutoresizingMaskIntoConstraints = false
        
        iconImage.image                  = UIImage(named: "IconClear")
        iconImage.backgroundColor        = BackgroundColors.secondaryBackground
        iconImage.layer.masksToBounds    = true
        iconImage.translatesAutoresizingMaskIntoConstraints = false
        
        if let appVersion = UIApplication.appVersion {
        versionLabel.text                = " Habits - Version \(appVersion)  "
        }
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
    }
    
    
    private func layoutUI() {
        view.addSubviews(detailsView, iconImage, versionLabel, nameLabel, tableView)
        let padding: CGFloat = 5
        
        NSLayoutConstraint.activate([
            detailsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            detailsView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            detailsView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4),
            detailsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            detailsView.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: -20),
            
            iconImage.topAnchor.constraint(equalTo: detailsView.topAnchor, constant: padding * 2),
            iconImage.centerXAnchor.constraint(equalTo: detailsView.centerXAnchor),
            iconImage.heightAnchor.constraint(equalTo: detailsView.heightAnchor, multiplier: 0.5),
            iconImage.widthAnchor.constraint(equalTo: iconImage.heightAnchor),
            
            nameLabel.leadingAnchor.constraint(equalTo: detailsView.leadingAnchor, constant: padding),
            nameLabel.topAnchor.constraint(equalTo: iconImage.bottomAnchor, constant: padding ),
            nameLabel.trailingAnchor.constraint(equalTo: detailsView.trailingAnchor, constant: -padding),
            nameLabel.bottomAnchor.constraint(equalTo: detailsView.bottomAnchor, constant: -padding * 2),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            versionLabel.leadingAnchor.constraint(equalTo: detailsView.leadingAnchor, constant: padding),
            versionLabel.trailingAnchor.constraint(equalTo: detailsView.trailingAnchor, constant: -padding),
            versionLabel.bottomAnchor.constraint(equalTo: detailsView.bottomAnchor, constant: -padding),
            versionLabel.heightAnchor.constraint(equalToConstant: 20),
            
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.topAnchor.constraint(equalTo: detailsView.bottomAnchor, constant: 40),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
        ])
    }
    
    
    func loadSocialMedia(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        UIApplication.shared.open(url)
    }
    
}


//MARK: - TableView - UITableViewDelegate, UITableViewDataSource

extension AboutAppVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 3
        case 1:
            return 4
        default:
            return 3
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MenuCell.reuseID) as! MenuCell
        if indexPath[0] == 0 {
            cell.cellLabel.text  = usernameArray[indexPath.row]
            cell.cellImage.image = UIImage(named: iconArray[indexPath.row])
        } else {
            cell.cellImage.image = UIImage(systemName: "heart.circle")?.addTintGradient(colors: gradients.array[indexPath.row])
            cell.cellLabel.text  = thanksArray[indexPath.row]
        }
        cell.cellLabel.font      = UIFont.systemFont(ofSize: 12)
        cell.accessoryType       = .disclosureIndicator
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Follow Me"
        case 1:
            return "Special Thanks"
        default:
            return ""
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath[0] == 0 {
            switch indexPath.row {
            case 0:
                loadSocialMedia(urlString: SocialMedia.linkedInURL)
            case 1:
                loadSocialMedia(urlString: SocialMedia.instagramURL)
            case 2:
                loadSocialMedia(urlString: SocialMedia.githubURL)
            default:
                print("error")
            }
        }
        
        if indexPath[0] == 1 {
            loadSocialMedia(urlString: urlArray[indexPath.row])
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.size.height / 18
    }
}

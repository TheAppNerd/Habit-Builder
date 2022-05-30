//
//  AboutViewController.swift
//  Habits
//
//  Created by Alexander Thompson on 24/8/21.
//

import UIKit

class AboutAppVC: UIViewController {

    // MARK: - Properties

    let iconImage       = UIImageView()
    let versionLabel    = BoldLabel()
    let nameLabel       = BoldLabel()
    let tableView       = UITableView()
    let detailsView     = UIView()

    // MARK: - Class Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureTableView()
        layoutUI()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame.size.height   = tableView.contentSize.height
        iconImage.layer.cornerRadius  = iconImage.frame.size.width / 2
    }

    // MARK: - Methods

    /// Rectifies xcode tableview error.
    private func tableViewHeaderPadding() {
        if #available(iOS 15.0, *) {
            UITableView.appearance().sectionHeaderTopPadding = CGFloat(0)
        }
    }

    private func configureTableView() {
        tableViewHeaderPadding()
        tableView.setup(for: .aboutAppVC)
        tableView.delegate           = self
        tableView.dataSource         = self
        tableView.frame.size.height  = tableView.contentSize.height
    }

    // TODO: - Clean this up and single responsibility
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

        nameLabel.text                   = " Made by Alex Thompson  "
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

}

// MARK: - TableView - UITableViewDelegate, UITableViewDataSource

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
            cell.cellLabel.text  = SocialMedia.usernameArray[indexPath.row]
            cell.cellImage.image = UIImage(named: SocialMedia.array[indexPath.row])
        } else {
            cell.cellImage.image = UIImage(systemName: "heart.circle")?.addTintGradient(colors: Gradients.array[indexPath.row])
            cell.cellLabel.text  = SocialMedia.thanksNameArray[indexPath.row]
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
            loadSocialMedia(urlString: SocialMedia.thanksURLArray[indexPath.row])
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.size.height / 18
    }
}

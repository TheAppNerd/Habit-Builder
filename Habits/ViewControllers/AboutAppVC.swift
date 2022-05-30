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
    let habitLabel      = BoldLabel()
    let versionLabel    = BodyLabel(textInput: "", textAlignment: .center, fontSize: 12)
    let nameLabel       = BoldLabel()
    let tableView       = UITableView(frame: .zero, style: .insetGrouped)

    // MARK: - Class Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureTableView()
        layoutUI()
    }

    // MARK: - Methods

    private func configureTableView() {
        tableView.setup(for: .aboutAppVC)
        tableView.isScrollEnabled    = false
        tableView.backgroundColor    = BackgroundColors.mainBackGround
        tableView.delegate           = self
        tableView.dataSource         = self
    }

    private func configure() {
        view.backgroundColor = BackgroundColors.mainBackGround

        iconImage.image                = UIImage(named: "IconClear")
        iconImage.translatesAutoresizingMaskIntoConstraints = false

        nameLabel.text                 = "Made with ♥️ by Alex Thompson"

        habitLabel.text = "Habit Builder"
        versionLabel.textColor = .secondaryLabel
        if let appVersion = UIApplication.appVersion {
            versionLabel.text          = "Version \(appVersion)"
        }
    }

    private func layoutUI() {
        view.addSubviews(iconImage, habitLabel, versionLabel, nameLabel, tableView)
        let padding: CGFloat = 5

        NSLayoutConstraint.activate([
            iconImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding * 2),
            iconImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            iconImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3),
            iconImage.heightAnchor.constraint(equalTo: iconImage.widthAnchor),

            habitLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            habitLabel.topAnchor.constraint(equalTo: iconImage.bottomAnchor, constant: padding * 3),
            habitLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            habitLabel.bottomAnchor.constraint(equalTo: versionLabel.topAnchor, constant: -padding),
            habitLabel.heightAnchor.constraint(equalToConstant: 20),

            versionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            versionLabel.topAnchor.constraint(equalTo: habitLabel.bottomAnchor, constant: padding),
            versionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            versionLabel.heightAnchor.constraint(equalToConstant: 20),

            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.topAnchor.constraint(equalTo: versionLabel.bottomAnchor, constant: padding),
            tableView.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: -padding * 4),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),

            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            nameLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding * 4),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
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
        cell.backgroundColor     = BackgroundColors.secondaryBackground
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
        return view.frame.size.height / 19
    }

}

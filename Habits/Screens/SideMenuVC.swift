//
//  MenuView.swift
//  Habits
//
//  Created by Alexander Thompson on 11/5/21.
//

import UIKit
import MessageUI

protocol SettingsPush {
    func pushSettings(row: Int)
}

class SideMenuVC: UIViewController, MFMailComposeViewControllerDelegate {
    
    let emailFeedback = EmailFeedback()
    let tableView = UITableView()
    var delegate: SettingsPush?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    let menuItems  = [ "Share App", "Leave Rating", "Contact Us", "How it Works", "Privacy", "About App", "Dark Mode", "Notifications"]
    var menuImages = [ "square.and.arrow.up", "heart.text.square", "envelope", "questionmark.circle", "hand.raised", "note.text", "moon.circle", "bell.and.waveform"]
    
    
    func configureTableView() {
        tableView.backgroundColor    = .secondarySystemBackground
        tableView.frame              = view.bounds
        tableView.delegate           = self
        tableView.dataSource         = self
        tableView.estimatedRowHeight = 70
        tableView.separatorStyle     = .none
        tableView.register(MenuCell.self, forCellReuseIdentifier: MenuCell.reuseID)
        view.addSubview(tableView)
    }
}


extension SideMenuVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell             = tableView.dequeueReusableCell(withIdentifier: MenuCell.reuseID) as! MenuCell
        if indexPath.row < 7 {
        cell.cellImage.image = UIImage(systemName: menuImages[indexPath.row])?.addTintGradient(colors: GradientArray.array[indexPath.row])
        } else {
            cell.cellImage.image = UIImage(systemName: menuImages[indexPath.row])?.addTintGradient(colors: GradientArray.array[indexPath.row - 7])
        }
        cell.cellLabel.text  = menuItems[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentCell = tableView.cellForRow(at: indexPath)! as! MenuCell
        currentCell.cellImage.bounceAnimation()
        
        
        switch indexPath.row {
        case 0: shareApp()
        case 1: print("hi")
            //let vc = AboutViewController()
//            vc.modalPresentationStyle = .fullScreen
//            self.present(vc, animated: true)
//         https://itunes.apple.com/us/app/appName/idAPP_ID?mt=8&action=write-review
        case 2: emailFeedback.email(vc: self)
        case 3: delegate?.pushSettings(row: 3)
        case 4: guard let url = URL(string: SocialMedia.privacyPolicyURL) else { return }
            UIApplication.shared.open(url)
                        
        case 5: delegate?.pushSettings(row: 5)
        case 6:delegate?.pushSettings(row: 6)
        case 7: if let appSettings = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(appSettings) {
            UIApplication.shared.open(appSettings)
        }
        default: print("error")
            
        }
        //make a func here for push all the vcs so in habitVc can just call the func name.
    }
    
    //MARK: - Share Functionality
    
    func shareApp() {
        //let shareString: String = "Look at this app I use"
        if let urlString = NSURL(string: SocialMedia.appLink) {
            let activityItems = [urlString]

        
        let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        
//        activityViewController.excludedActivityTypes = [UIActivity.ActivityType.markupAsPDF, UIActivity.ActivityType.print, UIActivity.ActivityType.addToReadingList, UIActivity.ActivityType.assignToContact, UIActivity.ActivityType.saveToCameraRoll, UIActivity.ActivityType.openInIBooks]
//
        
        activityViewController.isModalInPresentation = true
        self.present(activityViewController, animated: true, completion: nil)
        }
    }
    
}

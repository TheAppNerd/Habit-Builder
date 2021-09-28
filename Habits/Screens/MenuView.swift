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

class MenuView: UIViewController, MFMailComposeViewControllerDelegate {
    
    let tableView = UITableView()
    var delegate: SettingsPush?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    let menuItems  = [ "Share App", "Leave Rating", "Contact Us", "How it Works", "Privacy", "About App", "Dark Mode"]
    var menuImages = [ "square.and.arrow.up", "heart.text.square", "envelope", "questionmark.circle", "hand.raised", "note.text", "moon.circle"]
    
    
    func configureTableView() {
        tableView.backgroundColor    = .secondarySystemBackground
        tableView.frame              = view.bounds
        tableView.delegate           = self
        tableView.dataSource         = self
        tableView.estimatedRowHeight = 70
        tableView.separatorStyle     = .none
        tableView.register(MenuTableViewCell.self, forCellReuseIdentifier: MenuTableViewCell.reuseID)
        view.addSubview(tableView)
    }
}


extension MenuView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell             = tableView.dequeueReusableCell(withIdentifier: MenuTableViewCell.reuseID) as! MenuTableViewCell
        cell.cellImage.image = UIImage(systemName: menuImages[indexPath.row])?.addTintGradient(colors: GradientArray.array[indexPath.row])
        cell.cellLabel.text  = menuItems[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentCell = tableView.cellForRow(at: indexPath)! as! MenuTableViewCell
        currentCell.cellImage.bounceAnimation()
        
        
        switch indexPath.row {
        case 0: shareApp()
        case 1: print("hi")//let vc = AboutViewController()
//            vc.modalPresentationStyle = .fullScreen
//            self.present(vc, animated: true)
        // https://itunes.apple.com/us/app/appName/idAPP_ID?mt=8&action=write-review
        case 2: sendEmail()
        case 3: delegate?.pushSettings(row: 3)
        case 4: print("TBD") //privacy policy. link to website I make with privacy policy
        case 5: delegate?.pushSettings(row: 5)
        case 6:delegate?.pushSettings(row: 6)
        default: print("error")
            
        }
        //make a func here for push all the vcs so in habitVc can just call the func name.
    }
    
    
    //MARK: - Email Functionality
    func sendEmail() {
        
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["AlexThompsonDevelopment@gmail.com"])
            //mail.setMessageBody("<p>Habits App Feedback</p>", isHTML: true)
            mail.setSubject("Habits App Feedback")
            
            
            present(mail, animated: true)
        } else {
            print("cant email")
            //insert error message for user here.
            
        }
        
    }
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
        // build an alert that email sent
        
    }
    
    //MARK: - Share Functionality
    
    func shareApp() {
        let firstActivityItem: String = "Look at this app I use"
        let secondActivityItem: NSURL = NSURL(string: "HTTP://Google.com")!
        
        let image = UIImage(systemName: "swift")
        
        let activityViewController = UIActivityViewController(activityItems: [firstActivityItem, secondActivityItem, image ], applicationActivities: nil)
        
        activityViewController.excludedActivityTypes = [UIActivity.ActivityType.markupAsPDF, UIActivity.ActivityType.print, UIActivity.ActivityType.addToReadingList, UIActivity.ActivityType.assignToContact, UIActivity.ActivityType.saveToCameraRoll, UIActivity.ActivityType.openInIBooks]
        
        
        activityViewController.isModalInPresentation = true
        self.present(activityViewController, animated: true, completion: nil)
        
    }
    
}

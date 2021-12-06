//
//  EmailFeedback.swift
//  Habits
//
//  Created by Alexander Thompson on 7/12/21.
//

import UIKit
import MessageUI

struct EmailFeedback {
    
    func email(vc: UIViewController) {
            if MFMailComposeViewController.canSendMail() {
                let mail = MFMailComposeViewController()
                mail.mailComposeDelegate = vc as? MFMailComposeViewControllerDelegate
                mail.setToRecipients([SocialMedia.emailAddress])
                mail.setSubject("Habit Builder Feedback")
                vc.present(mail, animated: true)
            } else {
                let emailAlert = UIAlertController(title: "Error", message: "Unable to send email right now. Please ensure you have mail set up on your device", preferredStyle: .alert)
                emailAlert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                vc.present(emailAlert, animated: true)
            }
    }
}


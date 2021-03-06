//
//  SettingsFuncs.swift
//  Habits
//
//  Created by Alexander Thompson on 3/5/2022.
//

import UIKit

struct SettingsFuncs {

    /// Utilises UIActivityViewController to allow user to share app.
    func shareApp(vc: UIViewController) {
        if let urlString = NSURL(string: SocialMedia.appLink) {
            let activityItems = [urlString]
            
            let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
            activityViewController.isModalInPresentation = true
            vc.present(activityViewController, animated: true, completion: nil)
            
        }
    }

    /// Takes user to the app store review section.
    func reviewApp() {
        let urlStr = "\(SocialMedia.appLink)?action=write-review"
        guard let url = URL(string: urlStr), UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url)
    }

    /// Redirects User to privacy policy URL.
    func openPrivacy() {
        guard let url = URL(string: SocialMedia.privacyPolicyURL), UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url)
    }
    
    func pushHowToUse(vc: UIViewController) {
        let how = HowToUseVC()
        vc.show(how, sender: vc)
    }
    
    func pushAbout(vc: UIViewController) {
        let about = AboutAppVC()
        vc.show(about, sender: vc)
    }

    /// Presents Dark Mode Settings over top of current view controller.
    func presentDarkMode(vc: UIViewController) {
        let dark = DarkModeVC()
        dark.modalPresentationStyle = .overCurrentContext
        dark.modalTransitionStyle = .crossDissolve
        vc.present(dark, animated: true)
    }

    /// Redirects users to app settings in phone system settings.
    func openAppSettings() {
        if let appSettings = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(appSettings) {
            UIApplication.shared.open(appSettings)
        }
    }

    /// Utilised from a protocol in SideMenuVC to HabitHomeVC to call funcs from a UINavigationController.
    ///
    /// ```
    /// activateSettings(row: 3, vc: self)
    /// ```
    func activateSettings(row: Int, vc: UIViewController) {
        switch row {
        case 0:
            shareApp(vc: vc)
        case 1:
            reviewApp()
        case 2:
            EmailFeedback().newEmail()
        case 3:
            pushHowToUse(vc: vc)
        case 4:
            openPrivacy()
        case 5:
            pushAbout(vc: vc)
        case 6:
            presentDarkMode(vc: vc)
        case 7:
            openAppSettings()
        default: print("error")
        }
    }
    
}

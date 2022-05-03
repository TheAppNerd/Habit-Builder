//
//  SettingsFuncs.swift
//  Habits
//
//  Created by Alexander Thompson on 3/5/2022.
//

import UIKit

struct SettingsFuncs {
    
    func shareApp(vc: UIViewController) {
        if let urlString = NSURL(string: SocialMedia.appLink) {
            let activityItems = [urlString]
            
            let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
            activityViewController.isModalInPresentation = true
            vc.present(activityViewController, animated: true, completion: nil)
         
        }
    }
    
    func reviewApp() {
        let urlStr = "\(SocialMedia.appLink)?action=write-review"
        guard let url = URL(string: urlStr), UIApplication.shared.canOpenURL(url) else { return }
    }
    
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
    
    func presentDarkMode(vc: UIViewController) {
        let dark = DarkModeVC()
        dark.modalPresentationStyle = .overCurrentContext
        dark.modalTransitionStyle = .crossDissolve
        vc.present(dark, animated: true)
    }
    
    func openAppSettings() {
        if let appSettings = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(appSettings) {
            UIApplication.shared.open(appSettings)
        
    }
}
}

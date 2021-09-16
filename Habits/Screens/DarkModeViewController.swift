//
//  DarkModeViewController.swift
//  Habits
//
//  Created by Alexander Thompson on 23/8/21.
//

import UIKit

class DarkModeViewController: UIViewController {

    let darkModeView = DarkModeView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureButtons()
    }
    
    private func configure() {
        view.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.7)
    
        darkModeView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(darkModeView)
        
        NSLayoutConstraint.activate([
            darkModeView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            darkModeView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            darkModeView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            darkModeView.heightAnchor.constraint(equalTo: darkModeView.widthAnchor)
        ])
    }
    
    func configureButtons() {
        darkModeView.automaticButton.addTarget(self, action: #selector(darkModeValueChanged), for: .touchUpInside)
        darkModeView.lightButton.addTarget(self, action: #selector(darkModeValueChanged), for: .touchUpInside)
        darkModeView.darkButton.addTarget(self, action: #selector(darkModeValueChanged), for: .touchUpInside)
        
        darkModeView.doneButton.addTarget(self, action: #selector(doneButtonPressed), for: .touchUpInside)
    }
    
    @objc func darkModeValueChanged(sender: UIButton) {
        let defaults = UserDefaults.standard
        
        let buttonArray = [darkModeView.automaticButton, darkModeView.lightButton, darkModeView.darkButton]
        for button in buttonArray {
            button.setTitleColor(.secondaryLabel, for: .normal)
            button.layer.borderColor = UIColor.label.cgColor
            button.backgroundColor = .secondarySystemBackground
            //button.layer.borderWidth = 0
        }
        //sender.layer.borderWidth = 1
        sender.backgroundColor = .systemBackground
        sender.setTitleColor(.label, for: .normal)
        var mode = traitCollection.userInterfaceStyle
        switch sender.title(for: .normal) {
        case "Automatic": mode = UITraitCollection.current.userInterfaceStyle
            defaults.set("Automatic", forKey: "darkmode")
        case "Light": mode = UIUserInterfaceStyle.light
            defaults.set("Light", forKey: "darkMode")
        case "Dark": mode = UIUserInterfaceStyle.dark
            defaults.set("Dark", forKey: "darkMode")
        default: mode = UITraitCollection.current.userInterfaceStyle
        }
        UIApplication.shared.windows.forEach { window in
            window.overrideUserInterfaceStyle = mode
    }
    }
    
    @objc func doneButtonPressed() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if touch?.view != darkModeView {
            self.dismiss(animated: true, completion: nil)
        }
    }
        
}

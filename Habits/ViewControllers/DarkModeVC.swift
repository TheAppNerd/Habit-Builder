//
//  DarkModeViewController.swift
//  Habits
//
//  Created by Alexander Thompson on 23/8/21.
//

import UIKit

class DarkModeVC: UIViewController {
    
    //MARK: - Properties
    
    let darkModeView = DarkModeView()
    
    //MARK: - Class Funcs
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureButtons()
        selectCurrentMode()
    }
    
    //MARK: - Functions
    
    private func configure() {
        view.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.7)
        view.addSubview(darkModeView)
        
        NSLayoutConstraint.activate([
            darkModeView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            darkModeView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            darkModeView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            darkModeView.heightAnchor.constraint(equalTo: darkModeView.widthAnchor)
        ])
    }
    
    
    private func configureButtons() {
        darkModeView.deviceButton.addTarget(self, action: #selector(darkModeValueChanged), for: .touchUpInside)
        darkModeView.lightButton.addTarget(self, action: #selector(darkModeValueChanged), for: .touchUpInside)
        darkModeView.darkButton.addTarget(self, action: #selector(darkModeValueChanged), for: .touchUpInside)
        darkModeView.doneButton.addTarget(self, action: #selector(doneButtonPressed), for: .touchUpInside)
    }
    
    ///Selects the correct dark mode button based on what setting is saved in UserDefaults.
    private func selectCurrentMode() {
        let defaults = UserDefaults.standard
        // TODO: - move strings to constants
        switch defaults.object(forKey: darkMode.key) as? String {
        case darkMode.device: darkModeView.deviceButton.sendActions(for: .touchUpInside)
        case darkMode.light: darkModeView.lightButton.sendActions(for: .touchUpInside)
        case darkMode.dark: darkModeView.darkButton.sendActions(for: .touchUpInside)
        case nil: darkModeView.deviceButton.sendActions(for: .touchUpInside)
        default:
            darkModeView.deviceButton.sendActions(for: .touchUpInside)
        }
    }
    
    
    ///When one of the buttons to change dark mode is selected, all the buttons go back to default color scheme while the selected button gets gradeitn color applied. SetDarkMode is then called to actually apply dark mode settings.
    @objc func darkModeValueChanged(sender: GradientButton) {
        sender.bounceAnimation()
        
        let buttonArray = [darkModeView.deviceButton, darkModeView.lightButton, darkModeView.darkButton]
        for button in buttonArray {
            button.setTitleColor(.secondaryLabel, for: .normal)
            button.layer.borderColor = UIColor.label.cgColor
            button.colors = GradientColors.clearGradient
        }
        
        sender.colors = gradients.array[5]
        sender.setTitleColor(.label, for: .normal)
        setDarkMode(to: (sender.titleLabel?.text!)!)
    }
    
    
    /// Saves selected dark mode to UserDefaults and applies that setting across the whole app.
    ///
    /// ```
    /// setDarkMode(to: "Dark")
    /// ```
    /// - Parameter str: The sender button title label when selecting dark mode.
    func setDarkMode(to str: String) {
        let defaults = UserDefaults.standard
        var mode     = traitCollection.userInterfaceStyle
        
        //move key to a constant
        switch str {
        case darkMode.device: mode = UIScreen.main.traitCollection.userInterfaceStyle
            defaults.set(darkMode.device, forKey: darkMode.key)
            
        case darkMode.light: mode = UIUserInterfaceStyle.light
            defaults.set(darkMode.light, forKey: darkMode.key)
            
        case darkMode.dark: mode = UIUserInterfaceStyle.dark
            defaults.set(darkMode.dark, forKey: darkMode.key)
            
        default: mode = UITraitCollection.current.userInterfaceStyle
        }
        UIApplication.shared.windows.forEach { window in
            window.overrideUserInterfaceStyle = mode
        }
    }
    
    
    @objc func doneButtonPressed(sender: UIButton) {
        sender.bounceAnimation()
        self.dismiss(animated: true, completion: nil)
    }
    
    ///Dismisses the view when clicking away from dark mode view.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if touch?.view != darkModeView {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
}

//
//  DarkModeViewController.swift
//  Habits
//
//  Created by Alexander Thompson on 23/8/21.
//

import UIKit

class DarkModeVC: UIViewController {

    // MARK: - Properties

    let darkModeView = DarkModeView()

    // MARK: - Class Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureButtons()
        selectCurrentMode()
    }

    // MARK: - Methods

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

    /// Selects the correct dark mode button based on what setting is saved in UserDefaults.
    private func selectCurrentMode() {
        let defaults = UserDefaults.standard

        switch defaults.object(forKey: DarkModeString.key) as? String {
        case DarkModeString.device:
            darkModeView.deviceButton.sendActions(for: .touchUpInside)
        case DarkModeString.light:
            darkModeView.lightButton.sendActions(for: .touchUpInside)
        case DarkModeString.dark:
            darkModeView.darkButton.sendActions(for: .touchUpInside)
        case nil:
            darkModeView.deviceButton.sendActions(for: .touchUpInside)
        default:
            darkModeView.deviceButton.sendActions(for: .touchUpInside)
        }
    }

    /// When one of the buttons to change dark mode is selected, all the buttons go back to default color scheme while the selected button gets gradeitn color applied. SetDarkMode is then called to actually apply dark mode settings.
    @objc func darkModeValueChanged(sender: GradientButton) {
        sender.bounce()
        let buttonArray = [darkModeView.deviceButton, darkModeView.lightButton, darkModeView.darkButton]
        for button in buttonArray {
            button.setTitleColor(.secondaryLabel, for: .normal)
            button.layer.borderColor = UIColor.label.cgColor
            button.colors = GradientColors.clearGradient
        }

        sender.colors = Gradients.array[5]
        sender.setTitleColor(.label, for: .normal)
        if let darkModeString = sender.titleLabel?.text {
            setDarkMode(to: darkModeString)
        }
    }

    /// Saves selected dark mode to UserDefaults and applies that setting across the whole app.
    ///
    /// ```
    /// setDarkMode(to: "Dark")
    /// ```
    /// - Parameter str: The sender button title label when selecting dark mode.
   private func setDarkMode(to whichMode: String) {
        let defaults = UserDefaults.standard
        var mode     = traitCollection.userInterfaceStyle

        switch whichMode {
        case DarkModeString.device:
            mode = UIScreen.main.traitCollection.userInterfaceStyle
            defaults.set(DarkModeString.device, forKey: DarkModeString.key)

        case DarkModeString.light:
            mode = UIUserInterfaceStyle.light
            defaults.set(DarkModeString.light, forKey: DarkModeString.key)

        case DarkModeString.dark:
            mode = UIUserInterfaceStyle.dark
            defaults.set(DarkModeString.dark, forKey: DarkModeString.key)

        default:
            mode = UITraitCollection.current.userInterfaceStyle
        }
        UIApplication.shared.windows.forEach { window in
            window.overrideUserInterfaceStyle = mode
        }
    }

    @objc func doneButtonPressed(sender: UIButton) {
        sender.bounce()
        self.dismiss(animated: true, completion: nil)
    }

    /// Dismisses the view when clicking away from dark mode view.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if touch?.view != darkModeView {
            self.dismiss(animated: true, completion: nil)
        }
    }

}

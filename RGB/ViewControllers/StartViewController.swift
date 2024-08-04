//
//  StartViewController.swift
//  RGB
//
//  Created by Владислав Резван on 02.08.2024.
//

import UIKit

final class StartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let settingsVC = segue.destination as? SettingsViewController {
            settingsVC.delegate = self
            settingsVC.startViewBackgroundViewColor = view.backgroundColor
        }
    }
    
}


extension StartViewController: SettingsViewControllerDelegate {
    func setupBackgroundColor(red: CGFloat, green: CGFloat, blue: CGFloat) {
        view.backgroundColor = .init(
            red: red,
            green: green,
            blue: blue,
            alpha: 1
        )
    }
    
    
}

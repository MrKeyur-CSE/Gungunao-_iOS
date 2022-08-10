//
//  SettingViewController.swift
//  Gungunaoo
//
//  Created by Keyur Panchal on 10/08/22.
//

import UIKit

final class SettingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGradient()
    }
    
    @IBAction func onClickLogout(_ sender: Any) {
        FirebaseManager.logout()
        UserDefaults.standard.setValue(false, forKey: "login")
        navigationController?.popToRootViewController(animated: true)
    }
}

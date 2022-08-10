//
//  RegistrationViewController.swift
//  Gungunaoo
//
//  Created by Keyur Panchal on 06/08/22.
//

import UIKit

final class RegistrationViewController: UIViewController {
    
    @IBOutlet private weak var firstNameTextField: UITextField!
    @IBOutlet private weak var lastNameTextField: UITextField!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGradient()
    }
    
    @IBAction private func onClickSignUp(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text, email != "", password != "", let firstName = firstNameTextField.text, firstName != "", let lastName = lastNameTextField.text, lastName != "" else {
            let alert = UIAlertController(title: "Fill every filed", message: "", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        FirebaseAuthManager.createUser(firstName: firstName, lastName: lastName, email: email, password: password) { success in
            if success {
                let tabVC = UIStoryboard(name: "Main", bundle: nil).instantiateVC(withIdentifier: TabbarViewController.self)
                UserDefaults.standard.setValue(true, forKey: "login")
                self.pushVC(tabVC)
            } else {
                let alertController = UIAlertController(title: nil, message: "something went wrong", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
}

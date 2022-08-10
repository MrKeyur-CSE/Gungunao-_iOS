//
//  ViewController.swift
//  Gungunaoo
//
//  Created by Keyur Panchal on 2022-07-05.
//

import UIKit

final class ViewController: UIViewController {

    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var notRegisteredLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGradient()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(onClickRegister))
        notRegisteredLbl.isUserInteractionEnabled =  true
        notRegisteredLbl.addGestureRecognizer(tap)
        
        if let isLogin = UserDefaults.standard.value(forKey: "login") as? Bool, isLogin == true {
            let tabVC = UIStoryboard(name: "Main", bundle: nil).instantiateVC(withIdentifier: TabbarViewController.self)
            self.pushVC(tabVC)
        }
    }
    
    @objc private func onClickRegister() {
        let homeVC = UIStoryboard(name: "Main", bundle: nil).instantiateVC(withIdentifier: RegistrationViewController.self)
        self.pushVC(homeVC)
    }

    @IBAction private func onClickSignIn(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text, email != "", password != "" else {
            let alert = UIAlertController(title: "Fill every filed", message: "", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        FirebaseAuthManager.signIn(email: email, pass: password) { success in
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

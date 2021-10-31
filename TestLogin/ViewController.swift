//
//  ViewController.swift
//  TestLogin
//
//  Created by Alexey Khestanov on 27.10.2021.
//

import UIKit

class ViewController: UIViewController {
    
    
    // MARK: - IB Outlets
    @IBOutlet var loginTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var helpLogin: UIButton!
    @IBOutlet var helpPassword: UIButton!
    
    // MARK: - Private properties
    private let login = "Login"
    private let password = "Password"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginTextField.delegate = self
        passwordTextField.delegate = self
    }

    // MARK: - Private funcs

    
    private func showInfo(_ text: String) {
        let alert = UIAlertController(title: "Info", message: text, preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "Close", style: .default)
        alert.addAction(closeAction)
        present(alert, animated: true)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? loggedInViewController,
              let thisLogin = loginTextField.text,
              let thisPassword = passwordTextField.text
        else { return }
        guard let user = userList.users[thisLogin], user.password == thisPassword else {
            showInfo("Invalid Login or Password!")
            passwordTextField.text = ""
            return
        }
        destination.login = thisLogin
    }
    
    override func unwind(for unwindSegue: UIStoryboardSegue, towards subsequentVC: UIViewController) {
        loginTextField.text = ""
        passwordTextField.text = ""
    }
    
    // MARK: IB Actiona

    @IBAction func helpRecoverPassword() {
        guard let login = loginTextField.text, let user = userList.users[login] else {
            showInfo("This login doesn't exist!")
            return
        }
        showInfo("Your password is '\(user.password)' 😎")
    }
    
    @IBAction func helpUserName() {
        let userLogins = Array(userList.users).map {$0.key}
        showInfo("Please choose from: \n" + userLogins.sorted(by: >).joined(separator: "\n"))
    }


}

// MARK: - Navigation

extension ViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    private func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == loginTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            performSegue(withIdentifier: "loginSegue", sender: self)
        }
        return true
    }
    
}



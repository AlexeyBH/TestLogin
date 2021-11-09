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
        guard let destination = segue.destination as? UITabBarController,
              let thisLogin = loginTextField.text,
              let thisPassword = passwordTextField.text,
              let viewControllers = destination.viewControllers
        else { return }
        guard let user = userList.users[thisLogin], user.password == thisPassword else {
            showInfo("Wrong Login or Password!")
            self.passwordTextField.text = ""
            return
        }
        for viewController in viewControllers {
            if let casted = viewController as? ViewControllerWithUserInfo {
                casted.userInfo = user.userInfo
            } else {
                // Четвертый экран имеет тип обычного вью контроллера, то есть тут закрываем
                //performSegue(withIdentifier: "loginSegue", sender: self)
            }
        }
        
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

// MARK: - !!! Вопрос к Никите !!!
// Почему-то эта конструкция у меня не работает

extension ViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    private func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == loginTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            //performSegue(withIdentifier: "loginSegue", sender: self)
        }
        return true
    }
    
}


// Я решил пойти другим путем - переопределил дочерние ViewControllers как новый класс, содержищий в себе
// информацию о пользователе, из которого они будут брать нужные данные при загрузке View.
class ViewControllerWithUserInfo: UIViewController {
    
    var userInfo: SingleUserInfo = .init()

}


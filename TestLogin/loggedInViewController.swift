//
//  loggedInViewController.swift
//  TestLogin
//
//  Created by Alexey Khestanov on 27.10.2021.
//

import UIKit

class loggedInViewController: UIViewController {

    var login: String = ""
    
    @IBOutlet var welcomeMessage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        welcomeMessage.text = "Hello, \(login)!"
    }
    

    @IBAction func closeLoggedInWindow() {
         
    }
    
}

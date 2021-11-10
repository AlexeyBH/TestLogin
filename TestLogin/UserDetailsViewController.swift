//
//  UserDetailsViewController.swift
//  TestLogin
//
//  Created by Alexey Khestanov on 10.11.2021.
//

import UIKit

class UserDetailsViewController: UIViewController {
    
    @IBOutlet var userName: UILabel!
    @IBOutlet var userPhone: UILabel!
    @IBOutlet var userMail: UILabel!
    
    var userInfo: SingleUserInfo!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        userName.text = userInfo.fullName
        userPhone.text = userInfo.phone
        userMail.text = userInfo.email

    }

}

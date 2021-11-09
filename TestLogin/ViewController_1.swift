//
//  ViewController_1.swift
//  TestLogin
//
//  Created by Alexey Khestanov on 31.10.2021.
//

import UIKit

class ViewController_1: ViewControllerWithUserInfo {
    
    @IBOutlet var userFullNameLabel: UILabel!
    @IBOutlet var userEMailLabel: UILabel!
    @IBOutlet var userTelegramLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userFullNameLabel.text = userInfo.fullName
        if let email = userInfo.email {
            userEMailLabel.text = email
        } else {
            userEMailLabel.text = "Почтовый ящик не задан"
        }
        if let telegram = userInfo.telegram{
            userTelegramLabel.text = telegram
        } else {
            userTelegramLabel.text = "Аккаунта в Telegram нет"
        }
        
    }


}

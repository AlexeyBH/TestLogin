//
//  ViewController_2.swift
//  TestLogin
//
//  Created by Alexey Khestanov on 31.10.2021.
//

import UIKit

class ViewController_2: ViewControllerWithUserInfo {
    
    @IBOutlet var userAdressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let adress = userInfo.adress {
            userAdressLabel.text = adress.fullAdress
        } else {
            userAdressLabel.text = "Адрес неизвестен"
        }
    }
    


}

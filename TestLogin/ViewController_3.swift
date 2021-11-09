//
//  ViewController_3.swift
//  TestLogin
//
//  Created by Alexey Khestanov on 31.10.2021.
//

import UIKit

class ViewController_3: ViewControllerWithUserInfo {

    @IBOutlet var userHobbiesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if userInfo.hobbies == [] {
            userHobbiesLabel.text = "Хобби неизвестны"
        } else {
            userHobbiesLabel.text = userInfo.hobbies.joined(separator: "\n")
        }
    }
    



}

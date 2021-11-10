//
//  MyTabBarControllerViewController.swift
//  TestLogin
//
//  Created by Alexey Khestanov on 31.10.2021.
//

import UIKit

class MyTabBarControllerViewController: UITabBarController {
    var userList: UsersInfo = FillUserData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Загружаем данные пользователя в дочерние контроллеры
        guard let viewControllers = self.viewControllers else { return }
        
        for viewController in viewControllers {
            guard let controller = viewController as? UINavigationController else { return }
            guard let item = controller.topViewController as? UserTableViewController else { return }
            item.userList = userList
        }

    }
    
}
    



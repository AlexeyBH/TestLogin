//
//  phoneDetailsTableTableViewController.swift
//  TestLogin
//
//  Created by Alexey Khestanov on 10.11.2021.
//

import UIKit

class phoneDetailsTableViewController: UserTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        userList.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0: return 50.0
        default: return 40.0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "phoneDetails", for: indexPath)
        var content = cell.defaultContentConfiguration()
        let user = userList.asArray[indexPath.section]
        switch indexPath.row {
        case 1: content.secondaryText  = user.phone ?? "не задан"
                content.image = UIImage(named: "Phone")
        case 2: content.secondaryText = user.email ?? "не задана"
                content.image = UIImage(named: "Email")
        default: content.text = user.fullName
        }
        cell.contentConfiguration = content
     
        return cell
    }
    
}

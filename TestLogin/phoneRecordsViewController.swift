//
//  phoneRecordsViewController.swift
//  TestLogin
//
//  Created by Alexey Khestanov on 09.11.2021.
//

import UIKit

class phoneRecordsViewController: UITableViewController {

    var userList: UsersInfo = FillUserData()

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        userList.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "phoneRecord", for: indexPath)
        var content = cell.defaultContentConfiguration()
        let user: SingleUserInfo = userList.asArray[indexPath.section]
        content.text = user.fullName
        cell.contentConfiguration = content
     
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? UserDetailsViewController,
              let indexPath = tableView.indexPathForSelectedRow else { return }
        destination.userInfo = userList.asArray[indexPath.section]
    }
 
}

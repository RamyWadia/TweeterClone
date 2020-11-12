//
//  ExploreController.swift
//  TwitterCopy
//
//  Created by Ramy Atalla on 2020-05-29.
//  Copyright © 2020 Ramy Atalla. All rights reserved.
//

import UIKit

class ExploreController: UITableViewController {
    
    //MARK: - Properties
    private var users = [User]()
    
    //MARK: - Lifecycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchUsers()
    }
    
    //MARK: - Helpers
    
    func fetchUsers() {
        UserService.shared.fechUsers { [weak self] users in
            users.forEach { user in
                self?.users.append(user)
            }
            self?.tableView.reloadData()
        }
    }
    
    //MARK: - Helpers
    
    fileprivate func configureUI() {
        view.backgroundColor = .white
        navigationItem.title = "Explore"
        tableView.register(UserCell.self, forCellReuseIdentifier: UserCell.reuseID)
        tableView.separatorStyle = .none
        tableView.rowHeight = 60
    }
}

extension ExploreController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.reuseID, for: indexPath) as! UserCell
        cell.user = users[indexPath.row]
        return cell
    }
}


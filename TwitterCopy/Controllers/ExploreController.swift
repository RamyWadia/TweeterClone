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
    private var users = [User]() {
        didSet { tableView.reloadData() }
    }
    
    private var filteredUsers = [User]() {
        didSet { tableView.reloadData() }
    }
    
    private var inSearchMood: Bool {
        return searchController.isActive && !searchController.searchBar.text!.isEmpty
    }
    
    let searchController = UISearchController(searchResultsController: nil)
    
    //MARK: - Lifecycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchUsers()
        configureSearchController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    //MARK: - Helpers
    
    func fetchUsers() {
        UserService.shared.fechUsers { users in
            users.forEach { user in
                self.users.append(user)
            }
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
    
    func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search for a user"
        searchController.searchBar.autocapitalizationType = .none
        navigationItem.searchController = searchController
        definesPresentationContext = false
    }
}

//MARK: - TableViewDelegate

extension ExploreController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inSearchMood ? filteredUsers.count : users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.reuseID, for: indexPath) as! UserCell
        cell.user = inSearchMood ? filteredUsers[indexPath.row] : users[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = inSearchMood ? filteredUsers[indexPath.row] : users[indexPath.row]
        let controller = ProfileController(user: user)
        navigationController?.pushViewController(controller, animated: true)
    }
}


//MARK: - UISearchResultsUpdating

extension ExploreController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        filteredUsers = users.filter { $0.username.contains(searchText)}
        tableView.reloadData()
    }
}


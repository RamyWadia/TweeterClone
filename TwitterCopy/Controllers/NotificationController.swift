//
//  NotificationController.swift
//  TwitterCopy
//
//  Created by Ramy Atalla on 2020-05-29.
//  Copyright © 2020 Ramy Atalla. All rights reserved.
//

import UIKit

class NotificationController: UITableViewController {
    
    //MARK: - Properties
    private var notifications = [Notification]() {
        didSet { tableView.reloadData() }
    }
    
    //MARK: - Lifecycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureTableView()
        fetchNotificaitons()
    }
    
    //MARK: - API
    
    func fetchNotificaitons() {
        NotificationService.shared.fetchNotifications { notifications in
            self.notifications = notifications
        }
    }
    
    //MARK: - Helpers
    
    fileprivate func configureUI() {
        view.backgroundColor = .white
        navigationItem.title = "Notification"
    }
    
    fileprivate func configureTableView() {
        tableView.register(NotificationCell.self, forCellReuseIdentifier: NotificationCell.reuseID)
        tableView.rowHeight = 60
        tableView.separatorStyle = .none
        
    }
}

//MARK: - TableViewDelegate

extension NotificationController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NotificationCell.reuseID, for: indexPath) as! NotificationCell
        cell.notification = notifications[indexPath.row]
        return cell
    }
}

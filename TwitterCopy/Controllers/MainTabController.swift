//
//  MainTabController.swift
//  TwitterCopy
//
//  Created by Ramy Atalla on 2020-05-29.
//  Copyright © 2020 Ramy Atalla. All rights reserved.
//

import UIKit
import Firebase

class MainTabController: UITabBarController {

    //MARK: - Properties
    
    let actioButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.backgroundColor = .twitterBlue
        button.setImage(UIImage(named: "new_tweet"), for: .normal)
        button.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        return button
    }()
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
         logUserOut()
        view.backgroundColor = .twitterBlue
         authenticateUserAndConfigureUI()
    }
    
    //MARK: - Selectors
    
    @objc func actionButtonTapped() {
        print(123)
    }
    
    //MARK: - API
    
    func authenticateUserAndConfigureUI() {
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: LoginController())
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true)
            }
        } else {
            configureViewControllers()
            configureUI()
        }
    }
    
    func logUserOut() {
        do {
            try Auth.auth().signOut()
            print("Debug: log user out successfully")
        } catch let error {
            print("Debug: Faild to sign out with desvription \(error.localizedDescription)")
        }
    }
    
    //MARK: - Helpers
    
    fileprivate func configureUI() {
        view.addSubview(actioButton)
        actioButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingBottom: 64, paddingRight: 16, width: 56, height: 56)
        actioButton.layer.cornerRadius = 56 / 2
    }
    
    fileprivate func configureViewControllers() {
        let feed = tamplateNavigationController(image: "home_unselected", rootViewController: FeedController())
        let explore = tamplateNavigationController(image: "search_unselected", rootViewController: ExploreController())
        let notification = tamplateNavigationController(image: "like_unselected", rootViewController: NotificationController())
        let conversation = tamplateNavigationController(image: "ic_mail_outline_white_2x-1", rootViewController: ConversationController())
        viewControllers = [feed, explore, notification, conversation]
    }
    
    fileprivate func tamplateNavigationController(image: String, rootViewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = UIImage(named: image)
        nav.navigationBar.barTintColor = .white
        return nav
    }



}

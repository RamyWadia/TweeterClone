//
//  User.swift
//  TwitterCopy
//
//  Created by Ramy Atalla on 2020-11-01.
//  Copyright © 2020 Ramy Atalla. All rights reserved.
//

import Foundation
import Firebase

struct User {
    let uid: String
    let email: String
    let password: String
    let fullname: String
    let username: String
    var profileImageUrl: URL?
    var isFollowed = false
    
    var isCurrentUser: Bool { return Auth.auth().currentUser?.uid == uid }
    
    
    init(uid: String, dict: [String: AnyObject]) {
        self.uid = uid
        email = dict["email"] as? String ?? ""
        password = dict["email"] as? String ?? ""
        fullname = dict["fullname"] as? String ?? ""
        username = dict["username"] as? String ?? ""
        
        if let profileImageURLString = dict["profileImageUrl"] as? String {
            guard let url = URL(string: profileImageURLString) else { return }
            self.profileImageUrl = url
        }
    }
}

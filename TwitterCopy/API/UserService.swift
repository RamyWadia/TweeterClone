//
//  UserService.swift
//  TwitterCopy
//
//  Created by Ramy Atalla on 2020-11-01.
//  Copyright © 2020 Ramy Atalla. All rights reserved.
//

import Firebase

struct UserService {
    static let shared = UserService()
    
    func fetchUser(completion: @escaping(User) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        REF_USERS.child(uid).observeSingleEvent(of: .value) { snapshot in
            guard let dict = snapshot.value as? [String: AnyObject] else { return }
            let user = User(uid: uid, dict: dict)
            completion(user)
        }
    }
}

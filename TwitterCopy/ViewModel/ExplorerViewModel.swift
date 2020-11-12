//
//  ExplorerViewModel.swift
//  TwitterCopy
//
//  Created by Ramy Atalla on 2020-11-12.
//  Copyright © 2020 Ramy Atalla. All rights reserved.
//

import UIKit

struct ExplorerViewModel {
    
    var user: User
    
    var profileImageURL: URL? { return user.profileImageUrl }
    var username: String { return user.username }
    var fullname: String { return user.fullname }
    
    init(user: User) {
        self.user = user
    }
}

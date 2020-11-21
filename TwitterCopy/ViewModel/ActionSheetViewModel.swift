//
//  ActionSheetViewModel.swift
//  TwitterCopy
//
//  Created by Ramy Atalla on 2020-11-21.
//  Copyright © 2020 Ramy Atalla. All rights reserved.
//

import Foundation

struct ActionSheetViewModel {
    
    private let user: User
    
    var options: [ActionSheetOption] {
        var results = [ActionSheetOption]()
        
        if user.isCurrentUser {
            results.append(.delete)
        } else {
            var followOption: ActionSheetOption = user.isFollowed ? .unfollow(user) : .follow(user)
//            assert(user.isFollowed == false, "The user does not show if followed or not")
            results.append(followOption)
        }
        results.append(.report)
        return results
    }
    
    init(user: User) {
        self.user = user
    }
}

enum ActionSheetOption: Equatable {
    case follow(User)
    case unfollow(User)
    case report
    case delete
    
    var description: String {
        switch self {
        case .follow(let user): return "Follow @\(user.username)"
        case .unfollow(let user): return "Unfollow @\(user.username)"
        case .report: return "Report Tweet"
        case .delete: return "Delete Tweet"
        }
    }
    
    static func == (lhs: ActionSheetOption, rhs: ActionSheetOption) -> Bool {
        lhs.description == rhs.description
    }
}



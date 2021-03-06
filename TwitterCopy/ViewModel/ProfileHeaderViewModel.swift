//
//  ProfileFilterOption.swift
//  TwitterCopy
//
//  Created by Ramy Atalla on 2020-11-09.
//  Copyright © 2020 Ramy Atalla. All rights reserved.
//

import UIKit

struct ProfileHeaderViewModel {
    
    let user: User
    
    var followersString: NSAttributedString? {
        return attributedText(withValue: user.stats?.followers ?? 5, text: "followers")
    }
    
    var followingString: NSAttributedString? {
        return attributedText(withValue: user.stats?.following ?? 6, text: "following")
    }
    
    var actionButtonTitle: String {
        if user.isCurrentUser {
            return "Edit Profile"
        }
        if !user.isCurrentUser && !user.isFollowed {
            return "Follow"
        } else {
            return "Unfollow"
        }
    }
    
    init(user: User) {
        self.user = user
    }
    
    private func attributedText(withValue value: Int, text: String) -> NSAttributedString {
        let attrebutedTitle = NSMutableAttributedString(string: String(value), attributes: [.font : UIFont.boldSystemFont(ofSize: 14)])
        attrebutedTitle.append(NSAttributedString(string: " \(text)", attributes: [.font: UIFont.boldSystemFont(ofSize: 14), .foregroundColor: UIColor.systemGray3]))
        return attrebutedTitle
    }
}

//
//  ProfileFilterOption.swift
//  TwitterCopy
//
//  Created by Ramy Atalla on 2020-11-09.
//  Copyright © 2020 Ramy Atalla. All rights reserved.
//

import UIKit

struct ProfileHeaderViewModel {
    
    private let user: User
    
    var followersString: NSAttributedString? {
        return attributedText(withValue: 0, text: "followers")
    }
    
    var followingString: NSAttributedString? {
        return attributedText(withValue: 0, text: "following")
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

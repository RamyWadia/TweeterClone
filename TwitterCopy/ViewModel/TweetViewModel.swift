//
//  TweetViewModel.swift
//  TwitterCopy
//
//  Created by Ramy Atalla on 2020-11-07.
//  Copyright © 2020 Ramy Atalla. All rights reserved.
//

import UIKit

struct TweetViewModel {
    let tweet: Tweet
    let user: User
    
    var profileImageURL: URL? {
        return user.profileImageUrl
    }
    
    
    var timestamp: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        let now = Date()
        return formatter.string(from: tweet.timestamp, to: now) ?? ""
    }
    
    var userInfoText: NSAttributedString {
        let title = NSMutableAttributedString(string: user.fullname, attributes: [.font: UIFont.systemFont(ofSize: 14), .foregroundColor: UIColor.label])
        title.append(NSAttributedString(string: " @\(user.username)", attributes: [.font: UIFont.systemFont(ofSize: 14), .foregroundColor: UIColor.secondaryLabel]))
        title.append(NSAttributedString(string: " • \(timestamp)", attributes: [.font: UIFont.systemFont(ofSize: 14), .foregroundColor: UIColor.secondaryLabel]))
        return title
    }

    
    init(tweet: Tweet) {
        self.tweet = tweet
        self.user = tweet.user
    }
}

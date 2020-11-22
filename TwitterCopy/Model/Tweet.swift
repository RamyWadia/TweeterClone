//
//  Tweet.swift
//  TwitterCopy
//
//  Created by Ramy Atalla on 2020-11-03.
//  Copyright © 2020 Ramy Atalla. All rights reserved.
//

import Foundation

struct Tweet {
    let tweetID: String
    let caption: String
    var likes: Int
    let retweetCount: Int
    var timestamp: Date!
    let uid: String
    var user: User
    var didLike = false
    
    init(user: User, tweetID: String, dict: [String: Any]) {
        self.user = user
        self.tweetID = tweetID
        self.caption = dict["caption"] as? String ?? ""
        self.likes = dict["likes"] as? Int ?? 0
        self.retweetCount = dict["retweetCount"] as? Int ?? 0
        self.uid = dict["uid"] as? String ?? ""
        
        if let timestamp = dict["timestamp"] as? Double {
            self.timestamp = Date(timeIntervalSince1970: timestamp)
        }
    }
}

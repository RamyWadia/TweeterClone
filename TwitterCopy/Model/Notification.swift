//
//  Notification.swift
//  TwitterCopy
//
//  Created by Ramy Atalla on 2020-11-26.
//  Copyright © 2020 Ramy Atalla. All rights reserved.
//

import Foundation

enum NotificationType: Int {
    case follow, like, reply, retweet, mention
}

struct Notification {
    let tweetID: String?
    var timestamp: Date!
    let user: User

    var type: NotificationType!
    
    init(user: User, dict: [String: AnyObject]) {
        self.user = user
        
        self.tweetID = dict["tweetID"] as? String ?? ""
        
        if let timestamp = dict["timestamp"] as? Double {
            self.timestamp = Date(timeIntervalSince1970: timestamp)
        }
        
        if let type = dict["type"] as? Int {
            self.type = NotificationType(rawValue: type)
        }
    }
}

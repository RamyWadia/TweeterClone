//
//  NotificationViewModel.swift
//  TwitterCopy
//
//  Created by Ramy Atalla on 2020-11-26.
//  Copyright © 2020 Ramy Atalla. All rights reserved.
//

import UIKit

struct NotificationViewModel {
    private let notification: Notification
    private let type: NotificationType
    private let user: User
    
    var timestampString: String? {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekday]
        formatter.unitsStyle = .abbreviated
        let now = Date()
        return formatter.string(from: notification.timestamp, to: now) ?? ""
    }
    
    var notificationMessage: String {
        switch type {
        case .follow: return " Started following you"
        case .like: return " liked your tweet"
        case .reply: return " replyed to you tweet"
        case .retweet: return " retweeted your tweet"
        case .mention: return " mentioned you in a tweet"
        }
    }
    
    var notificationText: NSAttributedString? {
        guard let timestamp = timestampString else { return nil }
        let attrebutedText = NSMutableAttributedString(string: user.username, attributes: [.font : UIFont.boldSystemFont(ofSize: 12)])
        attrebutedText.append(NSAttributedString(string: notificationMessage, attributes: [.font : UIFont.systemFont(ofSize: 12)]))
        attrebutedText.append(NSAttributedString(string: " \(timestamp)", attributes: [.font: UIFont.boldSystemFont(ofSize: 12), .foregroundColor: UIColor.systemGray3]))
        return attrebutedText
    }
    
    var profileImageURL: URL? {
        return user.profileImageUrl
    }
    
    init(notification: Notification) {
        self.notification = notification
        self.type = notification.type
        self.user = notification.user
    }
}

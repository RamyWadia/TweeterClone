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
    
    var fullname: String {
        return user.fullname
    }
    
    var username: String {
        return user.username
    }

    var timestamp: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        let now = Date()
        return formatter.string(from: tweet.timestamp, to: now) ?? ""
    }
    
    var headerTimstamp: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a ・ MM/dd/yyyy"
        return formatter.string(from: tweet.timestamp)
    }
    
    var userInfoText: NSAttributedString {
        let title = NSMutableAttributedString(string: user.fullname, attributes: [.font: UIFont.boldSystemFont(ofSize: 14), .foregroundColor: UIColor.label])
        title.append(NSAttributedString(string: " @\(user.username)", attributes: [.font: UIFont.systemFont(ofSize: 14), .foregroundColor: UIColor.secondaryLabel]))
        title.append(NSAttributedString(string: " • \(timestamp)", attributes: [.font: UIFont.systemFont(ofSize: 14), .foregroundColor: UIColor.secondaryLabel]))
        return title
    }
    
    var retweetsAttributedSrting: NSAttributedString {
        return attributedText(withValue: tweet.retweetCount, text:" Retweets")
    }
    
    var likesAttributedSrting: NSAttributedString {
        return attributedText(withValue: tweet.likes, text: "Likes")
    }

    
    init(tweet: Tweet) {
        self.tweet = tweet
        self.user = tweet.user
    }
    
    private func attributedText(withValue value: Int, text: String) -> NSAttributedString {
        let attrebutedTitle = NSMutableAttributedString(string: String(value), attributes: [.font : UIFont.boldSystemFont(ofSize: 14), .foregroundColor : UIColor.label])
        attrebutedTitle.append(NSAttributedString(string: " \(text)", attributes: [.font: UIFont.boldSystemFont(ofSize: 14), .foregroundColor: UIColor.systemGray3]))
        return attrebutedTitle
        #warning("come and refactor this and from the Profile Header")
    }
    
    func size(forWidth width: CGFloat) -> CGSize {
        let measurmentLabel = UILabel()
        measurmentLabel.text = tweet.caption
        measurmentLabel.numberOfLines = 0
        measurmentLabel.lineBreakMode = .byWordWrapping
        measurmentLabel.translatesAutoresizingMaskIntoConstraints = false
        measurmentLabel.widthAnchor.constraint(equalToConstant: width).isActive = true
        return measurmentLabel.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    }
}

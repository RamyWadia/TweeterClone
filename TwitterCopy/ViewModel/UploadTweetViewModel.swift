//
//  UploadTweetViewModel.swift
//  TwitterCopy
//
//  Created by Ramy Atalla on 2020-11-18.
//  Copyright © 2020 Ramy Atalla. All rights reserved.
//

import UIKit

import UIKit

enum UploadTweetConfiguration {
    case tweet
    case reply(Tweet)
}

struct UploadTweetViewModel {
    let actionButtonTitle: String
    let placeholderText: String
    var shouldShowReplyLable: Bool
    var replyText: String?
    
    init(config: UploadTweetConfiguration) {
        switch config {
        case .tweet:
            actionButtonTitle = "Tweet"
            placeholderText = "What's happening"
            shouldShowReplyLable = false
        case .reply(let tweet):
            actionButtonTitle = "Reply"
            placeholderText = "Tweet you reply"
            shouldShowReplyLable = true
            replyText = "Replying to @\(tweet.user.username)"
        }
    }
}

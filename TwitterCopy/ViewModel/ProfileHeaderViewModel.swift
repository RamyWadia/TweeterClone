//
//  ProfileFilterOption.swift
//  TwitterCopy
//
//  Created by Ramy Atalla on 2020-11-09.
//  Copyright © 2020 Ramy Atalla. All rights reserved.
//

import Foundation

enum ProfileFilterOption: Int, CaseIterable {
    case tweets, replies, likes
    
    var discription: String {
        switch self {
        case .tweets: return "Tweets"
        case .replies: return "Tweets & Replies"
        case .likes: return "Likes"
        }
    }
}

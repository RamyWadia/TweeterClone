//
//  Constants.swift
//  TwitterCopy
//
//  Created by Ramy Atalla on 2020-06-04.
//  Copyright © 2020 Ramy Atalla. All rights reserved.
//

import Firebase

let STORAGE_REF = Storage.storage().reference()
let STORAGE_PROFILE_IMAGES = STORAGE_REF.child("profile_images")

let DB_REF = Database.database().reference()
let REF_USERS = DB_REF.child("users")
let REF_TWEETS = DB_REF.child("tweets")
let REF_USER_TWEETS = DB_REF.child("userTweets")



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

//
//  NotificationService.swift
//  TwitterCopy
//
//  Created by Ramy Atalla on 2020-11-26.
//  Copyright © 2020 Ramy Atalla. All rights reserved.
//

import Firebase

struct NotificationService {
    static let shared = NotificationService()
    
    func UploadNotification(type: NotificationType, tweet: Tweet? = nil, user: User? = nil) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        var values: [String: Any] = ["timestamp": Int(NSDate().timeIntervalSince1970),
                                     "uid": uid,
                                     "type": type.rawValue]
        
        if let tweet = tweet {
            values["tweetID"] = tweet.tweetID
            REF_NOTIFICATION.child(tweet.user.uid).childByAutoId().updateChildValues(values)
        } else if let user = user {
            REF_NOTIFICATION.child(user.uid).childByAutoId().updateChildValues(values)
        }
    }
    
    func fetchNotifications(completion: @escaping([Notification]) -> Void) {
        var notifications = [Notification]()
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        REF_NOTIFICATION.child(uid).observe(.childAdded) { snapshot in
            guard let dict = snapshot.value as? [String: AnyObject] else { return }
            guard let uid = dict["uid"] as? String else { return }
            
            UserService.shared.fetchUser(uid: uid) { user in
                let notification = Notification(user: user, dict: dict)
                notifications.append(notification)
                completion(notifications)
            }
        }
    }
}

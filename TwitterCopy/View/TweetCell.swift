//
//  TweetCell.swift
//  TwitterCopy
//
//  Created by Ramy Atalla on 2020-11-04.
//  Copyright © 2020 Ramy Atalla. All rights reserved.
//

import UIKit

class TweetCell: UICollectionViewCell {
    static let reuseID = "tweetCellReuseID"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

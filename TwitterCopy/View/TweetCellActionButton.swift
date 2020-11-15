//
//  TweetCellActionButton.swift
//  TwitterCopy
//
//  Created by Ramy Atalla on 2020-11-05.
//  Copyright © 2020 Ramy Atalla. All rights reserved.
//

import UIKit

class TweetCellActionButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(image: String, action: Selector, target: UIView) {
        self.init()
        setImage(UIImage(named: image), for: .normal)
        tintColor = .darkGray
        setDimensions(width: 20, height: 20)
        addTarget(target, action: action, for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

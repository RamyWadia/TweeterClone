//
//  ActionButtonsStack.swift
//  TwitterCopy
//
//  Created by Ramy Atalla on 2020-11-15.
//  Copyright © 2020 Ramy Atalla. All rights reserved.
//

import UIKit

protocol ActionButtonsStackDelegate: class {
    func handleCommentTapped()
    func handleRetweetTapped()
    func handleLikeTapped()
    func handleShareTapped()
}

class ActionButtonsStack: UIStackView {
    
    //MARK: - properties
    
    weak var delegate: ActionButtonsStackDelegate?
    
    private lazy var commentButton = TweetCellActionButton(image: "comment", action: #selector(handleCommentTapped), target: self)
    
    private lazy var retweetButton = TweetCellActionButton(image: "retweet", action: #selector(handleRetweetTapped), target: self)
    
    private lazy var likeButton = TweetCellActionButton(image: "like", action: #selector(handleLikeTapped), target: self)
    
    private lazy var shareButton = TweetCellActionButton(image: "share", action: #selector(handleShareTapped), target: self)
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Selectors
    
    @objc func handleCommentTapped() {
        delegate?.handleCommentTapped()
    }
    
    @objc func handleRetweetTapped() {
        delegate?.handleRetweetTapped()
    }
    
    @objc func handleLikeTapped() {
        delegate?.handleLikeTapped()
    }
    
    @objc func handleShareTapped() {
        delegate?.handleShareTapped()
    }
    
    //MARK: - Helpers
    
    fileprivate func configureUI() {
        spacing = 72
        let views = [commentButton, retweetButton, likeButton, shareButton]
        for view in views {
            addArrangedSubview(view)
        }
    }
}

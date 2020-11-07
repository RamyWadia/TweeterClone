//
//  TweetCell.swift
//  TwitterCopy
//
//  Created by Ramy Atalla on 2020-11-04.
//  Copyright © 2020 Ramy Atalla. All rights reserved.
//

import UIKit

protocol TweetCellDelegate: class {
    func handleProfileimageTapped()
}

class TweetCell: UICollectionViewCell {
    //MARK: - Properties
    static let reuseID = "tweetCellReuseID"
    
    var tweet: Tweet? {
        didSet { configure() }
    }
    
    private lazy var profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.setDimensions(width: 35, height: 35)
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 35 / 2
        iv.backgroundColor = .twitterBlue

        let tap = UITapGestureRecognizer(target: self, action: #selector(handleProfileImageTapped))
        iv.addGestureRecognizer(tap)
        iv.isUserInteractionEnabled = true
        
        return iv
    }()
    
    private let captionLable: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.text = "This is a tweetcell test"
        return label
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "Ramy Atalla ramy@gmail.com"
        return label
    }()
    
    private lazy var commentButton = TweetCellButton(image: "comment", action: #selector(handleCommentTapped), target: self)
    
    private lazy var retweetButton = TweetCellButton(image: "retweet", action: #selector(handleRetweetTapped), target: self)
    
    private lazy var likeButton = TweetCellButton(image: "like", action: #selector(handleLikeTapped), target: self)
    
    private lazy var shareButton = TweetCellButton(image: "share", action: #selector(handleShareTapped), target: self)
    
    weak var delegate: TweetCellDelegate?
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .secondarySystemBackground
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Selectors
    
    @objc func handleProfileImageTapped() {
        delegate?.handleProfileimageTapped()
    }
    
    @objc func handleCommentTapped() {
        print("comment")
    }
    
    @objc func handleRetweetTapped() {
        print("retweet")
    }
    
    @objc func handleLikeTapped() {
        print("like")
    }
    
    @objc func handleShareTapped() {
        print("share")
    }
    
    //MARK: - Helpers
    
    private func configure() {
        guard let tweet = tweet else { return }
        let viewModel = TweetViewModel(tweet: tweet)
        
        captionLable.text = tweet.caption
        
        profileImageView.sd_setImage(with: viewModel.profileImageURL)
        infoLabel.attributedText = viewModel.userInfoText
    }
    
    private func configureUI() {
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor, left: leftAnchor, paddingTop: 8, paddingLeft: 12)
        
        let headStack = UIStackView(arrangedSubviews: [infoLabel, captionLable])
        headStack.axis = .vertical
        addSubview(headStack)
        headStack.anchor(top: profileImageView.topAnchor, left: profileImageView.rightAnchor, paddingLeft: 8)
        
        let actionStack = UIStackView(arrangedSubviews: [commentButton, retweetButton, likeButton, shareButton])
        actionStack.axis = .horizontal
        actionStack.spacing  = 52
        addSubview(actionStack)
        actionStack.centerX(inView: self)
        actionStack.anchor(bottom: bottomAnchor, paddingBottom: 8)
    }
}

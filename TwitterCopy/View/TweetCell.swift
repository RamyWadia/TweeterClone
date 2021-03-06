//
//  TweetCell.swift
//  TwitterCopy
//
//  Created by Ramy Atalla on 2020-11-04.
//  Copyright © 2020 Ramy Atalla. All rights reserved.
//

import UIKit

protocol TweetCellDelegate: class {
    func handleProfileimageTapped(_ cell: TweetCell)
    func handleReplyTapped(_ cell: TweetCell)
    func handleRetweetTapped(_ cell: TweetCell)
    func handleLikeTapped(_ cell: TweetCell)
    func handleShareTapped(_ cell: TweetCell)
}

class TweetCell: UICollectionViewCell {
    //MARK: - Properties
    static let reuseID = "tweetCellReuseID"
    
    var tweet: Tweet? {
        didSet { configure() }
    }
    
    let actionStack = ActionButtonsStack()
    
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

    weak var delegate: TweetCellDelegate?
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        actionStack.delegate = self
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Selectors
    
    @objc func handleProfileImageTapped() {
        delegate?.handleProfileimageTapped(self)
    }
    
    //MARK: - Helpers

    private func configure() {
        guard let tweet = tweet else { return }
        let viewModel = TweetViewModel(tweet: tweet)
        
        captionLable.text = tweet.caption
    
        profileImageView.sd_setImage(with: viewModel.profileImageURL)
        infoLabel.attributedText = viewModel.userInfoText
        
        actionStack.likeButton.tintColor = viewModel.likeButtonTintColor
        actionStack.likeButton.setImage(viewModel.likeButtonImage, for: .normal)
    }
    
    private func configureUI() {
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor, left: leftAnchor, paddingTop: 8, paddingLeft: 12)
        
        let headStack = UIStackView(arrangedSubviews: [infoLabel, captionLable])
        headStack.axis = .vertical
        addSubview(headStack)
        headStack.anchor(top: profileImageView.topAnchor, left: profileImageView.rightAnchor, right: rightAnchor, paddingLeft: 8, paddingRight: 8)
        
        addSubview(actionStack)
        actionStack.centerX(inView: self)
        actionStack.anchor(top: headStack.bottomAnchor, paddingTop: 16)
    }
}

//MARK: - ActionButtonsStackDelegate

extension TweetCell: ActionButtonsStackDelegate {
    
    func handleReplyTapped() {
        delegate?.handleReplyTapped(self)
    }
    
    func handleRetweetTapped() {
        delegate?.handleRetweetTapped(self)
    }
    
    func handleLikeTapped() {
        delegate?.handleLikeTapped(self)
    }
    
    func handleShareTapped() {
        delegate?.handleShareTapped(self)
    }
    
}

//
//  TweetHeader.swift
//  TwitterCopy
//
//  Created by Ramy Atalla on 2020-11-15.
//  Copyright © 2020 Ramy Atalla. All rights reserved.
//

import UIKit

class TweetHeader: UICollectionReusableView {
    
    //MARK: - Properties
    
    static let reuseID = "tweetHeader"
    
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
    
    lazy var fullnameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "fullname text"
        return label
    }()
    
    lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .secondaryLabel
        label.text = "username text"
        return label
    }()
    
    private let captionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 0
        label.text = "captionlabel text"
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .left
        label.text = "date text"
        return label
    }()
    
    private lazy var optionButton: UIButton = {
        let button = UIButton()
        button.tintColor = .secondaryLabel
        button.setImage(UIImage(named: "down_arrow_24pt"), for: .normal)
        button.addTarget(self, action: #selector(showActionSheet), for: .touchUpInside)
        return button
    }()
    
    private lazy var retweetsButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.secondaryLabel, for: .normal)
        button.addTarget(self, action: #selector(handleRetweetsTapped), for: .touchUpInside)
        button.setTitle("0 retweets", for: .normal)
        return button
    }()
    
    private lazy var likesButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.secondaryLabel, for: .normal)
        button.addTarget(self, action: #selector(handleLIkesTapped), for: .touchUpInside)
        button.setTitle("0 likes", for: .normal)
        return button
        
    }()
    
    private lazy var statsView: UIView = {
       let view = UIView()
        
        let devide1 = UIView()
        devide1.backgroundColor = .systemGroupedBackground
        view.addSubview(devide1)
        devide1.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingLeft: 8, height: 1.0)
        
        let stack = UIStackView(arrangedSubviews: [retweetsButton, likesButton])
        stack.spacing = 12
        view.addSubview(stack)
        stack.centerY(inView: view)
        stack.anchor(left: view.leftAnchor, paddingLeft: 16)
        
        let devide2 = UIView()
        devide2.backgroundColor = .systemGroupedBackground
        view.addSubview(devide2)
        devide2.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingLeft: 8, height: 1.0)
        
        view.backgroundColor = .systemBackground
        return view
    }()
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Selectors
    
    @objc func handleProfileImageTapped() {
        
    }
    
    @objc func showActionSheet() {
        print("DEBUG: go to user profile")
    }
    
    @objc func handleRetweetsTapped() {
        print("DEBUG: handleretweets tapped")
    }
    
    @objc func handleLIkesTapped() {
        print("DEBUG: handleLIkesTapped")
    }
    
    //MARK: - Helpers
    
    private func configureUI() {
        let labelStack = UIStackView(arrangedSubviews: [fullnameLabel, usernameLabel])
        labelStack.axis = .vertical
        labelStack.spacing = -6
        
        let stack = UIStackView(arrangedSubviews: [profileImageView, labelStack])
        stack.spacing = 12
        
        addSubview(stack)
        stack.anchor(top: topAnchor, left: leftAnchor, paddingTop: 16, paddingLeft: 16)
        
        addSubview(captionLabel)
        captionLabel.anchor(top: stack.bottomAnchor, left: leftAnchor, paddingTop: 20, paddingLeft: 16)
        
        addSubview(dateLabel)
        dateLabel.anchor(top: captionLabel.bottomAnchor, left: leftAnchor, paddingTop: 20, paddingLeft: 16)
        
        addSubview(optionButton)
        optionButton.centerY(inView: stack)
        optionButton.anchor(right: rightAnchor, paddingRight: 8)
        
        addSubview(statsView)
        statsView.anchor(top: dateLabel.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 20, height: 40)
    }
    
}

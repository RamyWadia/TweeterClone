//
//  UploadTweeterController.swift
//  TwitterCopy
//
//  Created by Ramy Atalla on 2020-11-01.
//  Copyright © 2020 Ramy Atalla. All rights reserved.
//

import UIKit

class UploadTweetController: UIViewController {
    
    //MARK: - Properties
    
    private let user: User
    private let config: UploadTweetConfiguration
    private lazy var viewModel = UploadTweetViewModel(config: config)
    
    private lazy var tweetButton: UIButton = {
        let button = UIButton()
        button.setDimensions(width: 64, height: 32)
        button.backgroundColor = .twitterBlue
        button.tintColor = .white
        button.setTitle("Tweet", for: .normal)
        button.layer.cornerRadius = 32 / 2
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(handleUploadTweet), for: .touchUpInside)
        return button
    }()
    
    private lazy var profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.setDimensions(width: 48, height: 48)
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 48 / 2
        iv.backgroundColor = .twitterBlue
        return iv
    }()
    
    private lazy var replyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .systemGray2
        label.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        label.text = "replying to @...."
        return label
    }()

    private let captionTextView = CaptionTextView()
    
    //MARK: - LifeCycle
    
    init(user: User, config: UploadTweetConfiguration) {
        self.user = user
        self.config = config
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    //MARK: - Selectors
    
    @objc func handleDismiss() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func handleUploadTweet() {
        guard let caption = captionTextView.text else { return }
        TweetService.shared.UploadTweet(caption: caption, type: config) { err, ref in
            if let err = err {
                print("DEBUG: Failed to upload tweet with error \(err.localizedDescription)")
            }
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    //MARK: - API
    
    //MARK: - Helpers

    private func configureUI() {
        view.backgroundColor = .systemBackground
        handleNavigationBar()
        
        let imageCaptionStack = UIStackView(arrangedSubviews: [profileImageView, captionTextView])
        imageCaptionStack.axis = .horizontal
        imageCaptionStack.spacing = 8
        imageCaptionStack.alignment = .leading
        
        let stack = UIStackView(arrangedSubviews: [replyLabel, imageCaptionStack])
        stack.axis = .vertical
        stack.spacing = 12
        
        view.addSubview(stack)
        stack.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 16, paddingLeft: 16, paddingRight: 16)
        profileImageView.sd_setImage(with: user.profileImageUrl, completed: nil)
        
        tweetButton.setTitle(viewModel.actionButtonTitle, for: .normal)
        captionTextView.placeholder.text = viewModel.placeholderText
        
        replyLabel.isHidden = !viewModel.shouldShowReplyLable
        guard let replyText = viewModel.replyText else { return }
        replyLabel.text = replyText
    }
    
    private func handleNavigationBar() {
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.isTranslucent = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleDismiss))
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: tweetButton)
    }
}

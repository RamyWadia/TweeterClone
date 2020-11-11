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

    private let user: User

    private let captionTextView = CaptionTextView()
    
    //MARK: - LifeCycle
    
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        print("DEBUG: the username is \(user.username)")
    }

    //MARK: - Selectors
    
    @objc func handleDismiss() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func handleUploadTweet() {
        guard let caption = captionTextView.text else { return }
        TweetService.shared.UploadTweet(caption: caption) { err, ref in
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
        
        let stack = UIStackView(arrangedSubviews: [profileImageView, captionTextView])
        stack.axis = .horizontal
        stack.spacing = 8
        
        view.addSubview(stack)
        stack.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 16, paddingLeft: 16, paddingRight: 16)
        profileImageView.sd_setImage(with: user.profileImageUrl, completed: nil)
    }
    
    private func handleNavigationBar() {
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.isTranslucent = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleDismiss))
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: tweetButton)
    }
}

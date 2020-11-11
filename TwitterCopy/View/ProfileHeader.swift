//
//  ProfileHeader.swift
//  TwitterCopy
//
//  Created by Ramy Atalla on 2020-11-07.
//  Copyright © 2020 Ramy Atalla. All rights reserved.
//

import UIKit

protocol ProfileHeaderDelegate: class {
    func handleDismissal()
}

class ProfileHeader: UICollectionReusableView {
    
    //MARK: - Properties
    
    static let reuseID = "profileHeaderReuseID"
    
    var user: User? {
        didSet {
            configureUser()
        }
    }
    
    weak var delegate: ProfileHeaderDelegate?
    private var profileFilterView = ProfileFilterView()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .twitterBlue
        view.addSubview(backButton)
        backButton.anchor(top: view.topAnchor, left: view.leftAnchor, paddingTop: 42, paddingLeft: 16)
        backButton.setDimensions(width: 30, height: 30)
        return view
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "baseline_arrow_back_white_24dp").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleDismissal), for: .touchUpInside)
        return button
    }()
    
    lazy var profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        iv.layer.borderColor = UIColor.white.cgColor
        iv.layer.borderWidth = 4
        return iv
    }()
    
    lazy var editProfileFollowButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Loading", for: .normal)
        button.layer.borderColor = UIColor.twitterBlue.cgColor
        button.layer.borderWidth = 1.25
        button.setTitleColor(.twitterBlue, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleProfileFollow), for: .touchUpInside)
        return button
    }()
    
    lazy var fullnameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "Eddie Brock"
        return label
    }()
    
    lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .secondaryLabel
        label.text = "@venom"
        return label
    }()
    
    lazy var bioLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 3
        label.text = "this is a user bio that will span more than one line for test purposes"
        return label
    }()
    
    lazy var followingLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        let followTap = UITapGestureRecognizer(target: self, action: #selector(handleFollowingTapped))
        return label
    }()
    
    lazy var followersLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        let followtTap = UITapGestureRecognizer(target: self, action: #selector(handleFollowersTaped))
        return label
    }()
    
    private lazy var underlineView: UIView = {
        let view = UIView()
        view.backgroundColor = .twitterBlue
        return view
    }()
    
    
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        profileFilterView.delegate = self
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Selectors
    
    @objc func handleDismissal() {
        delegate?.handleDismissal()
    }
    
    @objc func handleProfileFollow() {
        print("DEBUG: follow button tapped")
    }
    
    @objc func handleFollowersTaped() {
        print("DEBUG: followers button tapped")
    }
    
    @objc func handleFollowingTapped() {
        print("DEBUG: following button tapped")
    }
    
    //MARK: - Helpers
    
    private func configureUser() {
        guard let user = user else { return }
        let viewModel = ProfileHeaderViewModel(user: user)
        
        followersLabel.attributedText = viewModel.followersString
        followingLabel.attributedText = viewModel.followersString
        editProfileFollowButton.setTitle(viewModel.actionButtonTitle, for: .normal)
        profileImageView.sd_setImage(with: user.profileImageUrl)
    }
    
    private func configureUI() {
        addSubview(containerView)
        containerView.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, height: 108)
        
        addSubview(profileImageView)
        profileImageView.anchor(top: containerView.bottomAnchor, left: leftAnchor, paddingTop: -24, paddingLeft: 8)
        profileImageView.setDimensions(width: 80, height: 80)
        profileImageView.layer.cornerRadius = 80 / 2
        
        addSubview(editProfileFollowButton)
        editProfileFollowButton.anchor(top: containerView.bottomAnchor, right: rightAnchor, paddingTop: 12, paddingRight: 12)
        editProfileFollowButton.layer.cornerRadius = 36 / 2
        // Dimentions may need to be fixed or removed later
        editProfileFollowButton.setDimensions(width: 100, height: 36)
        
        let userDetailsStack = UIStackView.init(arrangedSubviews: [fullnameLabel, usernameLabel, bioLabel])
        userDetailsStack.axis = .vertical
        userDetailsStack.distribution = .fillProportionally
        userDetailsStack.spacing = 4
        
        addSubview(userDetailsStack)
        userDetailsStack.anchor(top: profileImageView.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 8, paddingLeft: 12, paddingRight: 12)
        
        let followStack = UIStackView(arrangedSubviews: [followingLabel, followersLabel])
        followStack.axis = .horizontal
        followStack.spacing = 8
        followStack.distribution = .fillEqually
        
        addSubview(followStack)
        followStack.anchor(top: userDetailsStack.bottomAnchor, left: leftAnchor, paddingTop: 8, paddingLeft: 12)
        
        addSubview(profileFilterView)
        profileFilterView.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, height: 50)
        
        addSubview(underlineView)
        underlineView.anchor(left: leftAnchor, bottom: bottomAnchor, width: frame.width / 3, height:  2)
        
    }
}

//MARK: - ProfileFilterViewDelegate

extension ProfileHeader: profileFilterViewDelegate {
    func filterView(_ view: ProfileFilterView, didSelect indexPath: IndexPath) {
        guard let cell = view.collectionVeiw.cellForItem(at: indexPath) as? ProfileFilterCell else { return }
        let xPosition = cell.frame.origin.x
        UIView.animate(withDuration: 0.3) {
            self.underlineView.frame.origin.x = xPosition
        }
    }
}

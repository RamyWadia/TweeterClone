//
//  UserCell.swift
//  TwitterCopy
//
//  Created by Ramy Atalla on 2020-11-12.
//  Copyright © 2020 Ramy Atalla. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {
    
    //MARK: - Properties
    
    static let reuseID = "userCell"
    
    var user: User? {
        didSet {
            configure()
        }
    }
    
    
    private lazy var profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.setDimensions(width: 40, height: 40)
        iv.layer.cornerRadius = 40 / 2
        iv.backgroundColor = .twitterBlue
        return iv
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "Username"
        return label
    }()
    
    private let fullnameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "Fullname"
        return label
    }()
    
    //MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    fileprivate func configure() {
        guard let user = user else { return }
        let viewModel = ExplorerViewModel(user: user)
        
        profileImageView.sd_setImage(with: viewModel.profileImageURL)
        fullnameLabel.text = viewModel.fullname
        usernameLabel.text = viewModel.username
    }
    
    fileprivate func configureUI() {
        addSubview(profileImageView)
        profileImageView.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 12)
        
        let stack = UIStackView(arrangedSubviews: [usernameLabel, fullnameLabel])
        stack.axis = .vertical
        addSubview(stack)
        stack.centerY(inView: profileImageView, leftAnchor: profileImageView.rightAnchor, paddingLeft: 12)
    }
}

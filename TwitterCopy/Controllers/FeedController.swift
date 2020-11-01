//
//  FeedController.swift
//  TwitterCopy
//
//  Created by Ramy Atalla on 2020-05-29.
//  Copyright © 2020 Ramy Atalla. All rights reserved.
//

import UIKit
import SDWebImage

class FeedController: UIViewController {
    
    //MARK: - Properties
    
    var user: User? {
        didSet {
            configureLeftBarButton()
        }
    }
    
    //MARK: - Lifecycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    
    //MARK: - Helpers
    
    fileprivate func configureUI() {
        view.backgroundColor = .white
        
        let imageView = UIImageView(image: UIImage(named: "twitter_logo_blue"))
        imageView.contentMode = .scaleAspectFit
        imageView.setDimensions(width: 44, height: 44)
        navigationItem.titleView = imageView
    }
    
    private func configureLeftBarButton() {
        let profileImageView = UIImageView()
        profileImageView.setDimensions(width: 32, height: 32)
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = 32 / 2
        
        profileImageView.sd_setImage(with: user?.profileImageUrl, completed: nil)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileImageView)
    }
    
}

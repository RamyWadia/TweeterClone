//
//  FeedController.swift
//  TwitterCopy
//
//  Created by Ramy Atalla on 2020-05-29.
//  Copyright © 2020 Ramy Atalla. All rights reserved.
//

import UIKit
import SDWebImage

class FeedController: UICollectionViewController {
    //MARK: - Properties
    
    var user: User? {
        didSet { configureLeftBarButton() }
    }
    
    private var tweets = [Tweet]() {
        didSet { collectionView.reloadData() }
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchTweets()
    }
    
    //MARK: - API
    private func fetchTweets() {
        TweetService.shared.fetchTweets { tweets in
            self.tweets = tweets
            print(tweets.count)
        }
    }

    //MARK: - Helpers
    fileprivate func configureUI() {
        collectionView.register(TweetCell.self, forCellWithReuseIdentifier: TweetCell.reuseID)
        collectionView.backgroundColor = .systemBackground
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

//MARK: - CollectionViewDelegate/DataSource
extension FeedController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tweets.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TweetCell.reuseID, for: indexPath) as! TweetCell
        cell.delegate = self
        cell.tweet = tweets[indexPath.item]
        return cell
    }
}

//MARK: - CollectionViewFlowLayout

extension FeedController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 110)
    }
}

//MARK: - TweetCellDelegate

extension FeedController: TweetCellDelegate {
    func handleProfileimageTapped() {
        let profileController = ProfileController(collectionViewLayout: UICollectionViewFlowLayout())
        navigationController?.pushViewController(profileController, animated: true)
    }
}

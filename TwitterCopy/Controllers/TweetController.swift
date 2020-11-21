//
//  TweetController.swift
//  TwitterCopy
//
//  Created by Ramy Atalla on 2020-11-15.
//  Copyright © 2020 Ramy Atalla. All rights reserved.
//

import UIKit

class TweetController: UICollectionViewController {
    
    //MARK: - Peoperties
    
    private let tweet: Tweet
    private var actionSheetLauncher: ActionSheetLauncher!
    private var replies = [Tweet]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    //MARK: - Lifecycle
    
    init(tweet: Tweet) {
        self.tweet = tweet
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        fetchReplies()
    }
    
    //MARK: - Selectors
    
    //MARK: - API
    func fetchReplies() {
        TweetService.shared.fetchReplies(forTweet: tweet) { replies in
            self.replies = replies
        }
    }
    
    //MARK: - Helpers
    
    fileprivate func showActionSheet(forUser user: User) {
        actionSheetLauncher = ActionSheetLauncher(user: user)
        actionSheetLauncher.delegate = self
        actionSheetLauncher.showActionOptions()
    }
    
    fileprivate func configureCollectionView() {
        collectionView.backgroundColor = .systemBackground
        
        collectionView.register(TweetHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader , withReuseIdentifier: TweetHeader.reuseID)
        collectionView.register(TweetCell.self, forCellWithReuseIdentifier: TweetCell.reuseID)
    }
}

//MARK: - UICollectionViewDataSource

extension TweetController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return replies.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TweetCell.reuseID, for: indexPath) as! TweetCell
        cell.tweet = replies[indexPath.row]
        cell.delegate = self
        return cell
    }
}

//MARK: - UICollectionViewDlegate

extension TweetController {
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TweetHeader.reuseID, for: indexPath) as! TweetHeader
        header.tweet = tweet
        header.delegate = self
        return header
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension TweetController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let viewModel = TweetViewModel(tweet: replies[indexPath.item])
        let height = viewModel.size(forWidth: view.frame.width).height
        return CGSize(width: view.frame.width, height: height + 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let viewModel = TweetViewModel(tweet: tweet)
        let captionHeight = viewModel.size(forWidth: view.frame.width).height
        return CGSize(width: view.frame.width, height: captionHeight + 300)
    }
}


//MARK: - TweetCellDelegate

extension TweetController: TweetCellDelegate {
    func handleReplyTapped(_ cell: TweetCell) {
        guard let tweet = cell.tweet else { return }
        let controller = UploadTweetController(user: tweet.user, config: .reply(tweet))
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
    }
    
    func handleRetweetTapped(_ cell: TweetCell) {
        print("DEBUG: Retweet tapped ..")
    }
    
    func handleProfileimageTapped(_ cell: TweetCell) {
        guard let user = cell.tweet?.user else { return }
        let profileController = ProfileController(user: user)
        navigationController?.pushViewController(profileController, animated: true)
    }
}

//MARK: - TweetHeaderDelegate

extension TweetController: TweetHeaderDelegate {
    
    func showActionSheet() {
        if tweet.user.isCurrentUser {
            showActionSheet(forUser: tweet.user)
        } else {
            UserService.shared.isUserFollowed(uid: tweet.user.uid) { [weak self] isFollowed in
                print(isFollowed)
                guard let self = self else { return }
                var user = self.tweet.user
                user.isFollowed = isFollowed
                print(user.isFollowed)
                self.showActionSheet(forUser: user)
            }
        }
    }
}

//MARK: - ActionSheetLauncherDelegate

extension TweetController: ActionSheetLauncherDelegate {
    func didSelect(option: ActionSheetOption) {
        switch option {
            case .follow(let user):
                UserService.shared.followUser(uid: user.uid) { (err, ref) in
                    print("DEBUG: did follow user")
                }
            case .unfollow(let user):
                UserService.shared.unfollowUser(uid: user.uid) { (err, ref) in
                    print("DEBUG: DID UNFOLLOW USER")
                }
            case .report:
                print("DEBUG: REPORT")
            case .delete:
                print("DEBUG: DELETE")
        }
    }
}

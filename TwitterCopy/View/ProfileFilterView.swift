//
//  ProfileFilterView.swift
//  TwitterCopy
//
//  Created by Ramy Atalla on 2020-11-08.
//  Copyright © 2020 Ramy Atalla. All rights reserved.
//

import UIKit

protocol profileFilterViewDelegate: class {
    func filterView(_ view: ProfileFilterView, didSelect indexPath: IndexPath)
}

class ProfileFilterView: UIView {
    //MARK: - Properties
    
    lazy var collectionVeiw: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.delegate = self
        view.dataSource = self
        view.backgroundColor = .systemBackground
        view.register(ProfileFilterCell.self, forCellWithReuseIdentifier: ProfileFilterCell.reuseID)
        return view
    }()
    
    weak var delegate: profileFilterViewDelegate?
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Selectors
    
    //MARK: - Helpers
    
    private func configureCollectionView() {
        let selectedIndexPath = IndexPath(row: 0, section: 0)
        collectionVeiw.selectItem(at: selectedIndexPath, animated: true, scrollPosition: .left)
        
        addSubview(collectionVeiw)
        collectionVeiw.addConstraintsToFillView(self)
    }
}

    //MARK: - CollectionViewDataSource
extension ProfileFilterView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ProfileFilterOption.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileFilterCell.reuseID, for: indexPath) as! ProfileFilterCell
        let option = ProfileFilterOption(rawValue: indexPath.row)
        cell.option = option
        return cell
    }
}

    //MARK: - CollectionViewDelegate

extension ProfileFilterView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.filterView(self, didSelect: indexPath)
    }
}

    //MARK: - CollectionViewDelegateFlowLayout

extension ProfileFilterView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let count = CGFloat(ProfileFilterOption.allCases.count)
        return CGSize(width: frame.width  / count - 4 , height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
}
    


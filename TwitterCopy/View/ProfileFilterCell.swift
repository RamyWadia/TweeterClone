//
//  ProfileFilterCell.swift
//  TwitterCopy
//
//  Created by Ramy Atalla on 2020-11-08.
//  Copyright © 2020 Ramy Atalla. All rights reserved.
//

import UIKit

class ProfileFilterCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    static let reuseID = "profileFilterReuseID"
    
    var option: ProfileFilterOption? {
        didSet {
            label.text = option?.discription
        }
    }
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .systemGray
        label.textAlignment = .center
        label.text = "test"
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            label.font = isSelected ? UIFont.systemFont(ofSize: 16) : UIFont.systemFont(ofSize: 14)
            label.textColor = isSelected ? .twitterBlue : .systemGray2
        }
    }
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Selectors
    
    //MARK: - Helpers
    
    private func configure() {
        backgroundColor = .systemBackground 
        addSubview(label)
        label.addConstraintsToFillView(self)
    }
}

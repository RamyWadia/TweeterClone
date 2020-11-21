//
//  ActionSheetCell.swift
//  TwitterCopy
//
//  Created by Ramy Atalla on 2020-11-20.
//  Copyright © 2020 Ramy Atalla. All rights reserved.
//

import UIKit

class ActionSheetCell: UITableViewCell {
    
    //MARK: - Properties
    
    static let reuseID = "actionSheetCell"
    
    var option: ActionSheetOption? {
        didSet {
            configure()
        }
    }
    
    private let optionImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "twitter_logo_blue")
        return iv
    }()
    
    private let titileLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.text = "Test"
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
    
    //MARK: - Selectors
    
    //MARK: - Helpers
    
    private func configure() {
        titileLabel.text = option?.description
    }
    
    private func configureUI() {
        addSubview(optionImageView)
        optionImageView.centerY(inView: self)
        optionImageView.anchor(left: leftAnchor, paddingLeft: 8)
        optionImageView.setDimensions(width: 36, height: 36)
        
        addSubview(titileLabel)
        titileLabel.centerY(inView: self)
        titileLabel.anchor(left: optionImageView.rightAnchor, paddingLeft: 12)
    }
    
    
}

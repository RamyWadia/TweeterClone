//
//  ConversationController.swift
//  TwitterCopy
//
//  Created by Ramy Atalla on 2020-05-29.
//  Copyright © 2020 Ramy Atalla. All rights reserved.
//

import UIKit

class ConversationController: UIViewController {
    
    //MARK: - Properties
    
    //MARK: - Lifecycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    
    //MARK: - Helpers
    
    fileprivate func configureUI() {
        view.backgroundColor = .white
        navigationItem.title = "Messages"
    }
    
}

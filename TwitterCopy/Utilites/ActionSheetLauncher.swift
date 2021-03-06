//
//  ActionSheetObject.swift
//  TwitterCopy
//
//  Created by Ramy Atalla on 2020-11-20.
//  Copyright © 2020 Ramy Atalla. All rights reserved.
//

import UIKit

protocol ActionSheetLauncherDelegate: class {
    func didSelect(option: ActionSheetOption)
}

class ActionSheetLauncher: NSObject {
    
    //MARK: - Properties
    
    private let user: User
    private let tableView = UITableView()
    private var window: UIWindow?
    private lazy var viewModel = ActionSheetViewModel(user: user)
    private lazy var tableViewHeigt = CGFloat(viewModel.options.count * 60) + 100
    weak var delegate: ActionSheetLauncherDelegate?
    
    private lazy var dimView: UIView = {
        let view = UIView()
        view.alpha = 0
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleDismissal))
        view.addGestureRecognizer(tap)
        return view
    }()
    
    private lazy var footerView: UIView = {
        let view = UIView()
        view.addSubview(cancelButton)
        cancelButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        cancelButton.anchor(left: view.leftAnchor, right: view.rightAnchor, paddingLeft: 12, paddingRight: 12)
        cancelButton.centerY(inView: view)
        cancelButton.layer.cornerRadius = 50 / 2
        return view
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemGroupedBackground
        button.addTarget(self, action: #selector(handleDismissal), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Lifecycle
    
    init(user: User) {
        self.user = user
        super.init()
        configTableView()
    }
    
    //MARK: - Selectors
    
    @objc func handleDismissal() {
        UIView.animate(withDuration: 0.5) {
            self.dimView.alpha = 0
            self.showTableView(false)
        }
    }
    
    //MARK: - Helpers
    
    private func showTableView(_ shouldShow: Bool) {
        guard let window = window else { return }
        let y = shouldShow ? window.frame.height - tableViewHeigt : window.frame.height
        tableView.frame.origin.y = y
    }
    
    func showActionOptions() {
        guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return }
        self.window = window
        
        window.addSubview(dimView)
        dimView.frame = window.frame
        
        window.addSubview(tableView)
        tableView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: tableViewHeigt)
        
        UIView.animate(withDuration: 0.5) {
            self.dimView.alpha = 1
            self.showTableView(true)
        }
    }
    
    func configTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 60
        tableView.separatorStyle = .none
        tableView.layer.cornerRadius = 5
        tableView.isScrollEnabled = false
        tableView.register(ActionSheetCell.self, forCellReuseIdentifier: ActionSheetCell.reuseID)
    }
}


    //MARK: - UITableViewDataSource

extension ActionSheetLauncher: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ActionSheetCell.reuseID, for: indexPath) as! ActionSheetCell
        cell.option = viewModel.options[indexPath.row]
        return cell
    }
}

    //MARK: - UITableViewDelegate

extension ActionSheetLauncher: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let option = viewModel.options[indexPath.row]
        print("DEBUG: option description is \(option.description)")
        UIView.animate(withDuration: 0.5) {
            self.dimView.alpha = 0
            self.showTableView(false)
        } completion: { _ in
            print("Debug: option is \(option.description)")
            self.delegate?.didSelect(option: option)
        }
    }
}
    
    


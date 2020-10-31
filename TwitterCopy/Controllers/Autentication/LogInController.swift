//
//  LogInControllers.swift
//  TwitterCopy
//
//  Created by Ramy Atalla on 2020-05-29.
//  Copyright © 2020 Ramy Atalla. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    //MARK: - Properties
    
    private let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "TwitterLogo")
        return iv
    }()
    
    private lazy var emailContainerView: UIView = {
        let image = #imageLiteral(resourceName: "ic_mail_outline_white_2x-1")
        let view = Utilites().inputContainerView(withImage: image, textField: emailTextField)
        return view
    }()
    
    private lazy var passwordContainerView: UIView = {
        let image = #imageLiteral(resourceName: "ic_lock_outline_white_2x")
        let view = Utilites().inputContainerView(withImage: image, textField: passwordTextField)
        return view
    }()
    
    private let emailTextField: UITextField = {
        let tf = Utilites().textField(withPlaceholder: "Email")
        tf.autocapitalizationType = .none
        return tf
    }()
    
    private let passwordTextField: UITextField = {
        let tf = Utilites().textField(withPlaceholder: "Password")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private let loginButon: UIButton = {
        let button = Utilites().logInSignUpButton(title: "Log in", selector: #selector(handleLogIn))
        return button
    }()
    
    private let donotHaveAccountButton: UIButton = {
        let button = Utilites().attriburedButton("Do not have an account?", secondPart: " Sign Up")
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - Selectors
    
    @objc func handleShowSignUp() {
        let controller = RegistrationController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func handleLogIn() {
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        AuthService.shared.logUserIn(email: email, password: password) { (result, err) in
            if let err = err {
                print("Debug: Error logging in wirh error \(err.localizedDescription)")
            } else {
                guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return }
                guard let tab = window.rootViewController as? MainTabController else { return }
                tab.authenticateUserAndConfigureUI()
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    //MARK: - Helpers
    
    fileprivate func configureUI() {
        view.backgroundColor = .twitterBlue
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        
        view.addSubview(logoImageView)
        logoImageView.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor)
        logoImageView.setDimensions(width: 150, height: 150)
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView, loginButon])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 20
        
        view.addSubview(stack)
        stack.anchor(top: logoImageView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingLeft: 32, paddingRight: 32)
        
        view.addSubview(donotHaveAccountButton)
        donotHaveAccountButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft: 40, paddingRight: 40)
    }
    
}

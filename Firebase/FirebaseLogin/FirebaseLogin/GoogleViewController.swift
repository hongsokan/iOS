//
//  ViewController.swift
//  FirebaseLogin
//
//  Created by 안홍석 on 2020/08/10.
//  Copyright © 2020 안홍석. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn


class GoogleViewController: UIViewController {
    
    let googleIdLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemGray
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    let googleSignInButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle("Google Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(googleLogin), for: .touchUpInside)
        return button
    }()
    
    let GIDButton: GIDSignInButton = {
        let button = GIDSignInButton()
        button.addTarget(self, action: #selector(googleLogin), for: .touchUpInside)
        return button
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Configure Firebase
        // ------------------
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }
        // FirebaseApp.configure()
        
        viewsConstraints()
    }
    
}



extension GoogleViewController {
    
    // Google Login
    @objc func googleLogin() {
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().signIn()
    }
    
    
    func viewsConstraints() {
        
        // googleIdLabel, UILabel
        self.view.addSubview(self.googleIdLabel)
        googleIdLabel.translatesAutoresizingMaskIntoConstraints = false
        googleIdLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        googleIdLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -60).isActive = true
        googleIdLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        googleIdLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        googleIdLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        // googleSignInButton, UIButton
        self.view.addSubview(self.googleSignInButton)
        googleSignInButton.translatesAutoresizingMaskIntoConstraints = false
        googleSignInButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        googleSignInButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        googleSignInButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        googleSignInButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true

        // GIDButton, GIDSignInButton
        GIDButton.center = CGPoint(x: view.center.x, y: view.center.y + 60)
        view.addSubview(GIDButton)
        
    }
}

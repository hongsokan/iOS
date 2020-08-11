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

class ViewController: UIViewController {

    let loginButton: UIButton = {
        let button = UIButton()
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().signIn()
    }


}


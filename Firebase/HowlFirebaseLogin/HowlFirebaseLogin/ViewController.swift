//
//  ViewController.swift
//  HowlFirebaseLogin
//
//  Created by 안홍석 on 2020/04/20.
//  Copyright © 2020 안홍석. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class ViewController: UIViewController {
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    // email, password 입력 시 회원가입 완료
    @IBAction func login(_ sender: Any) {
        Auth.auth().createUser(withEmail: email.text!, password: password.text!) { (user, error) in
            // ...
            
            if(error != nil) { return }
            
            let alert = UIAlertController(title: "알림", message: "회원가입완료", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default, handler:    nil))
            
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
    // 구글 로그인 버튼
    @IBAction func signIn(_ sender: Any) {
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().signIn()
        
        // TODO(developer) Configure the sign-in button look/feel
        // ...
    }
    
    
}


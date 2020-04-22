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
import FBSDKLoginKit

class ViewController: UIViewController, LoginButtonDelegate {
    
    // Facebook login button delegate
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        //        print(result?.token?.tokenString as Any)
        if(result?.token == nil) {
            return
        }
        
        let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
        
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
                // ...
                return
            }
            // User is signed in
            // ...
        }
        
        LoginManager().logOut()
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        
        //        loginButton.delegate = self
        //        let firebaseAuth = Auth.auth()
        //        do {
        //            try firebaseAuth.signOut()
        //        } catch let signOutError as NSError {
        //            print ("Error signing out: %@", signOutError)
        //        }
    }
    
    @IBOutlet weak var facebookLoginButton: FBLoginButton!
    
    
    // Email & Password
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    // email, password 입력 시 회원가입 완료
    @IBAction func login(_ sender: Any) {
        Auth.auth().createUser(withEmail: email.text!, password: password.text!) { (user, error) in
            // ...
            
            if(error != nil) {
                
                Auth.auth().signIn(withEmail: self.email.text!, password: self.password.text!) { (user, error) in
                    
                }
            } else {
                let alert = UIAlertController(title: "알림", message: "회원가입완료", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .default, handler:    nil))
                
                self.present(alert, animated: true, completion: nil)
            }
            
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
        
        facebookLoginButton.delegate = self
        facebookLoginButton.permissions = ["public_profile", "email"]
        
        Auth.auth().addStateDidChangeListener({ (user, err) in
            if user != nil {
                
                self.performSegue(withIdentifier: "Home", sender: nil)
            }
        })
    }
    
    
}


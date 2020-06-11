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
//import FBSDKLoginKit
//import FacebookLogin

class ViewController: UIViewController {
    
    // Email & Password
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var googleLogin: UIButton!
    
    // email, password 입력 시 회원가입 완료
    // Firebase 인증
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
    
    // 페이스북 로그인 버튼
//    @IBOutlet weak var facebookLoginButton: FBLoginButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.setLoginView()
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().signIn()
        
//        facebookLoginButton.delegate = self
//        facebookLoginButton.permissions = ["public_profile", "email"]
        
        Auth.auth().addStateDidChangeListener({ (user, err) in
            if user != nil {
                
                self.performSegue(withIdentifier: "Home", sender: nil)
            }
        })
    }
    
    func setLoginView() {
        
        
        // email field
        let email: UITextField = UITextField()
        email.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(email)
        
        email.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        email.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        email.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        email.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        self.email = email
        
        
        // password field
        let password: UITextField = UITextField()
        password.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(password)
        
        password.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        password.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        password.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        password.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        self.password = password
        
        
        // login button
        let login: UIButton = UIButton()
        login.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(login)
        
        login.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        login.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        login.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        login.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        self.loginButton = login
        
        
        // google login
        let google: UIButton = UIButton()
        google.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(google)
        
        google.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        google.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        google.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        google.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        self.googleLogin = google
        
        
    }
    
    
}

/*
extension ViewController {
    
    // Facebook login button delegate
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        //        print(result?.token?.tokenString as Any)
        if(result?.token == nil) {
            return
        }
        
        let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
        
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if error != nil {
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
}
*/

//
//  AppDelegate.swift
//  HowlFirebaseLogin
//
//  Created by 안홍석 on 2020/04/20.
//  Copyright © 2020 안홍석. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
//import FBSDKLoginKit
//import FacebookCore

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        // Use Firebase library to configure APIs
        FirebaseApp.configure()
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
//        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        
        let homeVC = ViewController()
        let mypageVC = UserViewController()
        
        homeVC.tabBarItem = UITabBarItem(tabBarSystemItem: .topRated, tag: 0)
        mypageVC.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 1)

        homeVC.view.backgroundColor = UIColor.white
        mypageVC.view.backgroundColor = UIColor.white
        
        let tb = UITabBarController()
        tb.setViewControllers([homeVC, mypageVC], animated: true)
        tb.tabBar.backgroundColor = UIColor.black
        
        window!.rootViewController = tb
        window!.makeKeyAndVisible()
        
        return true
    }
    
}


extension AppDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        // ...
        if error != nil {
            // ...
            return
        }
        
        guard let authentication = user.authentication else { return }
        
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        // ...
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if error != nil {
            // ...
            return
          }
          // User is signed in
          // ...
        }
    }
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }
    
    @available(iOS 9.0, *)
    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any])
        -> Bool {
            let google = GIDSignIn.sharedInstance().handle(url)
            
//            let facebook = ApplicationDelegate.shared.application(application, open: url, sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as! String?, annotation: options[UIApplication.OpenURLOptionsKey.annotation])
            
//            return google || facebook
            
            return google
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        let google = GIDSignIn.sharedInstance().handle(url)
        
//        let facebook = ApplicationDelegate.shared.application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
        
//        return google || facebook
        
        return google
    }
}


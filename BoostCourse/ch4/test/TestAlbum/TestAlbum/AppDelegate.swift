//
//  AppDelegate.swift
//  TestAlbum
//
//  Created by 안홍석 on 2020/03/06.
//  Copyright © 2020 안홍석. All rights reserved.
//

import UIKit
import Foundation
import Photos

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        if #available(iOS 13, *) {
            print("set in SceneDelegate")
        } else {
            
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            
            let mainViewController = mainStoryboard.instantiateViewController(withIdentifier: "MainVC") as! ViewController
            
            let navi = UINavigationController(rootViewController: mainViewController)
            navi.isToolbarHidden = true
            
            let window = UIWindow(frame: UIScreen.main.bounds)
            self.window = window
            self.window?.rootViewController = navi
            self.window?.makeKeyAndVisible()
            
        }
        
        return true
    }

    
    /*
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    */
}


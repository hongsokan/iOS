//
//  AppDelegate.swift
//  PhotosExample
//
//  Created by 안홍석 on 2020/02/20.
//  Copyright © 2020 안홍석. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let main = mainStoryboard.instantiateViewController(withIdentifier: "MainVC") as! ViewController
        
        let navi = UINavigationController(rootViewController: main)
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = navi
        self.window?.makeKeyAndVisible()
        
        return true
    }

}


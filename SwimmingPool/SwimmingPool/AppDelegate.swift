//
//  AppDelegate.swift
//  SwimmingPool
//
//  Created by 안홍석 on 2020/05/07.
//  Copyright © 2020 안홍석. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let mapVC = MapViewController()
        let poolVC = PoolViewController()
        let mypageVC = MypageViewController()
        
        mapVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        poolVC.tabBarItem = UITabBarItem(tabBarSystemItem: .featured, tag: 1)
        mypageVC.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 2)

        mapVC.view.backgroundColor = UIColor.white
        poolVC.view.backgroundColor = UIColor.white
        mypageVC.view.backgroundColor = UIColor.white
        
        let tb = UITabBarController()
        tb.setViewControllers([mapVC, poolVC, mypageVC], animated: true)
        tb.tabBar.backgroundColor = UIColor.black
        
        window!.rootViewController = tb
        window!.makeKeyAndVisible()
        
        return true
    }

}


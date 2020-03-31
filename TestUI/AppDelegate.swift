//
//  AppDelegate.swift
//  TestUI
//
//  Created by Igor Ryazancev on 3/31/20.
//  Copyright © 2020 DEVBUFF. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //load first screen
        window = UIWindow()
        window?.makeKeyAndVisible()
        let vc = AddFilterViewController(nib: R.nib.addFilterViewController)
        window?.rootViewController = vc
        
        return true
    }

}

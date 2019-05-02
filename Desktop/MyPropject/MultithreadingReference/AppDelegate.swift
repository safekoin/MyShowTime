//
//  AppDelegate.swift
//  MultithreadingReference
//
//  Created by mac on 4/22/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      
        window = UIWindow(frame: UIScreen.main.bounds)
        
        //Embed a view controller in Nav Controller programmatically
        let threadVC = ThreadViewController()
        let navigationController = UINavigationController(rootViewController: threadVC)
        
        //set the window to the nav controller
        window?.rootViewController = navigationController
        
        //make the window the start window
        window?.makeKeyAndVisible()
        

        return true
    }


    func applicationWillTerminate(_ application: UIApplication) {
       
        
        
    }


}


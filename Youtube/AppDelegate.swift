//
//  AppDelegate.swift
//  Youtube
//
//  Created by Anna Yatsun on 15/03/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator = AppCoordinator()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = coordinator.navigationController
        self.window?.makeKeyAndVisible()
        self.setup(application)
        self.coordinator.start()        
        
        return true
    }

    //  MARK: - Private API
    
    private func setup(_ application: UIApplication) {
        UINavigationBar.appearance().barTintColor = UIColor.rgb(red: 230, green: 32, blue: 31)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        
        application.statusBarStyle = .lightContent
        
        let statustBerBagraundView = UIView()
        statustBerBagraundView.backgroundColor = UIColor.rgb(red: 194, green: 31, blue: 31)
        self.window?.addSubview(statustBerBagraundView)
        
        self.window?.addConstrainsWithFormat(format: "H:|[v0]|", views: statustBerBagraundView)
        self.window?.addConstrainsWithFormat(format: "V:|[v0(20)]|", views: statustBerBagraundView)
    }
}


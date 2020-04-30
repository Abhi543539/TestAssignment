//
//  AppDelegate.swift
//  TestAssignment
//
//  Created by Abhishek Singla on 29/04/20.
//  Copyright © 2020 Abhishek Singla. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let viewController = ViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        self.window!.rootViewController = navigationController
        self.window!.makeKeyAndVisible()
        navigationController.setNavigationBarHidden(false, animated: false)
        self.window!.backgroundColor = .white
        return true
    }

}

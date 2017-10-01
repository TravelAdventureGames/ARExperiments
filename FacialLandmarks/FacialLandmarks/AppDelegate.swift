//
//  AppDelegate.swift
//  FacialLandmarks
//
//  Created by Kaira Diagne on 30-09-17.
//  Copyright © 2017 Kaira Diagne. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let rootNavigationController = UINavigationController(rootViewController: GetPhotoViewController())
        rootNavigationController.setNavigationBarHidden(true, animated: false)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = rootNavigationController
        window?.makeKeyAndVisible()
        return true
    }

}


//
//  AppDelegate.swift
//  1CShop
//
//  Created by Ronin bol on 13/11/15.
//  Copyright © 2015 rightway. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        let lock = MyApplication.sharedInstance.lock
        lock.applicationLaunchedWithOptions(launchOptions)
        return true
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        let lock = MyApplication.sharedInstance.lock
        return lock.handleURL(url, sourceApplication: sourceApplication)
    }
}


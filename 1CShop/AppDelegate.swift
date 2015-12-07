//
//  AppDelegate.swift
//  1CShop
//
//  Created by Ronin bol on 13/11/15.
//  Copyright © 2015 rightway. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        let lock = MyApplication.sharedInstance.lock
        lock.applicationLaunchedWithOptions(launchOptions)
        
        let config = Realm.Configuration(
            // Set the new schema version. This must be greater than the previously used
            // version (if you've never set a schema version before, the version is 0).
            schemaVersion: 5,
            
            // Set the block which will be called automatically when opening a Realm with
            // a schema version lower than the one set above
            migrationBlock: { migration, oldSchemaVersion in
                // We haven’t migrated anything yet, so oldSchemaVersion == 0
                if (oldSchemaVersion < 1) {
                    // Nothing to do!
                    // Realm will automatically detect new properties and removed properties
                    // And will update the schema on disk automatically
                    
                }

                if (oldSchemaVersion < 3) {
                    // Nothing to do!
                    // Realm will automatically detect new properties and removed properties
                    // And will update the schema on disk automatically
                    migration.enumerate(PriceInformationRegister.className()) { oldObject, newObject in
                        // combine name fields into a single field
                        
                        
                        newObject!["refKey"] = "\(oldObject!["nomenclatureKey"])|\(oldObject!["характеристикаKey"])|\(oldObject!["видЦеныKey")"
                    }
                }
                if (oldSchemaVersion < 5) {
                    // Nothing to do!
                    // Realm will automatically detect new properties and removed properties
                    // And will update the schema on disk automatically
                    
                }

        })
        
        // Tell Realm to use this new configuration object for the default Realm
        Realm.Configuration.defaultConfiguration = config
        
        // Now that we've told Realm how to handle the schema change, opening the file
        // will automatically perform the migration
        let realm = try! Realm()
        
        
        return true
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        let lock = MyApplication.sharedInstance.lock
        return lock.handleURL(url, sourceApplication: sourceApplication)
    }
}


//
//  MyApplication.swift
//  1CShop
//
//  Created by Ronin bol on 13/11/15.
//  Copyright © 2015 rightway. All rights reserved.
//

import UIKit
import SimpleKeychain
import Lock
import LockFacebook

class MyApplication: NSObject {
    
    static let sharedInstance = MyApplication()
    
    let keychain: A0SimpleKeychain
    let lock: A0Lock
    
    private override init() {
        keychain = A0SimpleKeychain(service: "Auth0")
        lock = A0Lock.newLock()
    }
}

//
//  CatalogViewController.swift
//  1CShop
//
//  Created by Ronin bol on 17/11/15.
//  Copyright © 2015 rightway. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift
import Realm
import Alamofire

class CatalogViewController: UITableViewController {
    
    let realm = try! Realm()
    let array = try! Realm().objects(NomenclatureCatalog).sorted("descriptionField")
    var notificationToken: NotificationToken?
    
    class Cell: UITableViewCell {
        override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
            super.init(style: .Subtitle, reuseIdentifier: reuseIdentifier)
        }
        
        required init(coder: NSCoder) {
            fatalError("NSCoding not supported")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print(Realm.Configuration.defaultConfiguration.description)
        setupUI()
        
        // Set realm notification block
        notificationToken = realm.addNotificationBlock { [unowned self] note, realm in
            self.tableView.reloadData()
        }
        
        tableView.reloadData()
    }
    // UI
    
    func setupUI() {
        tableView.registerClass(Cell.self, forCellReuseIdentifier: "cell")
        
        self.title = "TableView"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "BG Add", style: .Plain, target: self, action: "backgroundAdd")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "add")
    }
    
    // Table view data source
    
    override func tableView(tableView: UITableView?, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! Cell
        
        let object = array[indexPath.row]
        cell.textLabel?.text = object.code
        cell.detailTextLabel?.text = object.descriptionField
        
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            realm.beginWrite()
            realm.delete(array[indexPath.row])
            try! realm.commitWrite()
        }
    }
    
    // Actions
    
    func backgroundAdd() {
        let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        // Import many items in a background thread
        dispatch_async(queue) {
            // Get new realm and table since we are in a new thread
            let realm = try! Realm()
            realm.beginWrite()
            for _ in 0..<5 {
                // Add row via dictionary. Order is ignored.
                realm.create(NomenclatureCatalog.self, value: ["code": CatalogViewController.randomString(), "descriptionField": CatalogViewController.randomString()])
            }
            try! realm.commitWrite()
        }
    }
    
    func add() {
        
        
        let user = "user"
        let password = "password"
        
        let credentialData = "\(user):\(password)".dataUsingEncoding(NSUTF8StringEncoding)!
        let base64Credentials = credentialData.base64EncodedStringWithOptions([])
        
        let headers = ["Authorization": "Basic \(base64Credentials)"]
        
        Alamofire.request(.GET, "http://85.236.15.246/Demo_UT/odata/standard.odata/Catalog_%D0%9D%D0%BE%D0%BC%D0%B5%D0%BD%D0%BA%D0%BB%D0%B0%D1%82%D1%83%D1%80%D0%B0(guid'9b137475-35ed-11e5-940e-e41f133f24ac')?$format=json", headers: headers)
            .responseJSON { response in
                debugPrint(response)
        }
        /*Alamofire.request(.GET, "http://85.236.15.246/Demo_UT/odata/standard.odata/Catalog_%D0%9D%D0%BE%D0%BC%D0%B5%D0%BD%D0%BA%D0%BB%D0%B0%D1%82%D1%83%D1%80%D0%B0(guid'9b137475-35ed-11e5-940e-e41f133f24ac')?$format=json")
            .responseJSON { response in
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization
                
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                }
        }*/
        /*realm.beginWrite()
        realm.create(NomenclatureCatalog.self, value: ["code": CatalogViewController.randomString(), "descriptionField": CatalogViewController.randomString()])
        try! realm.commitWrite()*/
    }
    
    // Helpers
    
    class func randomString() -> String {
        return "Title \(arc4random())"
    }
    
    class func randomDate() -> NSDate {
        return NSDate(timeIntervalSince1970: NSTimeInterval(arc4random()))
    }


}
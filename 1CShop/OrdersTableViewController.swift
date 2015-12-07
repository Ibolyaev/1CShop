//
//  OrdersTableViewController.swift
//  1CShop
//
//  Created by Ronin bol on 07/12/15.
//  Copyright © 2015 rightway. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift
import SwiftyJSON
import Alamofire


class OrdersTableViewController:UITableViewController {
    
    let realm = try! Realm()
    let array = try! Realm().objects(OrderDocument)
    var notificationToken: NotificationToken?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupDemoBase()
        
        setupUI()
            
        // Set realm notification block
        notificationToken = realm.addNotificationBlock { [unowned self] note, realm in
            self.tableView.reloadData()
        }
        
        tableView.reloadData()

    }
    
    func setupDemoBase() {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject("http://85.236.15.246", forKey: "address")
        defaults.setObject("Demo_UT", forKey: "baseName")
        defaults.setObject(true, forKey: "demoMode")
        defaults.setObject("test", forKey: "user")
        defaults.setObject("111", forKey: "password")
    }
    
    
    // UI
    
    func setupUI() {
        //tableView.registerClass(TableViewCell.self, forCellReuseIdentifier: "cell")
        
        self.tabBarController?.navigationItem.leftBarButtonItems?.append(UIBarButtonItem(title: "BG Add", style: .Plain, target: self, action: "backgroundAdd"))
        //self.tabBarController?.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "BG Add", style: .Plain, target: self, action: "backgroundAdd")
        self.tabBarController?.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "add")
    }
    
    // Table view data source
    
    override func tableView(tableView: UITableView?, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Subtitle, reuseIdentifier: "")
        
        let object = array[indexPath.row]
        
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.LongStyle
        formatter.timeStyle = .ShortStyle
        
        let dateString = formatter.stringFromDate(object.date)
    
        cell.detailTextLabel?.text = dateString
        cell.textLabel?.text = object.number
        
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            realm.beginWrite()
            realm.delete(array[indexPath.row])
            try! realm.commitWrite()
        }
    }

    
    func add() {
        
        try! realm.write {
            self.realm.deleteAll()
        }
        let defaults = NSUserDefaults.standardUserDefaults()
        
        
        let connector = OdataConnector()
        connector.setCollectionName(OrderDocument.getCollectionName())
        
        let URLString = connector.getTextRequestToCollection(nil)
        
        
        let user = defaults.stringForKey("user")!
        let password = defaults.stringForKey("password")!
        let credentialData = "\(user):\(password)".dataUsingEncoding(NSUTF8StringEncoding)!
        let base64Credentials = credentialData.base64EncodedStringWithOptions([])
        
        let headers = ["Authorization": "Basic \(base64Credentials)"]
        
        //load prices
        connector.setCollectionName(PriceInformationRegister.getCollectionName())
        
        Alamofire.request(.GET, URLString, headers: headers)
            .responseCollection { (response: Response<[OrderDocument], NSError>) in
                debugPrint(response)
                if let value = response.result.value {
                    
                    for element in value{
                        try! self.realm.write({
                            self.realm.add(element)
                        })
                    }
                }
        }
    }


}



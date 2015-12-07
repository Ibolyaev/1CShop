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
import SwiftyJSON
import Alamofire

class CatalogViewController: UITableViewController {
    
    let realm = try! Realm()
    let array = try! Realm().objects(NomenclatureCatalog).sorted("descriptionField")
    var notificationToken: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDemoBase()
        print(Realm.Configuration.defaultConfiguration.description)
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
        let cell = tableView.dequeueReusableCellWithIdentifier("TableViewCell", forIndexPath: indexPath) as! TableViewCell
        
        let object = array[indexPath.row]
                
        cell.descriptionLabel?.text = object.descriptionField
        
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        formatter.locale = NSLocale(localeIdentifier: "ru_RU")
        
        
        cell.priceLabel.text = formatter.stringFromNumber(object.price)
        
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
     
        }
    }
    
    func add() {
        
        try! realm.write {
            self.realm.deleteAll()
        }
        let defaults = NSUserDefaults.standardUserDefaults()
        
        
        let connector = OdataConnector()
        connector.setCollectionName(NomenclatureCatalog.getCollectionName())
        
        let URLString = connector.getTextRequestToCollection(nil)
        
        // TODO
        //need to add produt guid to get just one picture (guid'9b137475-35ed-11e5-940e-e41f133f24ac')
        
        /*let URLString = "http://85.236.15.246/Demo_UT/odata/standard.odata/InformationRegister_%D0%9F%D1%80%D0%B8%D1%81%D0%BE%D0%B5%D0%B4%D0%B8%D0%BD%D0%B5%D0%BD%D0%BD%D1%8B%D0%B5%D0%A4%D0%B0%D0%B9%D0%BB%D1%8B?$format=json"*/
        
        //let URLString = "http://85.236.15.246/Demo_UT/odata/standard.odata/Catalog_%D0%9D%D0%BE%D0%BC%D0%B5%D0%BD%D0%BA%D0%BB%D0%B0%D1%82%D1%83%D1%80%D0%B0?$format=json"
        
        /*let URLString = "http://85.236.15.246/Demo_UT/odata/standard.odata/Catalog_%D0%9D%D0%BE%D0%BC%D0%B5%D0%BD%D0%BA%D0%BB%D0%B0%D1%82%D1%83%D1%80%D0%B0?$format=json"*/
        
        let user = defaults.stringForKey("user")!
        let password = defaults.stringForKey("password")!
        let credentialData = "\(user):\(password)".dataUsingEncoding(NSUTF8StringEncoding)!
        let base64Credentials = credentialData.base64EncodedStringWithOptions([])
        
        let headers = ["Authorization": "Basic \(base64Credentials)"]
        
        //load prices
        connector.setCollectionName(PriceInformationRegister.getCollectionName())
        
        Alamofire.request(.GET, URLString, headers: headers)
            .responseCollection { (response: Response<[NomenclatureCatalog], NSError>) in
                debugPrint(response)
                if let value = response.result.value {
                
                    for element in value{
                        try! self.realm.write({
                            self.realm.add(element)
                        })
                    }
                    
                    Alamofire.request(.GET, connector.getTextRequestToCollection(nil), headers: headers)
                        .responseCollection { (response: Response<[PriceInformationRegister], NSError>) in
                            debugPrint(response)
                            if let value = response.result.value {
                                try! self.realm.write({
                                    self.realm.add(value)
                                })
                            }
                    }
                    
                }
                                
                if let errorData = response.data {
                    let errorJson = JSON(errorData)
                    debugPrint(errorJson)
                }
        }
        
    }
    
}
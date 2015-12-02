//
//  Connector.swift
//  1CShop
//
//  Created by Игорь Боляев on 25.11.15.
//  Copyright © 2015 rightway. All rights reserved.
//

import Foundation

class OdataConnector:NSObject {
    
    // Temp variable for any received data through the connection.
    internal var _data: NSMutableData = NSMutableData()
    
    
    // NSUserDefaults for accessing the stored username and password if required.
    internal var _userDefaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
    
    // oData components
    internal var _collection: NSString = "/Catalog_Партнеры?"
    
    internal var timesOfdidReceiveAuthenticationChallenge: Int = 0
    
    
    // oData query filter
    internal let _formatString: NSString = "$format=json"     // We always use Json for efficiency.
    internal var _filter: OdataFilter = OdataFilter()
    
    
    
    func setCollectionName(collectionName:NSString){
        self._collection = collectionName
    }
    
    // Make a request to the configured collection.
    func getTextRequestToCollection(filter: OdataFilter?)->String {
        
        if let filter = filter {
          self._filter = filter
        }
        
                
        return self._constructOdataRequestURL().stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        
    }
    
    // ======================================================================
    // MARK: - Internal/Private Methods
    
    internal func _constructOdataRequestURL() -> NSString{
        
        // FIXME: Change the base URL.
        
        // Always start as the Base URL with the collection and the format string.
        let defaults = NSUserDefaults.standardUserDefaults()
        let address = defaults.stringForKey("address")
        let baseName = defaults.stringForKey("baseName")
        
        let baseURL: NSString = "\(address!)/\(baseName!)/odata/standard.odata" + (self._collection as String) + (self._formatString as String)
        
        
        // Finally we format all the values into the final URL.
        return NSString(format: "%@%@", baseURL, self._filter.getFilterString())
    }


    
}

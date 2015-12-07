//
//  OrderNomenclature.swift
//  1CShop
//
//  Created by Ronin bol on 07/12/15.
//  Copyright © 2015 rightway. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

final class OrderNomenclature: Object, ResponseObjectSerializable, ResponseCollectionSerializable {
    
    dynamic var refKey : String!
    
    required convenience init(response: NSHTTPURLResponse, representation: JSON)	{
    
        self.init()
        let dictionary = representation.dictionaryObject!
        
        if let refKey = dictionary["refKey"] as? String{
            self.refKey = refKey
        }

    
    }
    
    static func collection(response response: NSHTTPURLResponse, representation: JSON) -> [OrderNomenclature] {
        var products: [OrderNomenclature] = []
        
        for (index,subJson):(String, JSON) in representation["value"] {
            
            products.append(OrderNomenclature(response: response, representation: subJson))
            
        }
        
        return products
    }
    

}
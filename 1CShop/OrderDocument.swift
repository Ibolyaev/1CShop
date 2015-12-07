//
//	OrderDocument.swift
//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport


import RealmSwift
import SwiftyJSON

final class OrderDocument : Object, ResponseObjectSerializable, ResponseCollectionSerializable{
	
	dynamic var date : NSDate!
	dynamic var number : String!
	dynamic var refKey : String!
    dynamic var sum : Double = 0
    
    required convenience init(response: NSHTTPURLResponse, representation: JSON)	{
        self.init()
        
        let dictionary = representation.dictionaryObject!
        
        if let dateValue = dictionary["Date"] as? String{
            
            var dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'hh:mm:ss"
            
            self.date = dateFormatter.dateFromString(dateValue)!
        }
        
        if let numberValue = dictionary["Number"] as? String{
            self.number = numberValue
        }
        
        if let refKeyValue = dictionary["Ref_Key"] as? String{
            self.refKey = refKeyValue
        }
        if let sumValue = dictionary["суммаДокумента"] as? Double{
            self.sum = sumValue
        }
        
    }
    

    static func collection(response response: NSHTTPURLResponse, representation: JSON) -> [OrderDocument] {
        var products: [OrderDocument] = []
        
        for (index,subJson):(String, JSON) in representation["value"] {
            
            products.append(OrderDocument(response: response, representation: subJson))
            
        }
        
        return products
    }
    
    class func getCollectionName() -> String {
        return "/Document_ЗаказКлиента?"
    }
    
    
	
    }
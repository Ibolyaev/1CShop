//
//	PriceInformationRegister.swift
//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport


import RealmSwift
import SwiftyJSON

final class PriceInformationRegister : Object, ResponseObjectSerializable, ResponseCollectionSerializable {

	dynamic var period : String!
	dynamic var recorder : String!
	dynamic var recorderType : String!
	dynamic var валютаKey : String!
	dynamic var видЦеныKey : String!
	dynamic var номенклатураnavigationLinkUrl : String!
	dynamic var nomenclatureKey : String!
	dynamic var упаковкаKey : String!
	dynamic var характеристикаKey : String!
	dynamic var цена : Double = 0
    dynamic var refKey: String!
    
    override static func primaryKey() -> String? {
        return "refKey"
    }

	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	convenience required init(response: NSHTTPURLResponse, representation: JSON) {	
        self.init()
        let dictionary = representation.dictionaryObject!
        
		if let periodValue = dictionary["Period"] as? String{
			self.period = periodValue
		}
		if let recorderValue = dictionary["Recorder"] as? String{
			self.recorder = recorderValue
		}
		if let recorderTypeValue = dictionary["Recorder_Type"] as? String{
			self.recorderType = recorderTypeValue
		}
		if let валютаKeyValue = dictionary["Валюта_Key"] as? String{
			self.валютаKey = валютаKeyValue
		}
		if let видЦеныKeyValue = dictionary["ВидЦены_Key"] as? String{
			self.видЦеныKey = видЦеныKeyValue
		}
		if let номенклатураnavigationLinkUrlValue = dictionary["Номенклатура@navigationLinkUrl"] as? String{
			self.номенклатураnavigationLinkUrl = номенклатураnavigationLinkUrlValue
		}
		if let номенклатураKeyValue = dictionary["Номенклатура_Key"] as? String{
			self.nomenclatureKey = номенклатураKeyValue
		}
		if let упаковкаKeyValue = dictionary["Упаковка_Key"] as? String{
			self.упаковкаKey = упаковкаKeyValue
		}
		if let характеристикаKeyValue = dictionary["Характеристика_Key"] as? String{
			self.характеристикаKey = характеристикаKeyValue
		}
		if let ценаValue = dictionary["Цена"] as? Double{
			self.цена = ценаValue
		}
        
        self.refKey = "\(self.nomenclatureKey!)|\(self.характеристикаKey!)|\(self.видЦеныKey!)"
        //print(self.refKey )
		
	}
    static func collection(response response: NSHTTPURLResponse, representation: JSON) -> [PriceInformationRegister] {
        var products: [PriceInformationRegister] = []
        
        for (index,subJson):(String, JSON) in representation["value"] {
            //print(subJson)
            products.append(PriceInformationRegister(response: response, representation: subJson))
            
            
            
            /*for (index,subJsonRecordSet):(String, JSON) in subJson["RecordSet"] {
            
            }*/
            
            
        }
        
        return products
    }
    
    class func getCollectionName() -> String {
        return "/InformationRegister_ЦеныНоменклатуры_RecordType/SliceLast()?"
    }

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		var dictionary = NSMutableDictionary()
		if period != nil{
			dictionary["Period"] = period
		}
		if recorder != nil{
			dictionary["Recorder"] = recorder
		}
		if recorderType != nil{
			dictionary["Recorder_Type"] = recorderType
		}
		if валютаKey != nil{
			dictionary["Валюта_Key"] = валютаKey
		}
		if видЦеныKey != nil{
			dictionary["ВидЦены_Key"] = видЦеныKey
		}
		if номенклатураnavigationLinkUrl != nil{
			dictionary["Номенклатура@navigationLinkUrl"] = номенклатураnavigationLinkUrl
		}
		if nomenclatureKey != nil{
			dictionary["Номенклатура_Key"] = nomenclatureKey
		}
		if упаковкаKey != nil{
			dictionary["Упаковка_Key"] = упаковкаKey
		}
		if характеристикаKey != nil{
			dictionary["Характеристика_Key"] = характеристикаKey
		}
		dictionary["Цена"] = цена
		return dictionary
	}

    
}
//
//	PriceInformationRegister.swift
//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport


import RealmSwift

class PriceInformationRegister : Object {

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
	class func fromDictionary(dictionary: NSDictionary) -> PriceInformationRegister	{
		let this = PriceInformationRegister()
		if let periodValue = dictionary["Period"] as? String{
			this.period = periodValue
		}
		if let recorderValue = dictionary["Recorder"] as? String{
			this.recorder = recorderValue
		}
		if let recorderTypeValue = dictionary["Recorder_Type"] as? String{
			this.recorderType = recorderTypeValue
		}
		if let валютаKeyValue = dictionary["Валюта_Key"] as? String{
			this.валютаKey = валютаKeyValue
		}
		if let видЦеныKeyValue = dictionary["ВидЦены_Key"] as? String{
			this.видЦеныKey = видЦеныKeyValue
		}
		if let номенклатураnavigationLinkUrlValue = dictionary["Номенклатура@navigationLinkUrl"] as? String{
			this.номенклатураnavigationLinkUrl = номенклатураnavigationLinkUrlValue
		}
		if let номенклатураKeyValue = dictionary["Номенклатура_Key"] as? String{
			this.nomenclatureKey = номенклатураKeyValue
		}
		if let упаковкаKeyValue = dictionary["Упаковка_Key"] as? String{
			this.упаковкаKey = упаковкаKeyValue
		}
		if let характеристикаKeyValue = dictionary["Характеристика_Key"] as? String{
			this.характеристикаKey = характеристикаKeyValue
		}
		if let ценаValue = dictionary["Цена"] as? Double{
			this.цена = ценаValue
		}
        
        this.refKey = "\(this.nomenclatureKey!)|\(this.характеристикаKey!)|\(this.видЦеныKey!)"
        
		return this
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
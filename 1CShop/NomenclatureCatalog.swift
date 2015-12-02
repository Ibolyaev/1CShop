//
//	NomenclatureCatalog.swift

import RealmSwift
import SwiftyJSON

final class NomenclatureCatalog : Object, ResponseObjectSerializable, ResponseCollectionSerializable  {

	dynamic var code : String! = ""
	dynamic var deletionMark : Bool = false
	dynamic var descriptionField : String! = ""
	dynamic var isFolder : Bool = false
	dynamic var parentKey : String! = ""
	dynamic var refKey : String! = ""
	dynamic var odatametadata : String! = ""
	dynamic var описание : String! = ""
    dynamic var файлКартинкиKey : String! = ""
    
    /*dynamic var imageUrl : String! = "http://85.236.15.246/Demo_UT/odata/standard.odata/InformationRegister_%D0%9F%D1%80%D0%B8%D1%81%D0%BE%D0%B5%D0%B4%D0%B8%D0%BD%D0%B5%D0%BD%D0%BD%D1%8B%D0%B5%D0%A4%D0%B0%D0%B9%D0%BB%D1%8B?$format=json"*/
    dynamic var imageUrl : String! = "http://85.236.15.246/"
    
    override static func primaryKey() -> String? {
        return "refKey"
    }
    dynamic var price : Double {
        get{
            
            if self.refKey != ""{
                
                print(self.refKey)
                
                let realm = try! Realm()
                
                let prices = realm.objects(PriceInformationRegister).filter("nomenclatureKey = '\(self.refKey)'")
                   
                for price in prices {
                    return price.цена
                }
            }
            
            return 0
            
        }
    }
    
    convenience required init(response: NSHTTPURLResponse, representation: JSON) {
        self.init()
        let dictionary = representation.dictionaryObject!
        
        if let codeValue = dictionary["Code"] as? String{
            self.code = codeValue
        }
        if let deletionMarkValue = dictionary["DeletionMark"] as? Bool{
            self.deletionMark = deletionMarkValue
        }
        if let descriptionFieldValue = dictionary["Description"] as? String{
            self.descriptionField = descriptionFieldValue
        }
        if let isFolderValue = dictionary["IsFolder"] as? Bool{
            self.isFolder = isFolderValue
        }
        if let parentKeyValue = dictionary["Parent_Key"] as? String{
            self.parentKey = parentKeyValue
        }
        if let refKeyValue = dictionary["Ref_Key"] as? String{
            self.refKey = refKeyValue
        }
        if let odatametadataValue = dictionary["odata.metadata"] as? String{
            self.odatametadata = odatametadataValue
        }
        if let описаниеValue = dictionary["Описание"] as? String{
            self.описание = описаниеValue
        }
        
        if let файлКартинкиKeyValue = dictionary["ФайлКартинки_Key"] as? String{
            self.файлКартинкиKey = файлКартинкиKeyValue
        }
        
    }
    
    static func collection(response response: NSHTTPURLResponse, representation: JSON) -> [NomenclatureCatalog] {
        var products: [NomenclatureCatalog] = []
        
        for (index,subJson):(String, JSON) in representation["value"] {
            
            products.append(NomenclatureCatalog(response: response, representation: subJson))
            
        }
        
        return products
    }
    
    class func getCollectionName() -> String {
        return "/Catalog_Номенклатура?"
    }
    
    
    @objc func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(code, forKey: "code")
        aCoder.encodeObject(deletionMark, forKey: "deletionMark")
        aCoder.encodeObject(descriptionField, forKey: "descriptionField")
        aCoder.encodeObject(isFolder, forKey: "isFolder")
        aCoder.encodeObject(parentKey, forKey: "parentKey")
        aCoder.encodeObject(refKey, forKey: "refKey")
        aCoder.encodeObject(odatametadata, forKey: "odatametadata")
        aCoder.encodeObject(описание, forKey: "описание")
        aCoder.encodeObject(файлКартинкиKey, forKey: "файлКартинкиKey")
    }
    
    /**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if code != nil{
			dictionary["Code"] = code
		}
		dictionary["DeletionMark"] = deletionMark
		if descriptionField != nil{
			dictionary["Description"] = descriptionField
		}
		dictionary["IsFolder"] = isFolder
		if parentKey != nil{
			dictionary["Parent_Key"] = parentKey
		}
		if refKey != nil{
			dictionary["Ref_Key"] = refKey
		}
		if odatametadata != nil{
			dictionary["odata.metadata"] = odatametadata
		}
		if описание != nil{
			dictionary["Описание"] = описание
		}
		if файлКартинкиKey != nil{
			dictionary["ФайлКартинки_Key"] = файлКартинкиKey
		}
		return dictionary
	}
   
}

    
    
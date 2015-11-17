//
//	NomenclatureCatalog.swift
//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport


import RealmSwift
import Realm
import SwiftyJSON

class NomenclatureCatalog : Object {

	dynamic var code : String! = ""
	dynamic var deletionMark : Bool = false
	dynamic var descriptionField : String! = ""
	dynamic var isFolder : Bool = false
	dynamic var parentKey : String! = ""
	dynamic var refKey : String! = ""
	dynamic var odatametadata : String! = ""
	dynamic var описание : String! = ""
    dynamic var файлКартинкиKey : String! = ""
    
    
	
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

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    
    
    
    /*init (value: JSON!){
        if value == nil{
            return
        }
        super.init()
        
        code = value["Code"].stringValue
        deletionMark = value["DeletionMark"].boolValue
        descriptionField = value["Description"].stringValue
        isFolder = value["IsFolder"].boolValue
        parentKey = value["Parent_Key"].stringValue
        refKey = value["Ref_Key"].stringValue
        odatametadata = value["odata.metadata"].stringValue
        описание = value["Описание"].stringValue
        файлКартинкиKey = value["ФайлКартинки_Key"].stringValue
        
    }

    required init() {
        super.init()
        fatalError("init() has not been implemented")
    }*/

    
    
    
}

    
    
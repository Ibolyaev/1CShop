//
//  CatalogCollectionView.swift
//  1CShop
//
//  Created by Ronin bol on 24/11/15.
//  Copyright © 2015 rightway. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift
import SwiftyJSON
import Alamofire
import AlamofireImage

class CatalogCollectionView: UICollectionView {
    
    let realm = try! Realm()
    let array = try! Realm().objects(NomenclatureCatalog).sorted("descriptionField")
    var notificationToken: NotificationToken?
    lazy var placeholderImage: UIImage = {
        let image = UIImage(named: "Placeholder Image")!
        return image
    }()
    let imageCache = AutoPurgingImageCache()
    
    
    
    
}
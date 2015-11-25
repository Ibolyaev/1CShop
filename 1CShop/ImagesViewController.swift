
import Alamofire
import AlamofireImage
import Foundation
import UIKit
import RealmSwift
import SwiftyJSON

class ImagesViewController: UIViewController {
    
    let realm = try! Realm()
    let products = try! Realm().objects(NomenclatureCatalog).sorted("descriptionField")
    var notificationToken: NotificationToken?
    
    lazy var placeholderImage: UIImage = {
        let image = UIImage(named: "Placeholder Image")!
        return image
    }()
    
    let imageCache = AutoPurgingImageCache()
    
    //@IBOutlet weak var collectionView: UICollectionView!
    var collectionView: UICollectionView!
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        preLoadPictures()
        
        setUpCollectionView()
    }
    
    // MARK: Private - Setup
    
    private func preLoadPictures() {
        
        try! realm.write {
            self.realm.deleteAll()
        }
        
        let user = "test"
        let password = "111"
        
        let credentialData = "\(user):\(password)".dataUsingEncoding(NSUTF8StringEncoding)!
        let base64Credentials = credentialData.base64EncodedStringWithOptions([])
        
        let headers = ["Authorization": "Basic \(base64Credentials)"]
        // TODO
        //need to add produt guid to get just one picture
        
        /*let URLString = "http://85.236.15.246/Demo_UT/odata/standard.odata/InformationRegister_%D0%9F%D1%80%D0%B8%D1%81%D0%BE%D0%B5%D0%B4%D0%B8%D0%BD%D0%B5%D0%BD%D0%BD%D1%8B%D0%B5%D0%A4%D0%B0%D0%B9%D0%BB%D1%8B?$format=json"*/
        
        //let URLString = "http://85.236.15.246/Demo_UT/odata/standard.odata/Catalog_%D0%9D%D0%BE%D0%BC%D0%B5%D0%BD%D0%BA%D0%BB%D0%B0%D1%82%D1%83%D1%80%D0%B0?$format=json"
        
        let URLString = "http://85.236.15.246/Demo_UT/odata/standard.odata/Catalog_%D0%9D%D0%BE%D0%BC%D0%B5%D0%BD%D0%BA%D0%BB%D0%B0%D1%82%D1%83%D1%80%D0%B0(guid'9b137475-35ed-11e5-940e-e41f133f24ac')?$format=json"
        
        //test
        Alamofire.request(.GET, URLString, headers: headers)
            .responseObject { (response: Response<NomenclatureCatalog, NSError>) in
                debugPrint(response)
        }
        
        
        
        
        
        /*Alamofire.request(.GET, URLString, headers: headers)
            .responseJSON { response in
                switch response.result {
                case .Success:
                    if let value = response.result.value {
                        /*
                        ПрисоединенныйФайл" : "9b137477-35ed-11e5-940e-e41f133f24ac",
                        "ПрисоединенныйФайл_Type" : "StandardODATA.Catalog_НоменклатураПрисоединенныеФайлы",
                        "ХранимыйФайл_Type" : "application\/octet-stream",*/
                        let json = JSON(value)
                        //print(json)
                        for (index,subJson):(String, JSON) in json["value"] {
                            
                            let base64String = subJson["ХранимыйФайл_Base64Data"].stringValue
                            let data = NSData(base64EncodedString: base64String, options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters)
                            if let decodedData = data {
                                
                                let image = Image(data: decodedData)
                                
                                //let a = NSURLRequest(URL: NSURL(string: subJson["ПрисоединенныйФайл"].stringValue)!)
                                //self.imageCache.addImage(image!, forRequest: a)
                                self.imageCache.addImage(image!, withIdentifier: subJson["ПрисоединенныйФайл"].stringValue)
                                self.collectionView.reloadData()
                                
                            }
                            
                        }
                        
                    }
                case .Failure(let error):
                    print(error)
                }
        }*/

        
    }
    
    private func setUpCollectionView() {
        collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = UIColor.whiteColor()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.registerClass(ImageCell.self, forCellWithReuseIdentifier: ImageCell.ReuseIdentifier)
        
        view.addSubview(self.collectionView)
        
        collectionView.frame = self.view.bounds
        collectionView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
    }
    
    private func sizeForCollectionViewItem() -> CGSize {
        let viewWidth = view.bounds.size.width
        
        var cellWidth = (viewWidth - 4 * 8) / 3.0
        
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            cellWidth = (viewWidth - 7 * 8) / 6.0
        }
        
        return CGSize(width: cellWidth, height: cellWidth)
    }
}

// MARK: - UICollectionViewDataSource

extension ImagesViewController : UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(
        collectionView: UICollectionView,
        cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(ImageCell.ReuseIdentifier, forIndexPath: indexPath) as! ImageCell
        let product = products[indexPath.row]
        
        cell.configureCellWithURLString(product.файлКартинкиKey, placeholderImage: placeholderImage)
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ImagesViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(
        collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        return sizeForCollectionViewItem()
    }
    
    func collectionView(
        collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAtIndex section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
    
    func collectionView(
        collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat
    {
        return 8.0
    }
    
    func collectionView(
        collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat
    {
        return 8.0
    }
}

// MARK: - UICollectionViewDelegate

extension ImagesViewController : UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let product = self.products[indexPath.row]
        
        /*let imageViewController = ImageViewController()
        imageViewController.gravatar = gravatar
        
        self.navigationController?.pushViewController(imageViewController, animated: true)*/
    }
}

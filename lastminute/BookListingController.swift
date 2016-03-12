//
//  BookListingController.swift
//  lastminute
//
//  Created by stuart on 3/3/16.
//  Copyright © 2016 lastminute. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class BookListingController : UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var cv: UICollectionView!
    
    var pfs: [ProductForSale] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(UInt64(NSDate().timeIntervalSince1970))
        
        let parameters = [
            "date": "1457660629",
            "keyword": "BEFORE"
        ]
        //let encoding = Alamofire.ParameterEncoding.JSON
        
        
        Alamofire.request(.POST, "http://52.20.241.139/api/v1.0/productsforsale", parameters: parameters, encoding: .JSON)
            .responseJSON { response in
                //print(response.request)  // original URL request
                print("RESPONSE CODE: \(response.response)") // URL response
                //print(response.data)     // server data
                //print(response.result)   // result of response serialization
                
                if let JSON = response.result.value {
                    //print("JSON: \(JSON)")
                    
                    let products = JSON.valueForKey("products") as! NSArray
                    
                    for item in products {
                        
                        self.pfs.append(
                            ProductForSale(
                                barcode: item.valueForKey("barcode") as? String,
                                categoryid: item.valueForKey("category") as? Int,
                                creator: item.valueForKey("creator") as? String,
                                datecreated: item.valueForKey("datecreated") as? String,
                                dateupdated: item.valueForKey("dateupdated") as? String,
                                imageurl: item.valueForKey("imageurl") as? String,
                                name: item.valueForKey("name") as? String,
                                orderid: item.valueForKey("orderid") as? String,
                                ownerid: item.valueForKey("ownerid") as? String,
                                price: item.valueForKey("price") as? String,
                                productid: item.valueForKey("productid") as? String,
                                secondarybarcode: item.valueForKey("secondarybarcode") as? String))
                    }
                    
                    self.cv.reloadData()
                }
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if (self.pfs.count != 0) {
            return self.pfs.count
        } else {
            return 10
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        //releases resources the TableCell contains for reuse. Reduces performance/memory impact of scrolling
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("BookItemCell", forIndexPath: indexPath) as UICollectionViewCell
        
        //Set up title of book/item in listing
        if self.pfs.count != 0 {
            
            //Set up Title/Product name
            if let ct = cell.viewWithTag(1) as! UILabel? {
                var name: String! = ""
                
                //unwrap variables
                if self.pfs[indexPath.row].name != nil{
                    name = self.pfs[indexPath.row].name
                }
                ct.text = name
            }
            
            //Set up Author/Creator
            if let ct = cell.viewWithTag(2) as! UILabel? {
                var creator: String! = ""
                
                //unwrap variables
                if self.pfs[indexPath.row].name != nil{
                    creator = self.pfs[indexPath.row].creator
                }
                ct.text = creator
            }
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize{
        
        return CGSize(width: 180, height: 180)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

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
    
    var isLoggedIn: Bool = false
    var aUser: User? = nil
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    @IBAction func viewProfile(sender: AnyObject) {
        if(isLoggedIn) {
            self.performSegueWithIdentifier("profile_seg", sender: self)
        } else {
            self.performSegueWithIdentifier("log_seg", sender: self)
        }
    }
    
    @IBAction func postNewBook(sender: AnyObject) {
        if(isLoggedIn){
            //let ppvc: UIViewController = (self.storyboard?.instantiateViewControllerWithIdentifier("postProductVC"))!
            //self.navigationController?.pushViewController(ppvc, animated: true)
            self.performSegueWithIdentifier("post_seg", sender: self)
        } else {
            self.performSegueWithIdentifier("log_seg", sender: self)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "log_seg") {
            //var svc = segue!.destinationViewController as secondViewController;
            let naVC: AuthenticationNavController = segue.destinationViewController as! AuthenticationNavController
            naVC.setIt("EY BITCH!!")
        }
        if (isLoggedIn && segue.identifier == "profile_seg") {
            let profileVC: ProfileViewController = segue.destinationViewController as! ProfileViewController
            profileVC.transferUser(aUser!)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationItem.backBarButtonItem = UIBarButtonItem(title: "TEST!", style: UIBarButtonItemStyle(rawValue: 0)!, target: nil, action: nil)
        
        self.automaticallyAdjustsScrollViewInsets = false //shifts table up since its knocked out of line with navcontroller
        
        print(String(UInt64(NSDate().timeIntervalSince1970))) //gets epoch of current time
        //let epoch: String? = String(UInt64(NSDate().timeIntervalSince1970))
        
        let parameters: [String:String] = [
            "date": "1460504108",
            "keyword": "BEFORE"
        ]
        
        let userDB: UserDBManager = UserDBManager()
        userDB.create() //connects to the SQLite
        isLoggedIn = userDB.isLoggedIn()
        if(isLoggedIn) {
            aUser = userDB.getUser()!;
        }
        print("\(isLoggedIn) -- IS LOGGED IN")
        
        Alamofire.request(.POST, "http://52.20.241.139/api/v1.0/products_for_sale", parameters: parameters, encoding: .JSON)
            .responseJSON { response in
                //print(response.request)  // original URL request
                print("RESPONSE CODE: \(response.response)") // URL response
                //print(response.data)     // server data
                //print(response.result)   // result of response serialization
                
                
                if let JSON = response.result.value {
                    //print("JSON: \(JSON)")
                    
                    let products = JSON.valueForKey("products") as! NSArray
                    
                    let productDB: BookListingDBManager = BookListingDBManager()
                    productDB.create()
                    
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
                    
                    productDB.update(self.pfs)
                    
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
    
    //initializes components within a cell
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
    
    //Handle touch events on a cell
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        //print("tee hee ^_^")
        
        //push a to ProductInfo
        let pivc: UIViewController = (self.storyboard?.instantiateViewControllerWithIdentifier("productInfoVC"))!
        self.navigationController?.pushViewController(pivc, animated: true)
    }
    
    //styles the cells in the table
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize{
        
        return CGSize(width: 180, height: 180)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

//referenced via - http://stackoverflow.com/questions/19108513/uistatusbarstyle-preferredstatusbarstyle-does-not-work-on-ios-7
extension UINavigationController {
    public override func preferredStatusBarStyle() -> UIStatusBarStyle {
        if let rootViewController = self.viewControllers.first {
            return rootViewController.preferredStatusBarStyle() //returns the statusbar color specified in the ViewController
        }
        return self.preferredStatusBarStyle()
    }
}

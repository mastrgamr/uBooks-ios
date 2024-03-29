//
//  ProductInfo.swift
//  lastminute
//
//  Created by stuart on 4/10/16.
//  Copyright © 2016 lastminute. All rights reserved.
//

import Foundation
import UIKit
import Nuke

class ProductInfoViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    
    var productInfo: ProductForSale? = nil
    
    @IBOutlet weak var productName: UILabel!
    
    var image: UIImage? = nil
    
    @IBAction func viewProfile(sender: AnyObject) {
        self.performSegueWithIdentifier("productToProfile_seg", sender: self)
    }
    
    override func viewDidLoad() {
        self.productName.text = self.productInfo!.name
        self.automaticallyAdjustsScrollViewInsets = false
        
        //self.productImage.nk_setImageWith(NSURL(string: "http://i.imgur.com/n1dqSc4.jpg?1")!)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "productToProfile_seg") {
            //var svc = segue!.destinationViewController as secondViewController;
            let profileVC: ProfileController = segue.destinationViewController as! ProfileController
            profileVC.transferUserId((self.productInfo?.ownerid)!)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func sendProduct(product: ProductForSale) {
        self.productInfo = product
    }
    
    func sendImage(image: UIImage) {
        self.image = image
    }
}

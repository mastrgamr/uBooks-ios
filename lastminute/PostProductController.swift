//
//  PostProductViewController.swift
//  lastminute
//
//  Created by stuart on 4/10/16.
//  Copyright © 2016 lastminute. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class PostProductViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate, SendBackDelegate {
    
    @IBOutlet weak var cv: UICollectionView!
    @IBOutlet weak var itemNameField: UITextField!
    @IBOutlet weak var creatorField: UITextField!
    @IBOutlet weak var barcodeField: UITextField!
    @IBOutlet weak var priceField: UITextField!
    @IBOutlet weak var sv: UIScrollView!
    
    var userId: String = ""
    var accessToekn: String = ""
    
    var images: [UIImage] = []
    
    @IBAction func uploadImages(sender: AnyObject) {
        //Parameters: accesstoken, file, orderid
    }
    
    @IBAction func postProduct(sender: AnyObject) {
        
        let parameters: [String:String] = [
            "categoryid": "1",
            "name": itemNameField.text!,
            "creator": creatorField.text!,
            "barcode": barcodeField.text!,
            "secondarybarcode": "1234567890123",
            "userid": self.userId,
            "accesstoken": self.accessToekn,
            "price": priceField.text!
        ]
        
        
        Alamofire.upload( .POST, "\(BASE_URL)api/v1.0/add_product_for_sale",
            multipartFormData: { multipartFormData in
                
                multipartFormData.appendBodyPart(data: UIImageJPEGRepresentation(self.images[0], 0.7)!, name: "file", fileName: "IMG_0002.JPG", mimeType: "image/jpeg")
                
                for (key, value) in parameters {
                    multipartFormData.appendBodyPart(data: value.dataUsingEncoding(NSUTF8StringEncoding)!, name: key)
                    print(key + " " + value)
                }
                
            },
            encodingCompletion: { encodingResult in
                
                print("encoding complete")
                
                switch encodingResult {
                    
                case .Success(let upload, _, _):
                    upload.responseJSON { response in
                        //debugPrint(response)
                        //print(response.request)  // original URL request
                        print("RESPONSE CODE: \(response.response)") // URL response
                        //print(response.data)     // server data
                        //print(response.result)   // result of response serialization
                    }
                    
                case .Failure(let encodingError):
                    print(encodingError)
                }
            }
        )
    }
    
    @IBAction func getImages(sender: AnyObject) {
        self.performSegueWithIdentifier("postToCamera_seg", sender: self)
    }
    
    override func viewDidLoad() {
        self.automaticallyAdjustsScrollViewInsets = false
        self.hideKeyboardWhenTappedAround()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        let userDB: UserDBManager = UserDBManager()
        userDB.create() //connects to the SQLite
        self.accessToekn = userDB.getUser()!.accessToken!
        self.userId = userDB.getUser()!.userId!
        
        self.sv.contentSize = CGSize(width: 0, height: 1000.0)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.sv.contentSize = CGSize(width: 0, height: 1000.0)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true) //hides keyboard
    }
    
    func sendImagesToPreviousVC(images: UIImage) {
        if (self.images.count != 5) {
            self.images.append(images)
            self.cv.reloadData()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "postToCamera_seg" {
            SelectPhotoViewController.sendBack = self //insures we get the images back
        }
    }
    
    //initializes components within a cell
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        //releases resources the TableCell contains for reuse. Reduces performance/memory impact of scrolling
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ProductImageCell", forIndexPath: indexPath) as UICollectionViewCell
        
        //Set up title of book/item in listing
        if self.images.count != 0 {
            //Set images to the values sent back from camera
            if let ct = cell.viewWithTag(1) as! UIImageView? {
                //unwrap variable and dynamically load image into imageview
                ct.image = self.images[indexPath.row]
            }
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if (self.images.count != 0) {
            return self.images.count
        } else {
            return 0
        }
    }
    
    //styles the cells in the table
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize{
        
        return CGSize(width: 145, height: 185)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

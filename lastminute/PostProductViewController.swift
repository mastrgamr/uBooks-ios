//
//  PostProductViewController.swift
//  lastminute
//
//  Created by stuart on 4/10/16.
//  Copyright © 2016 lastminute. All rights reserved.
//

import Foundation
import UIKit

class PostProductViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate, SendBackDelegate {
    
    @IBOutlet weak var cv: UICollectionView!
    
    var images: [UIImage] = []
    
    @IBAction func getImages(sender: AnyObject) {
        self.performSegueWithIdentifier("postToCamera_seg", sender: self)
    }
    
    override func viewDidLoad() {
        self.automaticallyAdjustsScrollViewInsets = false
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

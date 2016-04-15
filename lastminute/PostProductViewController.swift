//
//  PostProductViewController.swift
//  lastminute
//
//  Created by stuart on 4/10/16.
//  Copyright © 2016 lastminute. All rights reserved.
//

import Foundation
import UIKit

class PostProductViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    
    @IBAction func getImages(sender: AnyObject) {
        self.performSegueWithIdentifier("postToCamera_seg", sender: self)
    }
    
    override func viewDidLoad() {
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

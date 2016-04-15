//
//  PostProductViewController.swift
//  lastminute
//
//  Created by stuart on 4/10/16.
//  Copyright © 2016 lastminute. All rights reserved.
//

import Foundation
import UIKit

class PostProductViewController: UIViewController {
    
    @IBAction func getImages(sender: AnyObject) {
        self.performSegueWithIdentifier("postToCamera_seg", sender: self)
    }
    override func viewDidLoad() {
        //some code
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

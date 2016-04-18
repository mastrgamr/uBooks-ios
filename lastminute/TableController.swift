//
//  TableController.swift
//  lastminute
//
//  Created by stuart on 4/17/16.
//  Copyright © 2016 lastminute. All rights reserved.
//

import Foundation
import UIKit

class TableController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var tv: UITableView!
    
    override func viewDidLoad() {
        
        
    }
    
    override func didReceiveMemoryWarning() {
        //super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("confirmation_cell")! as UITableViewCell
        
        
        return cell
    }
}

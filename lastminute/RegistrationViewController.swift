//
//  RegistrationViewController.swift
//  lastminute
//
//  Created by stuart on 3/3/16.
//  Copyright © 2016 lastminute. All rights reserved.
//

import UIKit

class RegistrationViewController : UIViewController {
    
    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var email: UITextField!
    
    @IBAction func clicks(sender: AnyObject) {
        var datav: DataViewController = DataViewController()
        self.presentViewController(datav, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Some Code ...
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true) //hides keyboard
    }
}

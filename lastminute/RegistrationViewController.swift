//
//  RegistrationViewController.swift
//  lastminute
//
//  Created by stuart on 3/3/16.
//  Copyright © 2016 lastminute. All rights reserved.
//

import UIKit

class RegistrationViewController : UIViewController, UIPickerViewDelegate {
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var schoolPicker: UIPickerView!
    
    var schoolNames = ["Hunter College", "College of Staten Island", "Brooklyn College"]
    
    @IBAction func clicks(sender: AnyObject) {
        let datav: DataViewController = DataViewController()
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
    
    //Not sure why this is needed -- Google More
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //number of items in the picker view
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return schoolNames.count
    }
    
    //returns the name of the school contained in the array at the specific index
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return schoolNames[row]
    }
    
}

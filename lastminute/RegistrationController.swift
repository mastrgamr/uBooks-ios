//
//  RegistrationViewController.swift
//  lastminute
//
//  Created by stuart on 3/3/16.
//  Copyright © 2016 lastminute. All rights reserved.
//

import UIKit
import Alamofire

class RegistrationViewController : UIViewController, UIPickerViewDelegate, UIScrollViewDelegate {
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var schoolPicker: UIPickerView!
    @IBOutlet weak var password: UITextField!
    
    private var selectedShool: String = ""
    
    var schoolNames = ["Hunter College", "College of Staten Island", "Brooklyn College"]
    
    @IBAction func undoSeg(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func clicks(sender: AnyObject) {
        
        let parameters: [String:String] = [
            "firstname": firstName.text!,
            "lastname": lastName.text!,
            "college": selectedShool,
            "email": email.text!,
            "password": password.text!,
            "registrationid": "No GCM"
        ]
        
        //registers teh user and logs in if successful
        Alamofire.request(.POST, "\(BASE_URL)api/v1.0/create_account", parameters: parameters, encoding: .JSON)
            .responseJSON { response in
                //print(response.request)  // original URL request
                print("RESPONSE CODE: \(response.response)") // URL response
                //print(response.data)     // server data
                //print(response.result)   // result of response serialization
                
                
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                    
                    let userDB: UserDBManager = UserDBManager()
                    userDB.create()
                    userDB.update("\(JSON["userid"]!!)", _accessToken: "\(JSON["accesstoken"]!!)", _university: "\(JSON["universityname"]!!)", _college: "\(JSON["collegename"]!!)", _primaryColor: "\(JSON["primarycolor"]!!)", _secondaryColor: "\(JSON["secondarycolor"]!!)")
                    
                    if JSON["status"] as! String == "Success" {
                        self.dismissViewControllerAnimated(true, completion: nil)
                    }

                }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
        selectedShool = schoolNames[row]
        return selectedShool
    }
    
}

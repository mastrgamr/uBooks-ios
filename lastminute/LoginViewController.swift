//
//  LoginViewController.swift
//  lastminute
//
//  Created by Trevaughn Daley on 3/11/16.
//  Copyright © 2016 lastminute. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController : UIViewController {
    
    
    @IBOutlet weak var userTextEmail: UITextField!
    @IBOutlet weak var userTextPassword: UITextField!
    
    
    override func viewDidLoad() {
        //Some Code ...
        
    }
    
    @IBAction func undoSeg(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func beginSignIn(sender: AnyObject) {
        print("Authorizing")
        
        //authorize
        let email = userTextEmail.text!
        let password = userTextPassword.text!
        let param = ["email": email, "password": password]
        
        
        Alamofire.request(.POST, "http://52.20.241.139/api/v1.0/request_login", parameters: param, encoding: .JSON)
            .responseJSON { response in
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization
                
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                    if "\(JSON["status"]!!)" == "Failure" { //return if message failure. this prevents app crash
                        return;
                    }
                    
                    let userDB: UserDBManager = UserDBManager()
                    userDB.create()
                    userDB.update("\(JSON["userid"]!!)", _accessToken: "\(JSON["accesstoken"]!!)", _university: "\(JSON["university"]!!)", _college: "\(JSON["college"]!!)", _primaryColor: "\(JSON["primarycolor"]!!)", _secondaryColor: "\(JSON["secondarycolor"]!!)")
                    //print(userDB.getUser()!.university!)
                }
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
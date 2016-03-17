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
                }
                
                print(email, password)
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
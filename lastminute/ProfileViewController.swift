//
//  ProfileViewController.swift
//  lastminute
//
//  Created by stuart on 4/11/16.
//  Copyright © 2016 lastminute. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class ProfileViewController: UIViewController {
    
    var user: User? = nil
    var userId: String? = nil
    var userName: String? = nil
    
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblCollegeName: UILabel!
    @IBOutlet weak var lblUniversityName: UILabel!
    
    
    @IBAction func logout(sender: AnyObject) {
        let userDB: UserDBManager = UserDBManager()
        userDB.create() //MARK - Create better way to connnect
        userDB.logUserOut()
    }
    
    override func viewDidLoad() {
        //some code
        //self.lblUsername.text = user!.userName
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func transferUser(user: User) {
        self.user = user
    }
    
    func transferUserId(userId: String) {
        //self.userId = userId

        Alamofire.request(.GET, "http://52.20.241.139/api/v1.0/users/\(userId)")
            .responseJSON { response_ in
                
                if let JSON = response_.result.value {
                    print("JSON: \(JSON)")
                    
                    /*if "\(JSON["status"]!!)" == "Failure" { //return if message failure. this prevents app crash
                        return;
                    }*/
                    
                    self.lblUsername.text = (JSON["user"]!!["firstname"]!! as! String) + " " + (JSON["user"]!!["lastname"]!! as! String)
                    self.lblCollegeName.text = (JSON["user"]!!["collegename"]!! as! String)
                    self.lblUniversityName.text = (JSON["user"]!!["universityname"]!! as! String)
                }
        }
 
        
    }
}
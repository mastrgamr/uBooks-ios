//
//  ProfileViewController.swift
//  lastminute
//
//  Created by stuart on 4/11/16.
//  Copyright © 2016 lastminute. All rights reserved.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController {
    
    var user: User? = nil
    
    @IBAction func logout(sender: AnyObject) {
        let userDB: UserDBManager = UserDBManager()
        userDB.create() //MARK - Create better way to connnect
        userDB.logUserOut()
    }
    
    override func viewDidLoad() {
        //some code
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func transferUser(user: User) {
        self.user = user
    }
}
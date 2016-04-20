//
//  TabBarController.swift
//  lastminute
//
//  Created by stuart on 4/19/16.
//  Copyright © 2016 lastminute. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    var aUser: User? = nil
    var isLoggedIn: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        let userDB: UserDBManager = UserDBManager()
        userDB.create() //connects to the SQLite
        self.isLoggedIn = userDB.isLoggedIn()
        if(isLoggedIn) {
            aUser = userDB.getUser()!;
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        print("preparing")
        if (isLoggedIn) {
            print("preparing2")
            let profileVC: ProfileController = segue.destinationViewController as! ProfileController
            profileVC.transferUser(aUser!)
        }
    }

}

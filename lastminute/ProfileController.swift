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

class ProfileController: UIViewController, UITableViewDelegate {
    
    var user: User? = nil
    var userId: String = ""
    var userName: String = ""
    
    @IBOutlet weak var tv: UITableView!
    
    var collegeNmae: String = ""
    var universityName: String = ""
    
    
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
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier("user_info")! as! UserInfoCell
            cell.userInfo.text = userName
            return cell
        case 2:
            let cell = tableView.dequeueReusableCellWithIdentifier("user_info")! as! UserInfoCell
            cell.userInfo.text = collegeNmae
            return cell
        case 3:
            let cell = tableView.dequeueReusableCellWithIdentifier("user_info")! as! UserInfoCell
            cell.userInfo.text = universityName
            return cell
        default:
            print("OH YEEEEAAAAA")
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier("spacer")! as UITableViewCell
        return cell
    }
    
    func transferUser(user: User) {
        self.user = user
        
        self.userName = user.userName!
        self.collegeNmae = user.college!
        self.universityName = user.university!
    }
    
    func transferUserId(userId: String) {
        //self.userId = userId
        Alamofire.request(.GET, "\(BASE_URL)api/v1.0/users/\(userId)")
            .responseJSON { response_ in
                
                if let JSON = response_.result.value {
                    print("JSON: \(JSON)")
                    
                    /*if "\(JSON["status"]!!)" == "Failure" { //return if message failure. this prevents app crash
                        return;
                    }*/
                    
                    self.userName = (JSON["user"]!!["firstname"]!! as! String) + " " + (JSON["user"]!!["lastname"]!! as! String)
                    self.collegeNmae = (JSON["user"]!!["collegename"]!! as! String)
                    self.universityName = (JSON["user"]!!["universityname"]!! as! String)
                }
                print("refreshing")
                self.tv.reloadData()
        }
    }
}
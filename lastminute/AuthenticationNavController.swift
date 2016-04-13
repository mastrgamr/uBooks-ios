//
//  AuthenticationNavController.swift
//  lastminute
//
//  Created by stuart on 4/12/16.
//  Copyright © 2016 lastminute. All rights reserved.
//

import Foundation
import UIKit

class AuthenticationNavController : UINavigationController {
    
    var name: String = ""
    
    override func viewDidLoad() {
        self.setNavigationBarHidden(true, animated: false)
        //self.navigationBar.tintColor = UIColor.blackColor() //MARK - Come up with a way to set color
    }
    
    func setIt(name: String) -> Void{
        //print("HEY BITCH!!") //purely testing
        self.name = name
    }
}

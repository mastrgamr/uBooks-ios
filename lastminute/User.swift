//
//  User.swift
//  lastminute
//
//  Created by stuart on 4/9/16.
//  Copyright © 2016 lastminute. All rights reserved.
//

import Foundation

class User: NSObject {
    
    let userId : String?
    let accessToken : String?
    let university : String?
    let college : String?
    let primaryColor : String?
    let secondaryColor : String?
    
    let userName : String?
    let email : String?
    
    init(userId: String, accessToken: String, university: String, college: String, primaryColor: String, secondaryColor: String, firstName: String? = nil, lastName: String? = nil, email: String? = nil) {
        
        self.userId = userId
        self.accessToken = accessToken
        self.university = university
        self.college = college
        self.primaryColor = primaryColor
        self.secondaryColor = secondaryColor
        
        self.userName = nil//firstName! + " " + lastName!
        self.email = nil //email!
    }
}

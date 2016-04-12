//
//  DBManager.swift
//  lastminute
//
//  Created by stuart on 4/9/16.
//  Copyright © 2016 lastminute. All rights reserved.
//


import SQLite
import Foundation

class UserDBManager : NSObject {
    
    var db : Connection? = nil //Connection to the local SQLite
    var userTbl : Table? = nil
    //columns within the table
    let userId = Expression<String>("id")
    let accessToken = Expression<String?>("token")
    let university = Expression<String>("university")
    let college = Expression<String>("college")
    let primaryColor = Expression<String>("primary_color")
    let secondaryColor = Expression<String>("secondary_color")
    
    override init() {
        
        //Path of the user db
        let path = NSSearchPathForDirectoriesInDomains(.LibraryDirectory, .UserDomainMask, true).first!
        
        do { //initialize
            self.db = try Connection("\(path)/ub.sqlite3")
        } catch {
            print("Could not establish local DB connection.")
        }
        
    }
    
    func create() -> Void {
        
        if(db == nil){
            print("LocalDB nil! Possibly couldn't establish connection?")
            return
        }
        
        //explicitly connect to user SQLite
        self.userTbl = Table("user")
        
        do {
            //try db!.run(userTbl!.drop(ifExists: true)) // Uncomment strictly to 'start over' with new user table
            
            try db!.run(userTbl!.create(ifNotExists: true)
            { t in                                  // CREATE TABLE "users" (
                t.column(userId, primaryKey: true)  //     "userId" TEXT PRIMARY KEY NOT NULL,
                t.column(accessToken)               //     "accessToken" TEXT,
                t.column(university)                //     "university" TEXT
                t.column(college)                   //     "college" TEXT,
                t.column(primaryColor)              //     "primaryColor" TEXT,
                t.column(secondaryColor)            //     "secondaryColor" TEXT,
            })                                      // )
        } catch {
            print("Could not create table: \(error)")
        }
    }
    
    // INSERT INTO "users" ("column_name", "column_name") VALUES ('value', 'value')
    func update(_userId: String, _accessToken: String, _university: String, _college: String, _primaryColor: String, _secondaryColor: String) -> Bool {
        
        do {
            
            //the lines below check if the user exists in the table but the token is null
            //if it is, drop the User table
            let check = try db!.prepare(userTbl!.select(accessToken))
            var nullFound: Bool = false
            for _check in check {
                if _check[accessToken] == nil {
                    print("we got a nuller")
                    nullFound = true //set bool here, can't drop table mid-select
                }
            }
            
            //drop table and add a new one
            if nullFound {
                try db!.run(userTbl!.drop(ifExists: true))
                create()
            }
            
            //inserts a new User in the user table
            let insert = userTbl!.insert(
                userId <- "\(_userId)",
                accessToken <- "\(_accessToken)",
                university <- "\(_university)",
                college <- "\(_college)",
                primaryColor <- "\(_primaryColor)",
                secondaryColor <- "\(_secondaryColor)")
            
            _ = try db!.run(insert) //execute command
            
            return true //successfully inserted user
        } catch {
            print("Could not INSERT user to local DB: \(error)")
        }
        
        return false
    }
    
    // SELECT * FROM "users"
    func getUser() -> User? {
        var user: User?
        
        do {
            for _user in try db!.prepare(userTbl!) {
                print("id: \(_user[userId]), college: \(_user[college]), primary_color: \(_user[primaryColor]), secondary_color: \(_user[secondaryColor]), access_token: \(_user[accessToken])")
                
                user = User(userId: _user[userId], accessToken: _user[accessToken]!, university: _user[university], college: _user[college], primaryColor: _user[primaryColor], secondaryColor: _user[secondaryColor])
            }
            return user
        } catch {
            print("Could not query table.")
        }
        
        return nil
    }
    
    func isLoggedIn() -> Bool {
        let query = userTbl!.select(accessToken)    // SELECT token FROM users
                    .limit(1)     // LIMIT = 1
        
        do {
            for q in try db!.prepare(query) {
                //print("\(q[accessToken]!)")
                if q[accessToken] != nil { //if the accesstoken stored for the user is not null
                    return true
                }
            }
        } catch {
            print("error: \(error)")
        }
        
        return false
    }
    
    //inserts a nil value for the accesss_token column. indicating a logged out user
    func logUserOut() -> Void {
        do {
            let user = userTbl!.filter(accessToken != nil)
            
            try db!.run(user.update(accessToken <- nil))
            // UPDATE "users" SET "access_token" = nil WHERE ("access_token" != nil)
            print("Logged out")
        } catch {
            print("Could not perform query to local DB: \(error)")
        }
        
    }
    
}

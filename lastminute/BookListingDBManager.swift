//
//  BookListingDBManager.swift
//  lastminute
//
//  Created by stuart on 4/9/16.
//  Copyright © 2016 lastminute. All rights reserved.
//

import SQLite
import Foundation

class BookListingDBManager : NSObject {
    
    var db : Connection? = nil //Connection to the local SQLite
    var productsTbl : Table? = nil
    //columns within the table
    let productId = Expression<String>("productid")
    let categoryId = Expression<String>("cateogryid")
    let ownerId = Expression<String>("ownerid")
    let name = Expression<String>("name")
    let creator = Expression<String>("creator")
    let orderId = Expression<String>("orderid")
    let dateCreated = Expression<String>("datecreated")
    let dateUpdated = Expression<String>("dateupdated")
    let price = Expression<String>("price")
    let barcode = Expression<String>("barcode")
    let secondaryBarcode = Expression<String>("secondarybarcode")
    let imageUri = Expression<String>("imageuri")
    
    override init() {
        
        //Path of the DB
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
        self.productsTbl = Table("product")
        
        do {
            
            // MARK - The next line is for our debugging purposes, will remove soon
            try db!.run(productsTbl!.drop(ifExists: true))
            // DROP TABLE IF EXISTS "products"
            
            try db!.run(productsTbl!.create(ifNotExists: true)
            { t in                                  
                t.column(productId)
                t.column(categoryId)
                t.column(ownerId)
                t.column(name)
                t.column(creator)
                t.column(orderId)
                t.column(dateCreated)
                t.column(dateUpdated)
                t.column(price)
                t.column(barcode)
                t.column(secondaryBarcode)
                t.column(imageUri)
                })
        } catch {
            print("Could not create table")
        }
    }
    
    // INSERT INTO "users" ("column_name", "column_name") VALUES ('value', 'value')
    func update(_productId: String, _categoryId: String, _ownerId: String, _name: String, _creator: String, _orderId: String, _dateCreated: String, _dateUpdated: String, _price: String, _barcode: String, _secondaryBarcode: String, _imageUri: String) -> Bool {
        
        do {
            let insert = productsTbl!.insert(
                productId <- "\(_productId)",
                categoryId <- "\(_categoryId)",
                ownerId <- "\(_ownerId)",
                name <- "\(_name)",
                creator <- "\(_creator)",
                orderId <- "\(_orderId)",
                dateCreated <- "\(_dateCreated)",
                dateUpdated <- "\(_dateUpdated)",
                price <- "\(_price)",
                barcode <- "\(_barcode)",
                secondaryBarcode <- "\(_secondaryBarcode)",
                imageUri <- "\(_imageUri)")
            
            _ = try db!.run(insert) //execute command
            
            return true //successfully inserted user
        } catch {
            print("Could not INSERT product to local DB")
        }
        
        return false
    }
    
    func update(_products: [ProductForSale]) -> Bool {
        
        do {
            for _product in _products {
                let insert = productsTbl!.insert(
                    productId <- "\(_product.productid)",
                    categoryId <- "\(String(_product.categoryid))",
                    ownerId <- "\(_product.ownerid)",
                    name <- "\(_product.name)",
                    creator <- "\(_product.creator)",
                    orderId <- "\(_product.orderid)",
                    dateCreated <- "\(_product.datecreated)",
                    dateUpdated <- "\(_product.dateUdated)",
                    price <- "\(_product.price)",
                    barcode <- "\(_product.barcode)",
                    secondaryBarcode <- "\(_product.secondarybarcode)",
                    imageUri <- "\(_product.imageurl)")
            
                _ = try db!.run(insert) //execute command
            }
            
            print("Successfully inserted")
            return true //successfully inserted user
        } catch {
            print("Could not INSERT product to local DB. \(error)")
        }
        
        return false
    }
    
    // SELECT * FROM "users"
    func getProductsForSale() -> [ProductForSale]? {
        var product: [ProductForSale]?
        
        do {
            for _product in try db!.prepare(productsTbl!) {
                
                //categoryId has to be cast to an Int
                product?.append(ProductForSale(barcode: _product[barcode], categoryid: Int(_product[categoryId])!, creator: _product[creator], datecreated: _product[dateCreated], dateupdated: _product[dateUpdated], imageurl: _product[imageUri], name: _product[name], orderid: _product[orderId], ownerid: _product[ownerId], price: _product[price], productid: _product[productId], secondarybarcode: _product[secondaryBarcode]))
            }
            return product
        } catch {
            print("Could not query table.")
        }
        
        return nil
    }
}

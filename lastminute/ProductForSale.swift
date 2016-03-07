//
//  ProductForSale.swift
//  lastminute
//
//  Created by stuart on 3/5/16.
//  Copyright © 2016 lastminute. All rights reserved.
//

import Foundation

//NSObject to automagically create and delete instances of this class
class ProductForSale : NSObject {
    
    var barcode : String?
    var categoryid : Int?
    var creator : String?
    var datecreated : String?
    var dateUdated : String?
    var imageurl : String?
    var name : String?
    var orderid : String?
    var ownerid : String?
    var price : String?
    var productid : String?
    var secondarybarcode : String?
    
    init(barcode: String?, categoryid: Int?, creator: String?, datecreated: String?, dateupdated: String?, imageurl: String?, name: String?, orderid: String?, ownerid: String?, price: String?, productid: String?, secondarybarcode: String?) {
        
        self.barcode = barcode
        self.categoryid = categoryid
        self.creator = creator
        self.datecreated = datecreated
        self.dateUdated = dateupdated
        self.datecreated = datecreated
        self.imageurl = imageurl
        self.name = name
        self.orderid = orderid
        self.ownerid = ownerid
        self.price = price
        self.productid = productid
        self.secondarybarcode = secondarybarcode
    }
    
    var toString: String {
        return "A toString()"
    }
    
}

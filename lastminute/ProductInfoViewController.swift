//
//  ProductInfo.swift
//  lastminute
//
//  Created by stuart on 4/10/16.
//  Copyright © 2016 lastminute. All rights reserved.
//

import Foundation
import UIKit

class ProductInfoViewController: UIViewController {
    
    var productInfo: ProductForSale? = nil
    
    @IBOutlet weak var productName: UILabel!
    
    override func viewDidLoad() {
        self.productName.text = self.productInfo!.name
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func sendProduct(product: ProductForSale) {
        self.productInfo = product
    }
}

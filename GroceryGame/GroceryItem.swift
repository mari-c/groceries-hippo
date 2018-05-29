//
//  GroceryItem.swift
//  GroceryGame
//
//  Created by mariana on 2018-05-28.
//  Copyright © 2018 none. All rights reserved.
//

import UIKit
import os.log

class GroceryItem: NSObject, NSCoding {
    
    // MARK: Properties
    
    var itemName: String
    var image: UIImage?
    let quantity: Int
    
    // MARK: Types
    
    struct PropertyKey {
        static let itemName = "itemName"
        static let image = "image"
        static let quantity = "quantity"
    }
    
    // MARK: Initialization
    
    init?(itemName: String, image: UIImage?, quantity: Int) {
        if quantity < 1 {
            return nil
        }
        
        self.itemName = itemName
        self.image = image
        self.quantity = quantity
    }
    
    // MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(itemName, forKey: PropertyKey.itemName)
        aCoder.encode(image, forKey: PropertyKey.image)
        aCoder.encode(quantity, forKey: PropertyKey.quantity)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        // Name is required -- initializer should fail if we cannot decode a name string
        guard let itemName = aDecoder.decodeObject(forKey: PropertyKey.itemName) as? String else {
            os_log("Unable to decode the name for GroceryItem object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        // Image is optional
        let image = aDecoder.decodeObject(forKey: PropertyKey.image) as? UIImage
        
        let quantity = aDecoder.decodeInteger(forKey: PropertyKey.quantity)
        
        // Must call designated initializer
        self.init(itemName: itemName, image: image, quantity: quantity)
    }
    
}

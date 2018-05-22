//
//  GroceryList.swift
//  GroceryGame
//
//  Created by mariana on 2018-05-22.
//  Copyright © 2018 none. All rights reserved.
//

import UIKit

class GroceryList {
    
    // MARK: Properties
    
    var name: String
    var items: [GroceryItem]
    
    struct GroceryItem {
        var itemName: String
        var image: UIImage?
        let quantity: Int
        
        init(itemName: String, image: UIImage?, quantity: Int) {
            self.itemName = itemName
            self.image = image
            self.quantity = quantity
        }
    }
    
    // MARK: Initialization
    
    init?(name: String, items: [GroceryItem]) {
        if name.isEmpty {
            return nil
        }
        
        self.name = name
        self.items = items
    }
    
}

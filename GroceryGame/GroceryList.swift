//
//  GroceryList.swift
//  GroceryGame
//
//  Created by mariana on 2018-05-22.
//  Copyright © 2018 none. All rights reserved.
//

import Foundation
import os.log

class GroceryList: NSObject, NSCoding {
    
    // MARK: Properties
    
    var name: String
    var items: [GroceryItem]
    
    // MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("grocerylists")
        
    // MARK: Types
    
    struct PropertyKey {
        static let name = "name"
        static let items = "items"
    }
    
    // MARK: Initialization
    
    init?(name: String, items: [GroceryItem]) {
        if name.isEmpty {
            return nil
        }
        
        self.name = name
        self.items = items
    }
    
    // MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(items, forKey: PropertyKey.items)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        // Name is required -- initializer should fail if we cannot decode a name string
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode the name for GroceryList object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        // Items are also required
        guard let items = aDecoder.decodeObject(forKey: PropertyKey.items) as? [GroceryItem] else {
            os_log("Unable to decode items for GroceryList object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        // Must call designated initializer
        self.init(name: name, items: items)
    }
    
}

//
//  GroceryGameTest.swift
//  GroceryGameTest
//
//  Created by ahely on 2018-05-23.
//  Copyright © 2018 none. All rights reserved.
//

import XCTest

@testable import GroceryGame
    
class groceryAppTester: XCTestCase {
        
        // Confirm that the Meal initializer returns a Meal object when passed valid parameters.
    func testInitializationSucceeds() {
            // Zero rating
            
        let firstItem = GroceryList.GroceryItem (itemName: "Hello", image: nil, quantity: 4)
            
        let firstlist = GroceryList.init(name: "one", items: [firstItem!])
            
        XCTAssertNotNil(firstlist)
            
    }
    
    func testInitializationfails() {
        // Zero rating
        
        let secondItem = GroceryList.GroceryItem (itemName: "j", image: nil, quantity: 4)
        
        let secondlist = GroceryList.init(name: "one", items: [secondItem!])
        
        XCTAssertNotNil(secondlist)
        
    }
        
}



//
//  ItemSearchViewController.swift
//  GroceryGame
//
//  Created by mariana on 2018-05-31.
//  Copyright © 2018 none. All rights reserved.
//

import UIKit

class ItemSearchViewController: UIViewController {
    
    // MARK: Properties
    
    @IBOutlet weak var listCounter: UITextField!
    @IBOutlet weak var cartCounter: UITextField!
    @IBOutlet weak var itemImage: UIImageView!
    
    // Store grocery list for current game
    var playList: GroceryList?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        listCounter.text = String(playList!.items.count)
    }

    /*
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

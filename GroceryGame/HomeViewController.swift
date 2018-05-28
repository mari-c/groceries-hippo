//
//  HomeViewController.swift
//  GroceryGame
//
//  Created by mariana on 2018-05-21.
//  Copyright © 2018 none. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playSelected(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "playstory", bundle: nil)
        // let controller = storyboard.instantiateViewController(withIdentifier: "SelectPlaystoryList") as UIViewController
        // present(controller, animated: true, completion: nil)
        
        let playstoryController = storyboard.instantiateViewController(withIdentifier: "SelectPlaystoryList")
        navigationController?.pushViewController(playstoryController, animated: true)
    }
    

}


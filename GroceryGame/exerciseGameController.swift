//
//  exerciseGameController.swift
//  GroceryGame
//
//  Created by ahely on 2018-05-31.
//  Copyright © 2018 none. All rights reserved.
//

import UIKit

class exerciseGameController: UIViewController {

    // MARK: Properties
    
    @IBOutlet weak var mylabel: UILabel!
    var index = 0
    var myStrings = [String]()
    
    // @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // print(self.label2.text)
        // mylabel.text = "hello"

        loadText()
        let ind = displayText()
        requestTask(index: ind)
    }

    /*
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    */
    
    // MARK: Private Methods
    
    private func loadText() {
        // File location
        let fileURLProject = Bundle.main.path(forResource: "ProjectTextFile", ofType: "txt")
        // Read from the file
        var readStringProject = ""
        do {
            readStringProject = try String(contentsOfFile: fileURLProject!, encoding: String.Encoding.utf8)
            self.myStrings = readStringProject.components(separatedBy: .newlines)
            print(myStrings)
        } catch let error as NSError {
            print("Failed reading from project")
            print(error)
        }
        
    }
    
    private func displayText() -> Int {
        /*
        print(myStrings)
        mylabel.text = self.myStrings [index]
        print(index)
        index = index + 1
        print(index)
         */
        
        let ind = Int(arc4random_uniform(UInt32(myStrings.count - 1)))
        // print(myStrings)
        mylabel.text = myStrings[ind]
        print(ind)
        return ind
    }
    
    private func requestTask(index: Int) {
        switch index {
        case 0:
            // Reach high
            print("Reach high")
        case 1:
            // Shake
            print("Shake")
        default:
            fatalError("Task index does not exist. Task could not be requested.")
        }
    }
    
    /*
    @IBAction func buttonPressed(_ sender: UIButton) {
        displayText()
    }
    
    */
    
}

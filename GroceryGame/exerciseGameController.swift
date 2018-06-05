//
//  exerciseGameController.swift
//  GroceryGame
//
//  Created by ahely on 2018-05-31.
//  Copyright © 2018 none. All rights reserved.
//

import UIKit

class exerciseGameController: UIViewController {

    @IBOutlet weak var mylabel: UILabel!
    var index = 0
    var myStrings = [String]()
    
    //@IBOutlet weak var button: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //print(self.label2.text)
       // mylabel.text = "hello"
        

        loadText()
        displayText()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func loadText(){
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
    
    
    
    
    func displayText(){
        print(myStrings)
        mylabel.text = self.myStrings [index]
        print(index)
        index = index + 1
        print(index)
    }
    
    /*
    @IBAction func buttonPressed(_ sender: UIButton) {
        displayText()
    }
    
    */
    
   

}

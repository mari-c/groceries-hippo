//
//  PlaystoryViewController.swift
//  playStory
//
//  Created by ahely on 2018-05-24.
//  Copyright © 2018 ahely. All rights reserved.
//

import UIKit

class PlaystoryViewController: UIViewController {

    @IBOutlet weak var viewtap: UIImageView!
    @IBOutlet weak var rightFeet: UIImageView!
    @IBOutlet weak var leftFeet: UIImageView!
    @IBOutlet weak var hippoBody: UIImageView!
    @IBOutlet weak var textbox1: UIImageView!
    @IBOutlet weak var hippoFull: UIImageView!
    @IBOutlet weak var textbook2: UIImageView!
    
    @IBOutlet weak var listCounter: UITextField!
    @IBOutlet weak var cartCounter: UITextField!
    
    // Store grocery list for current game
    var playList: GroceryList?
    
    var tapGesture: UITapGestureRecognizer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listCounter.text = String(playList!.items.count)
        
        // Tap gestures
        viewtap.isUserInteractionEnabled = true
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(myviewTapped))
        viewtap.addGestureRecognizer(tapGesture!)
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    UIView.animate(withDuration: 0.2, animations: {
    <#code#>
    }, completion: { _ in
    <#code#>
    })
 
     */
    @objc func myviewTapped() {
        UIView.animate(withDuration: 1, delay: 0, options: [.repeat], animations: {
            UIView.setAnimationRepeatCount(5)
            self.rightFeet.frame.origin.y -= 20
        }, completion: { (finished) in if (finished) { self.askForHelpAnimation() }})
    }
    
    func askForHelpAnimation() {
        UIView.animate(withDuration: 2, delay: 0, options: [], animations: {
            self.rightFeet.isHidden = true
            self.leftFeet.isHidden = true
            self.hippoBody.isHidden = true
            self.textbox1.isHidden = true
            self.hippoFull.isHidden = false
            self.hippoFull.frame.origin.x += 200
            self.textbook2.isHidden = false
        }, completion: { (finished) in if (finished) { self.playToGetItems() }})
    }
    
    func playToGetItems() {
        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "getItemPage")
        self.navigationController?.pushViewController(nextViewController!, animated: true)
    }
    
}


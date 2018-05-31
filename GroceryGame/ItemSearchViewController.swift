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
    @IBOutlet weak var itemQuantity: UITextField!
    
    // Store grocery list for current game
    var playList: GroceryList?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        listCounter.text = String(playList!.items.count)
        
        startPlaying()
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
    
    // MARK: Private Methods
    
    private func startPlaying() {
        // Display next item and play animation presenting it
        let items = playList?.items
        
        // Randomize items here
        // ...
        
        var index = 1
        for item in items! {
            itemImage.image = item.image
            itemQuantity.text = String(item.quantity)
            presentItemAnimation(position: index)
            // Wait for tap gesture... ???
            index += 1
        }
    }
    
    // Helper function used to present each item with an animation
    private func presentItemAnimation(position: Int) {
        let hippo = UIImage(named: "hippofull")
        let textbox = UIImage(named: "emptyTextboxLeft")
        let posLabel = UILabel(frame: CGRect(x: 93, y: 370, width: 180, height: 90))
        
        posLabel.textAlignment = .center
        let nf = NumberFormatter()
        nf.numberStyle = .ordinal
        posLabel.text = "Your \(nf.string(from: position as NSNumber) ?? "") item is..."
        
        let hippoView = UIImageView(frame: CGRect(x: 16, y: 520, width: 120, height: 120))
        hippoView.contentMode = .scaleAspectFill
        hippoView.image = hippo
        let textboxView = UIImageView(frame: CGRect(x: 84, y: 379, width: 200, height: 100))
        textboxView.contentMode = .scaleAspectFill
        textboxView.image = textbox
        
        view.addSubview(hippoView)
        view.addSubview(textboxView)
        view.addSubview(posLabel)
        
        UIView.animate(withDuration: 3, delay: 5, animations: {
            hippoView.frame.origin.x += 900
        }, completion: {
            (finished) in
            textboxView.isHidden = finished
            posLabel.isHidden = finished
        })
    }

}

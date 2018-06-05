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
    @IBOutlet weak var finishedButton: UIButton!
    @IBOutlet var tapNextItem: UITapGestureRecognizer!
    @IBOutlet var tapEndGame: UITapGestureRecognizer!
    
    
    // Store grocery list for current game
    var playList: GroceryList?
    
    // Current position in the list of items; need to change implementation to randomize item order
    var index = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        listCounter.text = String(playList!.items.count)
        
        tapNextItem = UITapGestureRecognizer(target: self, action: #selector(nextItem))
        view.addGestureRecognizer(tapNextItem)
        
        itemQuantity.isHidden = true
        finishedButton.isHidden = true
        
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
    
    // MARK: Actions
    
    @IBAction func unwindToItemSearch(sender: UIStoryboardSegue) {
        /*
        if let sourceViewController = sender.source as? exerciseGameController {
            // sourceViewController.displayText()
        }
         */
    }
    
    // MARK: Private Methods
    
    private func playItem(item: GroceryItem, index: Int) {
        itemImage.image = item.image
        itemQuantity.text = String(item.quantity)
        presentItemAnimation(position: index)
    }
    
    // Helper function used to present each item with character animation
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
        
        UIView.animate(withDuration: 1, delay: 3, animations: {
            hippoView.frame.origin.x += 900
        }, completion: {
            (finished) in
            // textboxView.isHidden = finished
            // posLabel.isHidden = finished
            textboxView.removeFromSuperview()
            posLabel.removeFromSuperview()
            self.tapNextItem.isEnabled = true
        })
    }
    
    // Helper function used to finish game with character animation
    private func endGameAnimation() {
        let hippo = UIImage(named: "hippofull")
        let textbox = UIImage(named: "textbook3")
        
        let hippoView = UIImageView(frame: CGRect(x: 16, y: 520, width: 120, height: 120))
        hippoView.contentMode = .scaleAspectFill
        hippoView.image = hippo
        let textboxView = UIImageView(frame: CGRect(x: 84, y: 379, width: 200, height: 100))
        textboxView.contentMode = .scaleAspectFill
        textboxView.image = textbox
        
        let posLabel = UILabel(frame: CGRect(x: 93, y: 365, width: 180, height: 90))
        posLabel.textAlignment = .center
        posLabel.numberOfLines = 3
        posLabel.text = "Great job! \n You found all the items!"
        
        view.addSubview(hippoView)
        view.addSubview(textboxView)
        view.addSubview(posLabel)
    }
    
    // Helper function to add character and textbox to view
    private func addSpeakingCharacterToView(character: UIImage, textbox: UIImage) {
        let posLabel = UILabel(frame: CGRect(x: 93, y: 370, width: 180, height: 90))
        posLabel.textAlignment = .center
        
        let hippoView = UIImageView(frame: CGRect(x: 16, y: 520, width: 120, height: 120))
        hippoView.contentMode = .scaleAspectFill
        hippoView.image = character
        let textboxView = UIImageView(frame: CGRect(x: 84, y: 379, width: 200, height: 100))
        textboxView.contentMode = .scaleAspectFill
        textboxView.image = textbox
    }
    
    @objc private func nextItem() {
        if index - 1 < (playList?.items.count)! {
            tapNextItem.isEnabled = false
            itemQuantity.isHidden = false
            finishedButton.isHidden = false
            playItem(item: (playList?.items[index - 1])!, index: index)
            index += 1
        } else if index > (playList?.items.count)! {
            // Finish game
            tapNextItem.isEnabled = false
            
            itemImage.isHidden = true
            itemQuantity.isHidden = true
            finishedButton.isHidden = true
            endGameAnimation()
            
            tapEndGame = UITapGestureRecognizer(target: self, action: #selector(endGame))
            view.addGestureRecognizer(tapEndGame)
        }
    }
    
    @objc private func endGame() {
        let playstoryController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeScreen") as! HomeViewController
        navigationController?.pushViewController(playstoryController, animated: true)
    }

}

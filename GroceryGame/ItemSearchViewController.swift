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
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemQuantity: UITextField!
    @IBOutlet weak var checkmarkButton: UIButton!
    @IBOutlet var tapNextItem: UITapGestureRecognizer!
    @IBOutlet var tapEndGame: UITapGestureRecognizer!
    
    // Store grocery list for current game
    var playList: GroceryList?
    
    // Current position in the list of items; need to change implementation to randomize item order
    var index = 1
    
    // var points = Int()
    
    var touchLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        listCounter.text = String(playList!.items.count)
        
        tapNextItem = UITapGestureRecognizer(target: self, action: #selector(playGame))
        view.addGestureRecognizer(tapNextItem)
        
        itemNameLabel.isHidden = true
        itemImage.isHidden = true
        itemQuantity.isHidden = true
        checkmarkButton.isHidden = true
        
        touchLabel.text = "Touch the screen to start"
        touchLabel.textColor = .lightGray
        touchLabel.sizeToFit()
        touchLabel.center = view.center
        view.addSubview(touchLabel)
    }
    
    // MARK: Actions
    
    @IBAction func unwindToItemSearch(sender: UIStoryboardSegue) {
        /*
        if let sourceController = sender.source as? ExerciseGameController {
            points = sourceController.points
        }
        */
        if index > (playList?.items.count)! {
            // Finish game
            itemNameLabel.isHidden = true
            itemImage.isHidden = true
            itemQuantity.isHidden = true
            checkmarkButton.isHidden = true
            listCounter.text = String(Int(listCounter.text!)! - 1)
            cartCounter.text = String(Int(cartCounter.text!)! + 1)
            // pointsLabel.text = String(points)
            endGameScreen()
            
            tapEndGame = UITapGestureRecognizer(target: self, action: #selector(endGame))
            view.addGestureRecognizer(tapEndGame)
        } else {
            // Move item from list to cart
            listCounter.text = String(Int(listCounter.text!)! - 1)
            cartCounter.text = String(Int(cartCounter.text!)! + 1)
            // pointsLabel.text = String(points)
            // Keep playing and continue to next item
            playGame()
        }
    }
    
    // MARK: Private Methods
    
    // Helper function used to present each item with character animation
    private func presentItemAnimation() {
        itemNameLabel.isHidden = true
        itemImage.isHidden = true
        itemQuantity.isHidden = true
        checkmarkButton.isHidden = true
        
        let hippo = UIImage(named: "hippofull")
        let textbox = UIImage(named: "emptyTextboxLeft")
        let presentingLabel = UILabel(frame: CGRect(x: 93, y: 370, width: 180, height: 90))
        
        presentingLabel.textAlignment = .center
        let nf = NumberFormatter()
        nf.numberStyle = .ordinal
        presentingLabel.text = "Your \(nf.string(from: index as NSNumber) ?? "") item is..."
        
        let hippoView = UIImageView(frame: CGRect(x: 16, y: 520, width: 120, height: 120))
        hippoView.contentMode = .scaleAspectFill
        hippoView.image = hippo
        let textboxView = UIImageView(frame: CGRect(x: 84, y: 379, width: 200, height: 100))
        textboxView.contentMode = .scaleAspectFill
        textboxView.image = textbox
 
        view.addSubview(hippoView)
        view.addSubview(textboxView)
        view.addSubview(presentingLabel)
        
        UIView.animate(withDuration: 1, delay: 2, options: [.curveEaseIn], animations: {
            textboxView.alpha = 0
            presentingLabel.alpha = 0
            hippoView.frame.origin.x += 900
        }, completion: { _ in
            textboxView.removeFromSuperview()
            presentingLabel.removeFromSuperview()
            hippoView.removeFromSuperview()
            self.itemNameLabel.isHidden = false
            self.itemImage.isHidden = false
            self.itemQuantity.isHidden = false
            self.checkmarkButton.isHidden = false
        })
    }
    
    // Helper function used to finish game with character screen
    private func endGameScreen() {
        let hippo = UIImage(named: "hippofull")
        let textbox = UIImage(named: "textbook3")
        
        let hippoView = UIImageView(frame: CGRect(x: 16, y: 520, width: 120, height: 120))
        hippoView.contentMode = .scaleAspectFill
        hippoView.image = hippo
        let textboxView = UIImageView(frame: CGRect(x: 84, y: 379, width: 200, height: 100))
        textboxView.contentMode = .scaleAspectFill
        textboxView.image = textbox
        
        let endingLabel = UILabel(frame: CGRect(x: 91, y: 363, width: 180, height: 90))
        endingLabel.textAlignment = .center
        endingLabel.numberOfLines = 3
        endingLabel.text = "Great job! \n You found all the items!"
        
        view.addSubview(hippoView)
        view.addSubview(textboxView)
        view.addSubview(endingLabel)
    }
    
    /*
    // Helper function to add character and textbox to view
    private func addSpeakingCharacterToView(character: UIImage, textbox: UIImage) {
        let presentingLabel = UILabel()
        presentingLabel.textAlignment = .center
        
        let characterView = UIImageView(frame: CGRect(x: 16, y: 520, width: 120, height: 120))
        characterView.contentMode = .scaleAspectFill
        characterView.image = character
        let textboxView = UIImageView(frame: CGRect(x: 84, y: 379, width: 200, height: 100))
        textboxView.contentMode = .scaleAspectFill
        textboxView.image = textbox
        
        view.addSubview(characterView)
        view.addSubview(textboxView)
    }
    */

    // Request each item on the list
    @objc private func playGame() {
        touchLabel.isHidden = true
        tapNextItem.isEnabled = false
        
        let i = index - 1
        let item = (playList?.items[i])!
        if i < (playList?.items.count)! {
            itemNameLabel.isHidden = false
            itemImage.isHidden = false
            itemQuantity.isHidden = false
            checkmarkButton.isHidden = false
            // playItem(item: (playList?.items[i])!, index: index)
            itemNameLabel.text = item.itemName
            itemImage.image = item.image
            itemQuantity.text = "Quantity: \(item.quantity)"
            presentItemAnimation()
            index += 1
        }
    }
    
    // Go to home screen when exiting Play mode
    @objc private func endGame() {
        let homeController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeScreen") as! HomeViewController
        navigationController?.pushViewController(homeController, animated: true)
    }
    
}

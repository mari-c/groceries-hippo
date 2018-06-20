//
//  PlaystoryViewController.swift
//  playStory
//
//  Created by ahely on 2018-05-24.
//  Copyright © 2018 ahely. All rights reserved.
//

import UIKit

class PlaystoryViewController: UIViewController {
    
    // MARK: Properties

    @IBOutlet weak var viewtap: UIImageView!
    @IBOutlet weak var rightFeet: UIImageView!
    @IBOutlet weak var leftFeet: UIImageView!
    @IBOutlet weak var hippoBody: UIImageView!
    @IBOutlet weak var hippoFull: UIImageView!
    @IBOutlet weak var textbox1: UIImageView!
    @IBOutlet weak var textbox2: UIImageView!
    
    @IBOutlet weak var listCounter: UITextField!
    @IBOutlet weak var cartCounter: UITextField!
    
    // Store grocery list for current game
    var playList: GroceryList?
    
    var tapGesture: UITapGestureRecognizer?
    
    var arrowView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listCounter.text = String(playList!.items.count)
        
        viewtap.isUserInteractionEnabled = true
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(askForHelpAnimation))
        viewtap.addGestureRecognizer(tapGesture!)
        
        welcomeAnimation()
    }

    /*
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    */
    
    // MARK: Private Methods
    
    private func welcomeAnimation() {
        let arrowFrame = CGRect(x: 219, y: 433, width: 20, height: 20)
        showTextboxArrow(frame: arrowFrame)
        UIView.animate(withDuration: 0.7, delay: 0, options: [.repeat, .autoreverse, .curveEaseInOut], animations: {
            self.rightFeet.frame.origin.y -= 20
        })
    }
    
    @objc private func askForHelpAnimation() {
        arrowView.isHidden = true
        UIView.animate(withDuration: 1, delay: 0, options: [.curveEaseInOut], animations: {
            self.viewtap.isUserInteractionEnabled = false
            self.rightFeet.isHidden = true
            self.leftFeet.isHidden = true
            self.hippoBody.isHidden = true
            self.textbox1.isHidden = true
            self.hippoFull.isHidden = false
            self.hippoFull.frame.origin.x += 183
        }, completion: { _ in
            self.viewtap.isUserInteractionEnabled = true
            self.textbox2.isHidden = false
            let arrowFrame = CGRect(x: 99, y: 433, width: 20, height: 20)
            self.showTextboxArrow(frame: arrowFrame)
            self.arrowView.isHidden = false
            self.tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.playToGetItems))
            self.viewtap.addGestureRecognizer(self.tapGesture!)
            })
    }
    
    private func showTextboxArrow(frame: CGRect) {
        arrowView.frame = frame
        arrowView.contentMode = .scaleAspectFill
        arrowView.image = UIImage(named: "BackIcon")
        arrowView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        view.addSubview(arrowView)
        
        UIView.animate(withDuration: 1, delay: 0, options: [.repeat, .curveEaseInOut], animations: {
            self.arrowView.frame.origin.x += 10
        })
    }
    
    @objc private func playToGetItems() {
        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "getItemPage") as! ItemSearchViewController
        nextViewController.playList = playList
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
}


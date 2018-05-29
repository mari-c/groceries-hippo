//
//  ItemPopoverViewController.swift
//  GroceryGame
//
//  Created by mariana on 2018-05-25.
//  Copyright © 2018 none. All rights reserved.
//

import UIKit

class ItemPopoverViewController: UIViewController, UITextFieldDelegate, UIPopoverPresentationControllerDelegate {
    
    // MARK: Properties
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var quantityTextField: UITextField!
    @IBOutlet weak var quantityStepper: UIStepper!
    
    var itemToAdd: GroceryItem?
    
    // Text field tags
    var NAME_TF_TAG = 1
    var QUANTITY_TF_TAG = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Handle text field user input through delegate callbacks
        nameTextField.delegate = self
        nameTextField.tag = NAME_TF_TAG
        quantityTextField.delegate = self
        quantityTextField.tag = QUANTITY_TF_TAG
    }

    /*
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    */
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable Ok button whilst editing
        // okButton.isEnabled = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.tag == QUANTITY_TF_TAG {
            quantityStepper.value = Double(quantityTextField.text!)!
        }
    }
    
    // MARK: UIPopoverPresentationControllerDelegate
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    
    // MARK: Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        itemToAdd = GroceryItem(itemName: nameTextField.text!, image: nil, quantity: Int(quantityTextField.text!)!)
        
        /*
        // Configure popover presentation
        if segue.identifier == "popAdd" {
            let dst = segue.destination
            if let pop = dst.popoverPresentationController {
                pop.delegate = self
            }
        }
        */
    }
    
    // MARK: Actions
    
    @IBAction func stepperChanged(_ sender: UIStepper) {
        quantityTextField.text = Int(sender.value).description
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}

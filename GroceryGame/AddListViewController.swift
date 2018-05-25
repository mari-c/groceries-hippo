//
//  AddListViewController.swift
//  GroceryGame
//
//  Created by mariana on 2018-05-22.
//  Copyright © 2018 none. All rights reserved.
//

import UIKit
import os.log

class AddListViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, UIPopoverPresentationControllerDelegate {
    
    // MARK: Properties
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    // Popover window properties
    @IBOutlet weak var quantityTextField: UITextField!
    @IBOutlet weak var quantityStepper: UIStepper!
    
    var items: [GroceryList.GroceryItem] = []
    var list: GroceryList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load sample items
        loadSampleItems()
        
        // Handle text field user input through delegate callbacks
        nameTextField.delegate = self
        
        // Configure popover window stepper
        quantityStepper.autorepeat = true
        
        // Set table view with grocery lists
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.layer.borderWidth = 0.5
        tableView.layer.borderColor = UIColor.lightGray.cgColor
        
        // TODO: Set up view if editing existing GroceryList
        
        
        // Enable the Save button only if text field has a valid GroceryList name
        updateSaveButtonState()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable Save button whilst editing
        saveButton.isEnabled = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        navigationItem.title = textField.text
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Use cell identifier to dequeue item table view cells
        let cellIdentifier = "ItemTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ItemTableViewCell else {
            fatalError("Dequeued cell is not an instance of ItemTableViewCell")
        }
        
        // cell.textLabel?.text = self.items[indexPath.row].itemName
        
        // Fetch corresponding item and configure the cell
        let item = items[indexPath.row]
        cell.nameLabel.text = item.itemName
        cell.quantityLabel.text = String(item.quantity)
        
        return cell
    }
    
    // MARK: UIPopoverPresentationControllerDelegate
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    // MARK: Navigation
    
    // Configure view controller before presenting it
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        // Configure popover presentation
        if segue.identifier == "popAdd" {
            let dst = segue.destination
            if let pop = dst.popoverPresentationController {
                pop.delegate = self
            }
        }
        
        // Configure the destination view controller only when save button is pressed
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The Save button was not pressed. Cancelling.", log: OSLog.default, type: .debug)
            return
        }
        
        let name = nameTextField.text ?? ""
        
        // Set the list to be passed to ListTableViewController after the unwind segue
        list = GroceryList(name: name, items: items)
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        // TODO: fix cancel behaviour (problem with checking modal vs push)
        
        // Dismiss this view controller depending on the style of presentation (modal or push)
        let isPresentingInNewListMode = presentingViewController is UINavigationController
        
        if isPresentingInNewListMode {
            dismiss(animated: true, completion: nil)
        } else if let owningNavigationController = navigationController {
            owningNavigationController.popViewController(animated: true)
        } else {
            fatalError("The AddListViewController is not inside a navigation controller.")
        }
    }
    
    // MARK: Actions
    
    @IBAction func addItem(_ sender: UIButton) {
        // TODO: implement addItem action
        // Delete this after implementation:
        // Open some sort of window with text field and quantity, add item to 'items' with button click, call insertCellItem() to display item info on the table view
        
        performSegue(withIdentifier: "popAdd", sender: self)
    }
    
    @IBAction func deleteItem(_ sender: UIButton) {
        // TODO: implement deleteItem action
        // Delete this after implementation:
        // Open the 'delete menu' (red selection), delete the corresponding item from 'items', call deleteItemCell() to remove the item cell from the table view
    }
    
    @IBAction func stepperChanged(_ sender: UIStepper) {
    }
    
    // MARK: Private Methods
    
    private func loadSampleItems() {
        let milk = GroceryList.GroceryItem(itemName: "Milk", image: UIImage(named: "milkCarton"), quantity: 1)
        let eggs = GroceryList.GroceryItem(itemName: "Eggs", image: UIImage(named: "eggCarton"), quantity: 2)
        let cereal = GroceryList.GroceryItem(itemName: "Cereal", image: UIImage(named: "cerealCarton"), quantity: 3)
        
        items.append(milk!)
        items.append(eggs!)
        items.append(cereal!)
    }
    
    // Helper function to add given item to ItemTableViewCell
    private func insertItemCell() {
        // TODO: implement insertItemCell
        
        let indexPath = IndexPath(row: items.count - 1, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    // Helper function to delete given item from ItemTableViewCell
    private func deleteItemCell() {
        // TODO: implement deleteItemCell
    }
    
    private func updateSaveButtonState() {
        // Disable the Save button if text field is empty
        let text = nameTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
}

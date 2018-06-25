//
//  AddListViewController.swift
//  GroceryGame
//
//  Created by mariana on 2018-05-22.
//  Copyright © 2018 none. All rights reserved.
//

import UIKit
import os.log

class AddListViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: Properties
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var items: [GroceryItem] = []
    var list: GroceryList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Handle text field user input through delegate callbacks
        nameTextField.delegate = self
        
        // Set table view with grocery lists
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.layer.borderWidth = 0.5
        tableView.layer.borderColor = UIColor.lightGray.cgColor
        
        // Set up view if editing existing GroceryList
        if let list = list {
            navigationItem.title = list.name
            nameTextField.text = list.name
            items = list.items
        }
        
        // Load sample items
        // loadSampleItems()
        
        // Enable the Save button only if text field has a valid GroceryList name
        updateSaveButtonState()
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
        
        // Fetch corresponding item and configure the cell
        let item = items[indexPath.row]
        cell.nameLabel.text = item.itemName
        cell.quantityLabel.text = String(item.quantity)
        
        // Enable the Save button only if GroceryList has items
        updateSaveButtonState()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: Navigation
    
    // Configure view controller before presenting it
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        
        // Configure popover presentation
        if segue.identifier == "popAdd" {
            let dst = segue.destination
            if let pop = dst.popoverPresentationController {
                let popoverViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "popoverNewItem") as! ItemPopoverViewController
                pop.delegate = popoverViewController
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
        performSegue(withIdentifier: "popAdd", sender: self)
    }
    
    @IBAction func deleteItem(_ sender: UIButton) {
        if sender.currentTitle == "Delete Item" {
            tableView.isEditing = true
            sender.setTitle("Done Deleting", for: .normal)
        } else if sender.currentTitle == "Done Deleting" {
            tableView.isEditing = false
            sender.setTitle("Delete Item", for: .normal)
        }
    }
    
    @IBAction func unwindToAddItemToList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? ItemPopoverViewController, let item = sourceViewController.itemToAdd {
            items.append(item)
            insertItemCell()
        }
    }
    
    // MARK: Private Methods
    
    private func loadSampleItems() {
        let milk = GroceryItem(itemName: "Milk", image: UIImage(named: "milkCarton"), quantity: 1)
        let eggs = GroceryItem(itemName: "Eggs", image: UIImage(named: "eggCarton"), quantity: 2)
        let cereal = GroceryItem(itemName: "Cereal", image: UIImage(named: "cerealCarton"), quantity: 3)
        
        items.append(milk!)
        items.append(eggs!)
        items.append(cereal!)
    }
    
    // Helper function to add given item to ItemTableViewCell
    private func insertItemCell() {
        let indexPath = IndexPath(row: items.count - 1, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    private func updateSaveButtonState() {
        // Disable the Save button if text field is empty
        let text = nameTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty && !items.isEmpty
    }
    
}

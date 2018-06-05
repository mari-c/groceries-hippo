//
//  ListTableViewController.swift
//  GroceryGame
//
//  Created by mariana on 2018-05-22.
//  Copyright © 2018 none. All rights reserved.
//

import UIKit
import os.log

class ListTableViewController: UITableViewController {
    
    // MARK: Properties
    
    var lists = [GroceryList]()
    
    // Store selected list that will be used in Playstory
    var selectedList: GroceryList?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(false, animated: false)
        
        // Load saved grocery lists, otherwise load sample lists data
        if let savedLists = loadGroceryLists() {
            lists += savedLists
        } else {
            loadSampleLists()
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    /*
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    */

    // MARK: Table view data source

    // Specify how many sections to display in table view
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    // Specify how many rows to display in given section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lists.count
    }

    // Configure cell to display at given row -- only asks for cells being displayed
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier
        if restorationIdentifier == "SelectPlaystoryList" {
            // Displaying cells in the Playstory storyboard
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            
            // Fetch appropriate list
            let list = lists[indexPath.row]
            
            // Configure the cell
            cell.textLabel?.text = list.name
            
            return cell
            
        } else {
            // Displaying cells in the Main storyboard
            let cellIdentifier = "ListTableViewCell"
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ListTableViewCell else {
                fatalError("Dequeued cell is not an instance of ListTableViewCell")
            }
            
            // Fetch appropriate list
            let list = lists[indexPath.row]
            
            // Configure the cell
            cell.nameLabel.text = list.name
            cell.trashButton.tag = indexPath.row
            cell.trashButton.addTarget(self, action: #selector(deleteSelectedGroceryList(_:)), for: .touchUpInside)
            cell.editButton.tag = indexPath.row
            
            return cell
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            lists.remove(at: indexPath.row)
            saveGroceryLists()
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        /*
        else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
        */
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if restorationIdentifier == "SelectPlaystoryList" {
            selectedList = GroceryList(name: lists[indexPath.row].name, items: lists[indexPath.row].items)
        }
    }

    // MARK: Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch (segue.identifier ?? "") {
        case "NewList":
            os_log("Adding a new grocery list.", log: OSLog.default, type: .debug)
        case "EditList":
            guard let listDetailViewController = segue.destination as? AddListViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            /*
            guard let selectedListCell = sender as? ListTableViewCell else {
                fatalError("Unexpected sender: \(sender ?? "")")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedListCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            */
            
            guard let selectedListButton = sender as? UIButton else {
                fatalError("Unexpected sender: \(sender ?? "")")
            }
            
            let indexPath = IndexPath(row: selectedListButton.tag, section: 0)
            
            let selectedList = lists[indexPath.row]
            listDetailViewController.list = selectedList
        case "StartPlaystory":
            navigationController?.setNavigationBarHidden(true, animated: false)
            let playstoryController = segue.destination as! PlaystoryViewController
            playstoryController.playList = selectedList!
            os_log("Starting game..", log: OSLog.default, type: .debug)
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier ?? "")")
        }
    }
    
    // MARK: Actions
    
    @IBAction func unwindToGroceryLists(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? AddListViewController, let list = sourceViewController.list {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing grocery list
                lists[selectedIndexPath.row] = list
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            } else {
                // Add a new grocery list
                let newIndexPath = IndexPath(row: lists.count, section: 0)
                lists.append(list)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            
            // Save the grocery lists
            saveGroceryLists()
        }
    }
    
    @IBAction func deleteSelectedGroceryList(_ sender: UIButton) {
        let indPath = IndexPath(row: sender.tag, section: 0)
        lists.remove(at: indPath.row)
        saveGroceryLists()
        tableView.deleteRows(at: [indPath], with: .fade)
    }
    
    // MARK: Private Methods
    
    private func loadSampleLists() {
        let milk1 = GroceryItem(itemName: "Milk", image: UIImage(named: "milkCarton"), quantity: 1)
        let milk2 = GroceryItem(itemName: "Milk", image: UIImage(named: "milkCarton"), quantity: 2)
        let eggs1 = GroceryItem(itemName: "Eggs", image: UIImage(named: "eggCarton"), quantity: 1)
        let eggs2 = GroceryItem(itemName: "Eggs", image: UIImage(named: "eggCarton"), quantity: 2)
        let cereal = GroceryItem(itemName: "Cereal", image: UIImage(named: "cerealCarton"), quantity: 3)
        
        guard let list1 = GroceryList(name: "Sample List 1", items: [milk2!]) else {
            fatalError("Unable to instantiate sample list 1")
        }
        guard let list2 = GroceryList(name: "Sample List 2", items: [milk1!, eggs1!, cereal!]) else {
            fatalError("Unable to instantiate sample list 2")
        }
        guard let list3 = GroceryList(name: "Sample List 3", items: [milk2!, eggs2!, cereal!]) else {
            fatalError("Unable to instantiate sample list 3")
        }
        
        lists += [list1, list2, list3]
    }
    
    private func saveGroceryLists() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(lists, toFile: GroceryList.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("Grocery lists successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save grocery lists.", log: OSLog.default, type: .error)
        }
    }
    
    private func loadGroceryLists() -> [GroceryList]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: GroceryList.ArchiveURL.path) as? [GroceryList]
    }

}

//
//  ListTableViewController.swift
//  GroceryGame
//
//  Created by mariana on 2018-05-22.
//  Copyright © 2018 none. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController {
    
    // MARK: Properties
    
    var lists = [GroceryList]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load sample lists data
        loadSampleLists()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

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
        let cellIdentifier = "ListTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ListTableViewCell else {
            fatalError("Dequeued cell is not an instance of ListTableViewCell")
        }
        
        // Fetch appropriate list
        let list = lists[indexPath.row]

        // Configure the cell
        cell.nameLabel.text = list.name

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: Private Methods
    
    private func loadSampleLists() {
        let milk1 = GroceryList.GroceryItem(itemName: "Milk", image: UIImage(named: "milkCarton"), quantity: 1)
        let milk2 = GroceryList.GroceryItem(itemName: "Milk", image: UIImage(named: "milkCarton"), quantity: 2)
        let eggs1 = GroceryList.GroceryItem(itemName: "Eggs", image: UIImage(named: "eggCarton"), quantity: 1)
        let eggs2 = GroceryList.GroceryItem(itemName: "Eggs", image: UIImage(named: "eggCarton"), quantity: 2)
        let cereal = GroceryList.GroceryItem(itemName: "Cereal", image: UIImage(named: "cerealCarton"), quantity: 3)
        
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

}

//
//  DishListTableViewController.swift
//  Restaurants-Booker
//
//  Created by Muhammad Faisal Imran Khan on 30/12/18.
//  Copyright © 2018 MI Apps. All rights reserved.
//

import UIKit
import os.log
class DishListTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var dishes = [Dish]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(DishListTableViewController.editButtonPressed))
        
        
        self.tableView.separatorStyle = .none
        
    }
    
    
    @objc func editButtonPressed(){
        tableView.setEditing(!tableView.isEditing, animated: true)
        if tableView.isEditing == true{
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(DishListTableViewController.editButtonPressed))
        }else{
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(DishListTableViewController.editButtonPressed))
        }
    }
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dishes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "DishListTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? DishListTableViewCell  else {
            fatalError("The dequeued cell is not an instance of DishListTableViewCell.")
        }
        
        let dish = dishes[indexPath.row]
        cell.textLabel?.text = dish.name + " at " + dish.price
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            dishes.remove(at: indexPath.row)
            
            saveDishes()
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedDish = dishes[sourceIndexPath.row]
        
        dishes.remove(at: sourceIndexPath.row)
        
        dishes.insert(movedDish, at: destinationIndexPath.row)
        
        saveDishes()
        
        NSLog("%@", "\(sourceIndexPath.row) => \(destinationIndexPath.row) \(dishes)")
    }
    
    private func saveDishes() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(dishes, toFile: Dish.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("Dishes successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save dishes...", log: OSLog.default, type: .error)
        }
    }
    
    @IBAction func unwindToItemList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? DishListItemViewController, let dish = sourceViewController.dish {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing meal.
                dishes[selectedIndexPath.row] = dish
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else {
                // Add a new meal.
                let newIndexPath = IndexPath(row: dishes.count, section: 0)
                
                dishes.append(dish)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            
            saveDishes()
            
            
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
        case "AddItem":
            
            os_log("Adding a new item.", log: OSLog.default, type: .debug)
            
        case "ShowDetail":
            guard let itemDetailViewController = segue.destination as? DishListItemViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedItemCell = sender as? DishListTableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedItemCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedItem = dishes[indexPath.row]
            itemDetailViewController.dish = selectedItem
            
            
        case "dish_complete":
            os_log("Adding a new owner.", log: OSLog.default, type: .debug)
            
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
    }
    
    
    private func loadDishes() -> [Dish]?  {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Dish.ArchiveURL.path) as? [Dish]
    }
    
    
    
}

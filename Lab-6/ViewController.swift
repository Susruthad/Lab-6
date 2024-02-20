//
//  ViewController.swift
//  Lab-6
//
//  Created by user240733 on 2/19/24.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var listOfItems: [String] = []
    
    let userDefaults = UserDefaults.standard
    
    @IBOutlet weak var listTableView: UITableView!

    
    @IBAction func addButton(_ sender: Any) {
        let alert = UIAlertController(title: "Add Item", message: nil, preferredStyle: .alert)
                  
                  alert.addTextField { (textField) in
                      textField.placeholder = "Write an Item"
                  }
                  
                  alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { [weak alert] (_) in
                      alert?.dismiss(animated: true)
                  }))
                  
                  alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
                      let textField = alert?.textFields![0]
                      if let newItem = textField?.text, !newItem.isEmpty {
                          self.listOfItems.append(newItem)
                          self.saveItems()
                          self.listTableView.reloadData()
                      }
                  }))
                  
                  self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
            super.viewDidLoad()
        listTableView.dataSource = self
        listTableView.delegate = self
            getItemsFromStorage()
        }

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return listOfItems.count
        }
        
        
        //Display Items
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
            cell.textLabel?.text = listOfItems[indexPath.row]
            return cell
        }
        
    //Remove item from saved storage
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                listOfItems.remove(at: indexPath.row)
                saveItems()
                listTableView.deleteRows(at: [indexPath], with: .automatic)
            }
        }
        

        //Save the Item to storage
        func saveItems() {
             userDefaults.set(listOfItems, forKey: "SavedItems")
         }
        
        //Get Items from storage
        func getItemsFromStorage() {
             if let savedItems = userDefaults.array(forKey: "SavedItems") as? [String] {
                 listOfItems = savedItems
             } else {
                 listOfItems = ["Item 1","Item 2","Item 3","Item 4","Item 5","Item 6","Item 7","Item 8"]
             }
         }
    }

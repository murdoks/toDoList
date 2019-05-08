//
//  ViewController.swift
//  Todoey
//
//  Created by Luis Rubio on 5/2/19.
//  Copyright © 2019 Luis Rubio. All rights reserved.
//

import UIKit

class tableViewController: UITableViewController {

    var itemArray = ["Find Mike", "Buy Eggos", "Destroy Demogorgon"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //MARK - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }

    //MARK - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        print(itemArray[indexPath.row])
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
            
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - Add new Items, new toDOs

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New toDo", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Confirm", style: .default) { (action) in
            //In this closure/variable is managed when user clicks the ADD button and trigger UIAlert
            print(textField.text as Any)
            self.itemArray.append(textField.text!)
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Fill your new toDo"
            textField = alertTextField
            
            print("I am when the alert shows")
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    
    }
    
} //Final


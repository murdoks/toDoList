//
//  ViewController.swift
//  Todoey
//
//  Created by Luis Rubio on 5/2/19.
//  Copyright © 2019 Luis Rubio. All rights reserved.
//

import UIKit

class tableViewController: UITableViewController {
    
    let defaults = UserDefaults.standard
    
    var itemArray = [list]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let newList = list()
        newList.tittle = "Find Mike"
        newList.done = true
        itemArray.append(newList)
//        if let items = defaults.array(forKey: "ToDOList") as? [String] {
//            itemArray = items
//        }
    }
    
    //MARK - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoItemCell", for: indexPath)
        let list = itemArray[indexPath.row]
        
        
        cell.textLabel?.text = list.tittle
        
        if list.done == true {
            cell.accessoryType = .checkmark
        }else {
            cell.accessoryType = .none
        }
        
        return cell
    }

    //MARK - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
//        if itemArray[indexPath.row].done == false {
//            itemArray[indexPath.row].done = true
//        }else {
//            itemArray[indexPath.row].done = false
//        }
        
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        }else {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
        
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - Add new Items, new toDOs

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New toDo", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Confirm", style: .default) { (action) in
            //In this closure/variable is managed when user clicks the ADD button and trigger UIAlert
            print(textField.text as Any)
            
            let newList = list()
            newList.tittle = textField.text!
            self.itemArray.append(newList)
            
            self.defaults.set(self.itemArray, forKey: "ToDOList")
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


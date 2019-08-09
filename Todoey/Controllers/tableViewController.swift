//
//  ViewController.swift
//  Todoey
//
//  Created by Luis Rubio on 5/2/19.
//  Copyright © 2019 Luis Rubio. All rights reserved.
//

import UIKit
import CoreData

class tableViewController: UITableViewController {
    
//    let defaults = UserDefaults.standard
    
    var itemArray = [List]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//    let dataPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("List.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        print(dataPath)
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
//        let newList = list()
//        newList.tittle = "Find Mike"
//        itemArray.append(newList)

            loadList()
//        if let items = defaults.array(forKey: "ToDOList") as? [list] {
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
        
        
        cell.textLabel?.text = list.title
        
        cell.accessoryType = list.done ? .checkmark : .none //<- ternary operator
//        cell.accessoryType = list.done == true ? .checkmark : .none //<- ternary operator
        
//        if list.done == true {
//            cell.accessoryType = .checkmark
//        }else {
//            cell.accessoryType = .none
//        }
        
        return cell
    }

    //MARK - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        print(itemArray[indexPath.row])
        
//        context.delete(itemArray[indexPath.row]) to delete Data
//        itemArray.remove(at: indexPath.row)
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveList()
        
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
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - Add new Items, new toDOs

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New toDo", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Confirm", style: .default) { (action) in
            //In this closure/variable is managed when user clicks the ADD button and trigger UIAlert
            print(textField.text as Any)
            
            let newList = List(context: self.context)
            newList.title = textField.text!
            newList.done = false
            self.itemArray.append(newList)
            
            self.saveList()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Fill your new toDo"
            textField = alertTextField
            
            print("I am when the alert shows")
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    
    }
    
     //MARK - Model Manipulation Methods
    func saveList() {
        
//        self.defaults.set(self.itemArray, forKey: "ToDOList")
        
//        let encoder = PropertyListEncoder()
        do {
//            let data = try encoder.encode(itemArray)
//            try data.write(to: dataPath!)
            try context.save()
        } catch {
            print("Error saving context, \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    func loadList(with request: NSFetchRequest<List> = List.fetchRequest()) {
        
//        let request : NSFetchRequest<List> = List.fetchRequest()
        
        do {
            itemArray =  try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
        
        tableView.reloadData()
        
    }
    
    
} //Final

extension tableViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        let request : NSFetchRequest<List> = List.fetchRequest()
        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)

        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]

        loadList(with:  request)
        
//        print(searchBar.text!)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadList()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
            
        }
    }

}

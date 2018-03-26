//
//  ViewController.swift
//  Todoey
//
//  Created by Alex on 2/18/18.
//  Copyright © 2018 Alex. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let realm = try! Realm()

    var items: Results<Item>?
    var selectedCategory: Category?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadItems()
    }
    
    func saveItems(item: Item, category: Category){
        do {
            try realm.write {
                category.items.append(item)
            }
        } catch {
            print("Error saving items \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadItems(){
        
        items = selectedCategory?.items.sorted(byKeyPath: "dateCreated", ascending: true)
        tableView.reloadData()
    }

    
    @IBAction func addBtnPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            if let category = self.selectedCategory, let text = textField.text, text.count > 1{
                let item = Item()
                item.title = text
                item.dateCreated = Date()
                self.saveItems(item: item, category: category)
            }
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}

extension TodoListVC: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        if let item = items?[indexPath.row] {
            cell.textLabel?.text = item.title
            cell.accessoryType = item.done ? .checkmark : .none
        }else {
            cell.textLabel?.text = "No Items Added"
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if let item = items?[indexPath.row] {
            do {
                try realm.write {
                    item.done = !item.done
                }
            } catch {
                print("Error saving done status, \(error)")
            }
        }
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

extension TodoListVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        items = items?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        dismissKeyboard(searchBar: searchBar)
        tableView.reloadData()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        if searchBar.text?.count == 0 {
            loadItems()
        }

        if let length = searchBar.text?.count, length > 3 {
            items = items?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        }
        
        tableView.reloadData()

    }


    func dismissKeyboard(searchBar: UISearchBar){
        DispatchQueue.main.async {
            searchBar.resignFirstResponder()
        }
    }

}


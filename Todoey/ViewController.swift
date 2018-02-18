//
//  ViewController.swift
//  Todoey
//
//  Created by Alex on 2/18/18.
//  Copyright © 2018 Alex. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    
    @IBOutlet weak var todoListTableView: UITableView!
    
    let itemArray = ["Find Mike", "Buy Eggos", "Destory Demo"]

    override func viewDidLoad() {
        super.viewDidLoad()

        todoListTableView.dataSource = self
        todoListTableView.delegate = self
        
    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

//
//  ViewController.swift
//  DoIT
//
//  Created by Jason Villegas on 4/3/18.
//  Copyright © 2018 Jason Villegas. All rights reserved.
//

import UIKit

class DoITViewController: UITableViewController {

	
	var itemArray = ["Wash Car", "Find Mike", "Ride Bike"]
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}

	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
		
		cell.textLabel?.text = itemArray[indexPath.row]
		
		return cell
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return itemArray.count
	}
	
	//MARK - TableView Delegate Methods
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		//print(itemArray[indexPath.row])
		
		
		if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
			tableView.cellForRow(at: indexPath)?.accessoryType = .none
		} else {
			tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
		}

		tableView.deselectRow(at: indexPath, animated: true)
	}
	
	//MARK - Add new items
	
	@IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
		
		var textField = UITextField()
		
		let alert = UIAlertController(title: "Add new DoIT Item", message: "", preferredStyle: .alert)
		
		let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
			
			//Force unwrap as it will never be empty but can later add a block that doesn't allow user to add an empty item
			self.itemArray.append(textField.text!)
			self.tableView.reloadData()
		}
		
		alert.addTextField( configurationHandler: { (alertTextField) in
			alertTextField.placeholder = "Create New Item"
			textField = alertTextField
		})
		
		alert.addAction(action)
		present(alert, animated: true, completion: nil)
		
	}
	
}


//
//  ViewController.swift
//  DoIT
//
//  Created by Jason Villegas on 4/3/18.
//  Copyright © 2018 Jason Villegas. All rights reserved.
//

import UIKit

class DoITViewController: UITableViewController {

	
	let defaults = UserDefaults.standard
	
	var itemArray = [Item]()
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		let newItem = Item()
		newItem.title = "Wash Car"
		itemArray.append(newItem)

		let newItem2 = Item()
		newItem2.title = "Wash bike"
		itemArray.append(newItem2)

		let newItem3 = Item()
		newItem3.title = "Wash house"
		itemArray.append(newItem3)
		itemArray.append(newItem3)

		
		if let items = defaults.array(forKey: "DoITListArray") as? [Item] {
			itemArray = items
		}
		
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return itemArray.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "DoITCell", for: indexPath)
		
		cell.textLabel?.text = itemArray[indexPath.row].title
		
		
		cell.accessoryType = itemArray[indexPath.row].done ? .checkmark : .none

		return cell
	}
	
	//MARK - TableView Delegate Methods
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		//print(itemArray[indexPath.row])
		
		itemArray[indexPath.row].done = !itemArray[indexPath.row].done
		
		tableView.reloadData()
		tableView.deselectRow(at: indexPath, animated: true)
	}
	
	//MARK - Add new items
	
	@IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
		
		var textField = UITextField()
		
		let alert = UIAlertController(title: "Add new DoIT Item", message: "", preferredStyle: .alert)
		
		let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
			
			let addItem = Item()
			
			addItem.title = textField.text!
			
			//Force unwrap as it will never be empty but can later add a block that doesn't allow user to add an empty item
			self.itemArray.append(addItem)
			
			self.defaults.set(self.itemArray, forKey: "DoITListArray")
			
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


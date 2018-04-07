//
//  ViewController.swift
//  DoIT
//
//  Created by Jason Villegas on 4/3/18.
//  Copyright © 2018 Jason Villegas. All rights reserved.
//

import UIKit

class DoITViewController: UITableViewController {
	
	var itemArray = [Item]()
	
	
	let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		loadItems()
		
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
		
		saveItems()

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
			
			self.saveItems()
			
			
		}
		
		alert.addTextField( configurationHandler: { (alertTextField) in
			alertTextField.placeholder = "Create New Item"
			textField = alertTextField
		})
		
		alert.addAction(action)
		present(alert, animated: true, completion: nil)
		
	}
	
	func saveItems() {
		
		let encoder = PropertyListEncoder()
		
		do {
			let data = try encoder.encode(itemArray)
			try data.write(to: dataFilePath!)
		} catch {
			print("Error coding item array: \(error)")
		}
		
		tableView.reloadData()
	}
	
	func loadItems() {
	
		if let data = try? Data(contentsOf: dataFilePath!) {
			let decoder = PropertyListDecoder()
			do {
				itemArray = try decoder.decode([Item].self, from: data)
			} catch {
				print("Error decoding item, \(error)")
			}
		}
	}
	
}


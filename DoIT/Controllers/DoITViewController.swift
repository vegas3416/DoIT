//
//  ViewController.swift
//  DoIT
//
//  Created by Jason Villegas on 4/3/18.
//  Copyright © 2018 Jason Villegas. All rights reserved.
//

import UIKit
import CoreData

class DoITViewController: UITableViewController {
	
	var itemArray = [Item]()
	let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		//MARK: Delete this comment before production
		//Just something to kind of see where the database is for testing Nothing more..should delete before Production
		//printFileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist"))
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
		
//		context.delete(itemArray[indexPath.row])
//		itemArray.remove(at: indexPath.row)

		itemArray[indexPath.row].done = !itemArray[indexPath.row].done
		
		saveItems()

		tableView.deselectRow(at: indexPath, animated: true)
	}
	
	//MARK - Add new items
	
	@IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
		
		var textField = UITextField()
		
		let alert = UIAlertController(title: "Add new DoIT Item", message: "", preferredStyle: .alert)
		
		let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
			
			let addItem = Item(context: self.context)
			
			addItem.title = textField.text!
			addItem.done = false
			
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
		
		do {
			try context.save()
		} catch {
			print("Error saving context \(error)")
		}
		
		tableView.reloadData()
	}
	
	func loadItems() {
		
		let request: NSFetchRequest<Item> = Item.fetchRequest()
		
		do {
			itemArray = try context.fetch(request)
		} catch {
			print("Error fetching data from context \(error)")
		}
		
		
	}
	
}


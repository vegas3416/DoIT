//
//  CategoryViewController.swift
//  DoIT
//
//  Created by Jason Villegas on 4/8/18.
//  Copyright © 2018 Jason Villegas. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

	var categoriesArray = [Category]()
	let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
	
    override func viewDidLoad() {
        super.viewDidLoad()

		loadCatgories()

    }

	//MARK: TableView Datasource Methods
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return categoriesArray.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
		
		cell.textLabel?.text = categoriesArray[indexPath.row].name
		
		return cell
		
	}
	
	@IBAction func addButtonPressed(_ sender: Any) {
		
		var textField = UITextField()
		
		let alert = UIAlertController(title: "Add new category", message: "", preferredStyle: .alert)
		
		let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
			
			let addItem = Category(context: self.context)
			addItem.name = textField.text!
			
			//Force unwrap as it will never be empty but can later add a block that doesn't allow user to add an empty item
			self.categoriesArray.append(addItem)
			
			self.saveCategories()
		}

		alert.addTextField( configurationHandler: { (alertTextField) in
			alertTextField.placeholder = "Create New Category"
			textField = alertTextField
		})
		
		alert.addAction(action)
		present(alert, animated: true, completion: nil)
	}
	
	//MARK: Manipulation Methods
	func saveCategories() {
		
		do {
			try context.save()
		} catch {
			print("Error saving category \(error)")
		}
		
		tableView.reloadData()
	}
	
	func loadCatgories(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
		
		do {
			categoriesArray = try context.fetch(request)
		} catch {
			print("Error fetching data from categoryDB \(error)")
		}
		
		tableView.reloadData()
	}
	
	//MARK: TableVoew Delegate Methods
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		performSegue(withIdentifier: "goToItems", sender: self)
		
		
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		let destinationVC = segue.destination as! DoITViewController
		
		if let indexPath = tableView.indexPathForSelectedRow {
			destinationVC.selectedCategory = categoriesArray[indexPath.row]
		}
	}
	
	
}

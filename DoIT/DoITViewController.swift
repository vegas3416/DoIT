//
//  ViewController.swift
//  DoIT
//
//  Created by Jason Villegas on 4/3/18.
//  Copyright © 2018 Jason Villegas. All rights reserved.
//

import UIKit

class DoITViewController: UITableViewController {

	
	let itemArray = ["Wash Car", "Find Mike", "Ride Bike"]
	
	
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
	
	

}


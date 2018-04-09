//
//  DoITVCExtension.swift
//  DoIT
//
//  Created by Jason Villegas on 4/8/18.
//  Copyright © 2018 Jason Villegas. All rights reserved.
//

import UIKit
import CoreData

extension DoITViewController {
	
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		let request: NSFetchRequest<Item> = Item.fetchRequest()
		
		//The 'title' is the title attribute from the Item Entity. Looks weird that you are just typing a name but know its looking
		//at the 'title' or a value that is part of the Item Entity.
		let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
		
		request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]

		loadItems(with: request, predicate: predicate)
	}
	
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		if searchBar.text?.count == 0 {
			loadItems()
			
			//To hide keyboard after done with search
			DispatchQueue.main.async {
				searchBar.resignFirstResponder()
			}
		}
	}
}

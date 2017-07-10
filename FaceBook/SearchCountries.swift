//
//  SearchCountries.swift
//  FaceBook
//
//  Created by mohamed hassan on 7/10/17.
//  Copyright © 2017 mohamed hassan. All rights reserved.
//

import Foundation
import UIKit

class SearchCountries: UIViewController , UITableViewDelegate , UITableViewDataSource ,UISearchResultsUpdating, UISearchBarDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    var searchController : UISearchController!
    
    var filterdArray = [String]()
    var CountriesList : [String]!
    
    // search bar
    func filterdContentForSearchText(_ searchText : String , scope : String = "All") {
        
        filterdArray = CountriesList.filter{ list in
            return list.lowercased().contains(searchText.lowercased())
                        
        }
        
        tableView!.reloadData()
    }
    
    
    
    override func viewDidLoad() {
        // --
        self.CountriesList = ["Egypt","KSA","Kuwait","Germany","France","Spain"];
        configureSearchController()
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != ""{
            return self.filterdArray.count
        }
        return self.CountriesList!.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "ElementCell")
        
        
        
        if searchController.isActive && searchController.searchBar.text != ""{
            cell.textLabel?.text = self.filterdArray[(indexPath as NSIndexPath).row] as String!
            return cell
        }
        
        // asign the data to the labels
        cell.textLabel?.text = self.CountriesList[(indexPath as NSIndexPath).row] as String!
        cell.accessoryType = .disclosureIndicator                                 // -> the arrow in the cell
        
        return cell
        
    }
    
    // Search bar block
    
    func configureSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        searchController.searchBar.placeholder = "Search here..."
        searchController.searchBar.delegate = self
        tableView!.tableHeaderView = searchController.searchBar
        searchController.searchBar.sizeToFit()
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filterdContentForSearchText(searchController.searchBar.text!)
    }
    
    
    
}

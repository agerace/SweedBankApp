//
//  LocationsTableViewController.swift
//  SweedBankApp
//
//  Created by andresgerace on 20/8/18.
//  Copyright © 2018 andresgerace. All rights reserved.
//

import UIKit

class LocationsTableViewController: UITableViewController {
    
    var region: Region!
    
    var locationsDataSource = LocationsDataSource(locations: [Location]())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.loadLocations()
        
        self.title = self.region.name
    }
    
    private func setupTableView() {
        self.tableView.delegate = self
        self.tableView.estimatedRowHeight = 70
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    private func loadLocations() {
        self.locationsDataSource = LocationsDataSource(locations: self.region.locations)
        self.tableView.dataSource = self.locationsDataSource
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "LocationTableViewController") as! LocationTableViewController
        viewController.location = self.region.locations[indexPath.row]
        self.navigationController?.pushViewController(viewController, animated: true)
    }

}

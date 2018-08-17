//
//  LocationsViewController.swift
//  SweedBankApp
//
//  Created by andresgerace on 14/8/18.
//  Copyright © 2018 andresgerace. All rights reserved.
//

import UIKit

class LocationsViewController: UIViewController, UITableViewDelegate {
    @IBOutlet var locationsTableView: UITableView!
    
    var locations: [Location]!
    
    var locationsDataSource = LocationsDataSource(locations: [Location]())
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.loadLocations()
    }
    
    private func setupTableView() {
        self.locationsTableView.delegate = self
        self.locationsTableView.estimatedRowHeight = 70
        self.locationsTableView.rowHeight = UITableViewAutomaticDimension
    }
    
    private func loadLocations() {
        self.locationsDataSource = LocationsDataSource(locations: self.locations)
        self.locationsTableView.dataSource = self.locationsDataSource
        self.locationsTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "LocationTableViewController") as! LocationTableViewController
        viewController.location = self.locations[indexPath.row]
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

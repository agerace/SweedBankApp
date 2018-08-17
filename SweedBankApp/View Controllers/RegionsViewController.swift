//
//  RegionsViewController.swift
//  SweedBankApp
//
//  Created by andresgerace on 13/8/18.
//  Copyright © 2018 andresgerace. All rights reserved.
//

import UIKit

class RegionsViewController: UIViewController, UITableViewDelegate {
    @IBOutlet var regionsTableView: UITableView!
    
    var regionsDataSource = RegionsDataSource(regions: [Region]())
    
    var regions = [Region]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.loadRegions()
    }
    
    private func setupTableView() {
        self.regionsTableView.delegate = self
        self.regionsTableView.estimatedRowHeight = 70
        self.regionsTableView.rowHeight = UITableViewAutomaticDimension
    }
    
    private func loadRegions() {
        let manager = RestManager()
        let url = URL(string: "https://ib.swedbank.lt/finder.json")
        manager.get(url: url!) { (data, response) in
            do {

                let jsonObject = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
                
                guard let arrayFromJSON = jsonObject as? [[String:Any]] else {
                    return
                    // 
                }
                
                let locations = arrayFromJSON.map{Location(locationDictionary: $0)}
                    .sorted{ $0.name < $1.name }
                
                let sortedLocations = Dictionary(grouping: locations, by: { $0.region })
                self.regions = sortedLocations.map{ Region(name: $0.0, locations: $0.1) }
                    .sorted{ $0.name < $1.name }
                DispatchQueue.main.async {
                    self.showRegions(self.regions)
                }
            }catch let jsonError {
                print (jsonError)
            }
        }
    }
    
    private func showRegions(_ regions: [Region] ) {
        self.regionsDataSource = RegionsDataSource(regions: regions)
        self.regionsTableView.dataSource = self.regionsDataSource
        self.regionsTableView.reloadData()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "LocationsViewController") as! LocationsViewController
        viewController.locations = self.regions[indexPath.row].locations
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
}

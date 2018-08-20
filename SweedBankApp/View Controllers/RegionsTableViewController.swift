//
//  RegionsTableViewController.swift
//  SweedBankApp
//
//  Created by andresgerace on 20/8/18.
//  Copyright © 2018 andresgerace. All rights reserved.
//

import UIKit

class RegionsTableViewController: UITableViewController {
    
    var countriesDataSource = CountriesDataSource(countries: [Country]())
    
    var countries = [Country]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.loadCountries()
        self.setTimerToReloadCountries()
    }
    
    private func setTimerToReloadCountries() {
        Timer.scheduledTimer(timeInterval: 3600, target: self, selector: #selector(self.loadServerCountries), userInfo: nil, repeats: true)
    }
    
    private func setupTableView() {
        self.tableView.delegate = self
        self.tableView.estimatedRowHeight = 70
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    private func loadCountries() {
        self.loadLocalCountries()
        self.loadServerCountries()
    }
    
    private func loadLocalCountries() {
        Constants.Countries.sources.forEach {
            self.retrieveLocalRegionsForCountry(countryName: $0.name)
        }
    }
    
    @objc private func loadServerCountries () {
        
        Constants.Countries.sources.forEach { sourceCountry in
            RegionRepository().getRegions(for: sourceCountry) { result in
                switch result {
                case let .success(country):
                    self.countries = self.countries.filter{ $0.name != country.name }
                    self.countries.append(country)
                    self.countries = self.countries.sorted{$0.name < $1.name}
                    DispatchQueue.main.async {
                        self.showCountries(self.countries)
                    }
                case let .error(error):
                    print(error)
                }
            }
        }
    }
    
    private func retrieveLocalRegionsForCountry(countryName: String) {
        if let sortedLocations = try? LocalDataManager().read(file: countryName) {
            let groupedLocations = Dictionary(grouping: sortedLocations, by: { $0.region })
            
            let regions = groupedLocations.map{ Region(name: $0.0, locations: $0.1) }
                .sorted{ $0.name < $1.name }
            
            self.countries.append(Country(name: countryName, regions: regions))
            self.countries = self.countries.sorted{$0.name < $1.name}
            self.showCountries(self.countries)
        }
    }
    
    private func showCountries(_ countries: [Country] ) {
        self.countriesDataSource = CountriesDataSource(countries: countries)
        self.tableView.dataSource = self.countriesDataSource
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "LocationsTableViewController") as! LocationsTableViewController
        viewController.region = self.countries[indexPath.section].regions[indexPath.row]
        self.navigationController?.pushViewController(viewController, animated: true)
    }

    @IBAction func refreshLocations(_ sender: UIBarButtonItem) {
        self.loadServerCountries()
    }
}

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
        Constants.CountriesInfo.forEach {
            guard let countryName = $0["country"] else { return }
            self.retrieveLocalRegionsForCountry(countryName: countryName)
        }
    }
    
    @objc private func loadServerCountries () {
        
        let manager = RestManager(session: URLSession(configuration: .default))
        Constants.CountriesInfo.forEach {
            guard let countryName = $0["country"],
                let countryUrl = $0["url"] else { return }
            self.retrieveServerRegions(forCountry: countryName, url: countryUrl, restManager: manager)
        }
    }
    
    private func retrieveServerRegions(forCountry countryName: String, url countryUrl: String, restManager manager: RestManager) {
        
        guard let url = URL(string: countryUrl) else { return }
        
        manager.get(url: url, httpMethod: "GET") { (data, response, error) in
            guard let locations = JSONParser.locationsFromData(data) else {
                print ("Error parsing retrieved data for \(url.absoluteString)")
                return
            }
            let sortedLocations = locations.sorted{ $0.name < $1.name }
            LocalDataManager().write(sortedLocations, onFile: countryName)
            let groupedLocations = Dictionary(grouping: sortedLocations, by: { $0.region })
            
            let regions = groupedLocations.map{ Region(name: $0.0, locations: $0.1) }
                .sorted{ $0.name < $1.name }
            self.countries = self.countries.filter{ $0.name != countryName }
            self.countries.append(Country(name: countryName, regions: regions))
            self.countries = self.countries.sorted{$0.name < $1.name}
            DispatchQueue.main.async {
                self.showCountries(self.countries)
            }
        }
    }
    
    private func retrieveLocalRegionsForCountry(countryName: String) {
        if let sortedLocations = LocalDataManager().read(file: countryName) {
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

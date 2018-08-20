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
    
    var countriesDataSource = CountriesDataSource(countries: [Country]())
    
    var countries = [Country]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.loadCountries()
    }
    
    private func setupTableView() {
        self.regionsTableView.delegate = self
        self.regionsTableView.estimatedRowHeight = 70
        self.regionsTableView.rowHeight = UITableViewAutomaticDimension
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
    
    private func loadServerCountries () {
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
            self.showCountries(self.countries)
        }
    }
    
    private func showCountries(_ countries: [Country] ) {
        self.countriesDataSource = CountriesDataSource(countries: countries)
        self.regionsTableView.dataSource = self.countriesDataSource
        self.regionsTableView.reloadData()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "LocationsViewController") as! LocationsViewController
        viewController.locations = self.countries[indexPath.section].regions[indexPath.row].locations
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
}

//
//  RegionsDataSource.swift
//  SweedBankApp
//
//  Created by andresgerace on 13/8/18.
//  Copyright © 2018 andresgerace. All rights reserved.
//

import UIKit

class CountriesDataSource: NSObject, UITableViewDataSource {
    
    let countries: [Country]
    
    init(countries: [Country]) {
        self.countries = countries
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.countries[section].regions.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.RegionCellIdentifier) as! RegionTableViewCell
        cell.regionName = self.countries[indexPath.section].regions[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.countries[section].name
    }
    
}

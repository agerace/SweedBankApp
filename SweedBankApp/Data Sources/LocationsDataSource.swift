//
//  LocationsDataSource.swift
//  SweedBankApp
//
//  Created by andresgerace on 14/8/18.
//  Copyright © 2018 andresgerace. All rights reserved.
//

import UIKit

class LocationsDataSource: NSObject, UITableViewDataSource {
    
    let locations: [Location]
    
    init(locations: [Location]) {
        self.locations = locations
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.locations.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.LocationCellIdentifier) as! LocationTableViewCell
        cell.location = self.locations[indexPath.row]
//        cell.locationName = self.locations[indexPath.row]
        return cell
    }
    
}

//
//  RegionsDataSource.swift
//  SweedBankApp
//
//  Created by andresgerace on 13/8/18.
//  Copyright © 2018 andresgerace. All rights reserved.
//

import UIKit

class RegionsDataSource: NSObject, UITableViewDataSource {
    
    let regions: [Region]
    
    init(regions: [Region]) {
        self.regions = regions
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.regions.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.RegionCellIdentifier) as! RegionTableViewCell
        cell.regionName = self.regions[indexPath.row].name
        return cell
    }
    
}

//
//  LocationTableViewController.swift
//  SweedBankApp
//
//  Created by andresgerace on 14/8/18.
//  Copyright © 2018 andresgerace. All rights reserved.
//

import UIKit

class LocationTableViewController: UITableViewController {
    var location: Location!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.location.name 
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 { return 4 }
        var rowsForLocation = 0
        
        if self.location.availability != nil { rowsForLocation += 1 }
        if self.location.info != nil || self.location.hasNoCash != nil || self.location.hasCoinStation != nil { rowsForLocation += 1 }
        
        return rowsForLocation
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.LocationInfoCellIdentifier) as! LocationInfoTableViewCell
        
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0:
                self.setInfo("TYPE", andValue: self.location.type.rawValue, forCell: cell)
            case 1:
                self.setInfo("NAME", andValue: self.location.name, forCell: cell)
            case 2:
                self.setInfo("ADDRESS", andValue: self.location.address, forCell: cell)
            default:
                self.setInfo("REGION", andValue: self.location.region, forCell: cell)
            }
        }else {
            switch indexPath.row {
            case 0:
                if let availability = self.location.availability {
                    self.setInfo("AVAILABILITY", andValue: availability, forCell: cell)
                }else  {
                    self.setInfo("INFO", andValue: self.infoString(forLocation: self.location), forCell: cell)
                }
            default:
                self.setInfo("INFO", andValue: self.infoString(forLocation: self.location), forCell: cell)
            }
        }
        
        return cell
    }

    //Private methods
    
    private func infoString(forLocation location: Location) -> String {
        var infoFieldString = ""
        if let info = location.info {
            infoFieldString += info
        }
        if let hasCoinStation = location.hasCoinStation {
            infoFieldString += hasCoinStation.1
        }
        if let hasNoCash = location.hasNoCash {
            infoFieldString += hasNoCash.1
        }
        return infoFieldString
    }
    
    private func setInfo(_ key: String, andValue value: String, forCell cell:LocationInfoTableViewCell) {
        cell.locationInfoKeyLabel.text = key
        cell.locationInfoValueLabel.text = value
    }

}

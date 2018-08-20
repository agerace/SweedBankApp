//
//  LocationTableViewController.swift
//  SweedBankApp
//
//  Created by andresgerace on 14/8/18.
//  Copyright © 2018 andresgerace. All rights reserved.
//

import UIKit

class LocationTableViewController: UITableViewController {
    
    enum TableSections: Int {
        case general
        case branch
    }
    
    enum GeneralSectionRows: Int {
        case type
        case name
        case address
        case region
    }
    
    enum BranchSectionRows: Int {
        case availability
        case info
    }
    
    var location: Location!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.location.name 
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let tableSection = TableSections.init(rawValue: section) else { return 0 }
        
        switch tableSection {
        case .general:
            return 4
        case .branch :
            var rowsForLocation = 0
            if self.location.availability != nil { rowsForLocation += 1 }
            if self.location.info != nil || self.location.hasNoCash != nil || self.location.hasCoinStation != nil { rowsForLocation += 1 }
            return rowsForLocation
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.LocationInfoCellIdentifier) as! LocationInfoTableViewCell
        guard let tableSection = TableSections.init(rawValue: indexPath.section) else { return cell }
        

        switch tableSection {
        case .general:
            guard let sectionRow = GeneralSectionRows.init(rawValue: indexPath.row) else { return cell }
            switch sectionRow {
            case .type:
                self.setInfo("TYPE", andValue: self.location.type.rawValue, forCell: cell)
            case .name:
                self.setInfo("NAME", andValue: self.location.name, forCell: cell)
            case .address:
                self.setInfo("ADDRESS", andValue: self.location.address, forCell: cell)
            case .region:
                self.setInfo("REGION", andValue: self.location.region, forCell: cell)
            }
            
        case .branch:
            guard let sectionRow = BranchSectionRows.init(rawValue: indexPath.row) else { return cell }
            switch sectionRow {
            case .availability:
                if let availability = self.location.availability {
                    self.setInfo("AVAILABILITY", andValue: availability, forCell: cell)
                }else  {
                    self.setInfo("INFO", andValue: self.infoString(forLocation: self.location), forCell: cell)
                }
            case .info:
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

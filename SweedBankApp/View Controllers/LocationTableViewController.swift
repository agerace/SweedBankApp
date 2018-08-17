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
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

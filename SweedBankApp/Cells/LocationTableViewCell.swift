//
//  LocationTableViewCell.swift
//  SweedBankApp
//
//  Created by andresgerace on 14/8/18.
//  Copyright © 2018 andresgerace. All rights reserved.
//

import UIKit

class LocationTableViewCell: UITableViewCell {

    @IBOutlet weak var locationNameLabel: UILabel!
    @IBOutlet weak var locationAddressLabel: UILabel!
    @IBOutlet weak var locationTypeLabel: UILabel!
    @IBOutlet weak var locationTypeColorView: UIView!
    
    var location: Location! {
        didSet {
            locationNameLabel.text = location.name
            locationAddressLabel.text = location.address
            switch location.type {
            case .location:
                locationTypeLabel.text = "BR"
                locationTypeColorView.backgroundColor = UIColor(red: 14.0/255.0, green: 177.0/255.0, blue: 247.0/255.0, alpha: 1.0)
            case .bna:
                locationTypeLabel.text = "A"
                locationTypeColorView.backgroundColor = UIColor(red: 113.0/255.0, green: 213.0/255.0, blue: 90.0/255.0, alpha: 1.0)
            case .atm:
                locationTypeLabel.text = "R"
                locationTypeColorView.backgroundColor = UIColor(red: 248.0/255.0, green: 189.0/255.0, blue: 59.0/255.0, alpha: 1.0)
            }
        }
    }
    
}

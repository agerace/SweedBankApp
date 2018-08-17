//
//  RegionTableViewCell.swift
//  SweedBankApp
//
//  Created by andresgerace on 13/8/18.
//  Copyright © 2018 andresgerace. All rights reserved.
//

import UIKit

class RegionTableViewCell: UITableViewCell {

    @IBOutlet weak var regionNameLabel: UILabel!

    var regionName: String! {
        didSet {
            regionNameLabel.text = regionName
        }
    }

}

//
//  Country.swift
//  SweedBankApp
//
//  Created by andresgerace on 19/8/18.
//  Copyright © 2018 andresgerace. All rights reserved.
//

import Foundation

class Country {
    let name: String
    let regions: [Region]
    
    init(name: String, regions: [Region]){
        self.name = name
        self.regions = regions
    }
}

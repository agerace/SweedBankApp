//
//  Region.swift
//  SweedBankApp
//
//  Created by andresgerace on 15/8/18.
//  Copyright © 2018 andresgerace. All rights reserved.
//

import Foundation

class Region {
    let name: String
    let locations: [Location]
    
    init(name: String, locations: [Location]){
        self.name = name
        self.locations = locations
    }
}

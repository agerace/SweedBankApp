//
//  Location.swift
//  SweedBankApp
//
//  Created by andresgerace on 14/8/18.
//  Copyright © 2018 andresgerace. All rights reserved.
//

import Foundation

class Location {
    
    enum LocationType: String {
        case location = "Location"
        case atm = "ATM (Automated Teller Machine)"
        case bna = "BNA (Bunch Note Aceptor)"
    }
    
    let region: String
    let name: String
    let address: String
    let type: LocationType
    var availability: String? = nil
    var info: String? = nil
    var hasNoCash: (Bool, String)? = nil
    var hasCoinStation: (Bool, String)? = nil
    
    init? (locationDictionary:[String:Any]){
        
        guard let region = locationDictionary["r"] as? String else { return nil }
        self.region = region
        
        
        guard let name = locationDictionary["n"] as? String else { return nil }
        self.name = name
        
        guard let address = locationDictionary["a"] as? String else { return nil }
        self.address = address
        
        guard let locationType = locationDictionary["t"] as? Int else { return nil }
        
        switch locationType {
        case 0:
            self.type = .location
        case 1:
            self.type = .atm
        default:
            self.type = .bna
        }
        
        if let availability =  locationDictionary["av"] as? String {
            self.availability = availability
        }
        if let info =  locationDictionary["i"] as? String {
            self.info = info
        }
        if let hasNoCash =  locationDictionary["ncash"] as? Bool {
            self.hasNoCash = hasNoCash ? (hasNoCash,"No cash location.") : (hasNoCash, "Cash location.")
        }
        if let hasCoinStation =  locationDictionary["cs"] as? Bool {
            self.hasCoinStation = hasCoinStation ? (hasCoinStation, "Has coin station.") : (hasCoinStation, "Doesn't have coin) station.")
        }
    }
    
    func dictionaryRepresentation() -> [String:Any] {
        var locationDictionary = [String:Any]()
        locationDictionary["r"] = self.region
        locationDictionary["n"] = self.name
        locationDictionary["a"] = self.address
        locationDictionary["t"] = self.type.hashValue
        
        if let availability = self.availability {
            locationDictionary["av"] = availability
        }
        
        if let info = self.info {
            locationDictionary["i"] = info
        }
        
        if let hasNoCash = self.hasNoCash?.0 {
            locationDictionary["ncash"] = hasNoCash
        }
        
        if let hasCoinStation = self.hasCoinStation?.0 {
            locationDictionary["cs"] = hasCoinStation
        }
        
        return locationDictionary
    }
}

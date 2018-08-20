//
//  Constants.swift
//  SweedBankApp
//
//  Created by andresgerace on 13/8/18.
//  Copyright © 2018 andresgerace. All rights reserved.
//

import Foundation
enum Constants {
    
    enum Cookies {
        static let CookieName = "Swedbank-Embedded"
        static let CookieValue = "iphone-app"
    }
    
    enum CellIdentifiers {
        static let RegionCellIdentifier = "RegionTableViewCellIdentifier"
        static let LocationCellIdentifier = "LocationTableViewCellIdentifier"
        static let LocationInfoCellIdentifier = "LocationInfoTableViewCellIdentiffier"
    }
    
    enum Countries {
        static let sources = [ CountrySource(name: "Estonia", url:"https://www.swedbank.ee/finder.json"),
                                 CountrySource(name: "Latvia", url:"https://www.swedbank.lv/finder.json"),
                                 CountrySource(name: "Lithuania", url:"https://ib.swedbank.lt/finder.json")]
    }
    
}

struct CountrySource {
    let name: String
    let url: String
}

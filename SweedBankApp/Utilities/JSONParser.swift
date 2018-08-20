//
//  JSONParser.swift
//  SweedBankApp
//
//  Created by andresgerace on 17/8/18.
//  Copyright © 2018 andresgerace. All rights reserved.
//

import Foundation

class JSONParser {
    
    static func locationsFromData(_ data: Data?) -> [Location]? {
        guard let unwrapedData = data else { return nil }
        
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: unwrapedData, options: JSONSerialization.ReadingOptions.allowFragments)
            guard let locationsDictionaries = jsonObject as? [[String:Any]] else {
                return nil
            }
            let locations = locationsDictionaries.compactMap{Location(locationDictionary: $0)}
            
            return locations
        }catch { return nil }
    }
    
    static func regionsFromData(_ data: Data?) -> [Region]? {
        guard let unwrapedData = data else { return nil }
        
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: unwrapedData, options: JSONSerialization.ReadingOptions.allowFragments)
            guard let regionsDictionary = jsonObject as? [String:[Location]] else {
                return nil
            }
            let regions = regionsDictionary.compactMap{Region(name: $0.key, locations: $0.value)}
            
            return regions
        }catch { return nil }
    }
}

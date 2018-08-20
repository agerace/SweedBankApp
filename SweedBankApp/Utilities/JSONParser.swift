//
//  JSONParser.swift
//  SweedBankApp
//
//  Created by andresgerace on 17/8/18.
//  Copyright © 2018 andresgerace. All rights reserved.
//

import Foundation

class JSONParser {
    
    static let defaultParser = JSONParser()
    
    enum ParsingError: Error {
        case invalidData
        case invalidJSONField
    }
    
    func locationsFromData(_ data: Data?) throws -> [Location] {
        guard let unwrapedData = data else { throw ParsingError.invalidData }
        
        let jsonObject = try JSONSerialization.jsonObject(with: unwrapedData, options: JSONSerialization.ReadingOptions.allowFragments)
        guard let locationsDictionaries = jsonObject as? [[String:Any]] else {
            throw ParsingError.invalidJSONField
        }
        let locations = locationsDictionaries.compactMap{Location(locationDictionary: $0)}
        
        return locations
    }
    
    func regionsFromData(_ data: Data?) throws -> [Region] {
        guard let unwrapedData = data else { throw ParsingError.invalidData }
        
        let jsonObject = try JSONSerialization.jsonObject(with: unwrapedData, options: JSONSerialization.ReadingOptions.allowFragments)
        guard let regionsDictionary = jsonObject as? [String:[Location]] else {
            throw ParsingError.invalidJSONField
        }
        let regions = regionsDictionary.compactMap{Region(name: $0.key, locations: $0.value)}
        
        return regions
    }
}

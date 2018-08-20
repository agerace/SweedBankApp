//
//  CountryRepository.swift
//  SweedBankApp
//
//  Created by andresgerace on 20/8/18.
//  Copyright © 2018 andresgerace. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case error(String)
}

class RegionRepository {
    
    func getRegions(for countrySource: CountrySource, result: @escaping (Result<Country>) -> Void ) {
        
        guard let url = URL(string: countrySource.url) else {
            result(.error("Wrong Url"))
            return
        }
        
        RestManager.manager.request(url: url, httpMethod: "GET") { (data, response, error) in
            guard let locations = try? JSONParser.defaultParser.locationsFromData(data) else {
                result(.error("Error parsing retrieved data"))
                return
            }
            let sortedLocations = locations.sorted{ $0.name < $1.name }
            try? LocalDataManager().write(sortedLocations, onFile: countrySource.name)
            let groupedLocations = Dictionary(grouping: sortedLocations, by: { $0.region })
            
            let regions = groupedLocations.map{ Region(name: $0.0, locations: $0.1) }
                .sorted{ $0.name < $1.name }
            
            result(.success(Country(name: countrySource.name, regions: regions)))
        
        }
    }
}

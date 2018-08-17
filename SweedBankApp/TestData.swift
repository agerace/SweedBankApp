//
//  TestData.swift
//  SweedBankApp
//
//  Created by andresgerace on 15/8/18.
//  Copyright © 2018 andresgerace. All rights reserved.
//

import Foundation

struct TestData {
    
    static func region1() -> [Location] {
        return [
            Location(locationDictionary:["t": 1,
                                         "n": "Circle K Mustvee",
                                         "a": "Uus-Narva mnt 5, JÕGEVAMAA, MUSTVEE",
                                         "av": "24h",
                                         "r": "Jõgeva maakond",
                                         "lat": 58.85076667,
                                         "lon": 26.91277778]),
            Location(locationDictionary:["t": 1,
                                         "n": "Jõgeva Selver",
                                         "a": "Kesk 4, JÕGEVAMAA, JÕGEVA LINN",
                                         "av": "24h",
                                         "r": "Jõgeva maakond",
                                         "lat": 58.74859722,
                                         "lon": 26.39799444] ),
            Location(locationDictionary: ["t": 2,
                                          "n": "Mustvee Konsum",
                                          "a": "Tartu mnt 3, JÕGEVAMAA, MUSTVEE",
                                          "r": "Jõgeva maakond",
                                          "lat": 58.84783333,
                                          "lon": 26.94495278]),
            Location(locationDictionary: ["t": 1,
                                          "n": "Põltsamaa Maxima",
                                          "a": "Kesk 6, JÕGEVAMAA, PÕLTSAMAA LINN",
                                          "av": "24h",
                                          "r": "Jõgeva maakond",
                                          "lat": 58.65404444,
                                          "lon": 25.97934167]),
        ]
    }
    static func region2() -> [Location] {
        return [
            Location(locationDictionary: ["t": 1,
                                          "n": "Hilton",
                                          "a": "Kreutzwaldi 23, HARJUMAA, TALLINN",
                                          "av": "24h",
                                          "r": "Kesklinna linnaosa",
                                          "lat": 59.433738,
                                          "lon": 24.768588]),
            Location(locationDictionary: [ "t": 2,
                                           "n": "Liivalaia kontor",
                                           "a": "Liivalaia 8, HARJUMAA, TALLINN",
                                           "av": "24h",
                                           "r": "Kesklinna linnaosa",
                                           "lat": 59.42736111,
                                           "lon": 24.74562778]),
            Location(locationDictionary: ["t": 1,
                                          "n": "Musumägi",
                                          "a": "Valli 1, HARJUMAA, TALLINN",
                                          "av": "24h",
                                          "r": "Kesklinna linnaosa",
                                          "lat": 59.43625556,
                                          "lon": 24.75004167]),
            Location(locationDictionary: ["t": 1,
                                          "n": "Reisisadama D-terminal",
                                          "a": "Lootsi 13, HARJUMAA, TALLINN",
                                          "r": "Kesklinna linnaosa",
                                          "lat": 59.44335833,
                                          "lon": 24.76714444]),
            Location(locationDictionary: [ "t": 0,
                                           "n": "LIIVALAIA",
                                           "a": "LIIVALAIA 8, 15040 TALLINN",
                                           "av": "E-R 9.00-17.00",
                                           "r": "Kesklinna linnaosa",
                                           "cs": true,
                                           "lat": 59.42736111,
                                           "lon": 24.74562778])
        ]
    }
    
    static func region3() -> [Location] {
        return [
            Location(locationDictionary: ["t": 0,
                                          "n": "KÄRDLA",
                                          "a": "KESKVÄLJAK 5A, 92414 KÄRDLA",
                                          "av": "E-R 9.00-14.00",
                                          "r": "Hiiu maakond",
                                          "cs": true,
                                          "lat": 58.99758056,
                                          "lon": 22.74735833]),
            Location(locationDictionary: [ "t": 1,
                                           "n": "Emmaste Bussijaam",
                                           "a": "Emmaste vald, HIIUMAA, KÄRDLA",
                                           "av": "24h",
                                           "r": "Hiiu maakond",
                                           "lat": 58.70522778,
                                           "lon": 22.59687778]),
            Location(locationDictionary: ["t": 2,
                                          "n": "Kärdla kontor",
                                          "a": "Keskväljak 5a, HIIUMAA, KÄRDLA",
                                          "av": "24h",
                                          "r": "Hiiu maakond",
                                          "lat": 58.99758056,
                                          "lon": 22.74735833])
        ]
    }
    
    
    func locations(ofType type: Location.LocationType) -> [Location] {
        var locations = [Location]()
        locations += TestData.region1().filter { $0.type == type }
        locations += TestData.region2().filter { $0.type == type }
        locations += TestData.region3().filter { $0.type == type }
        return locations
    }
    
    func allLocations() -> [Location] {
        var locations = [Location]()
        locations += TestData.region1()
        locations += TestData.region2()
        locations += TestData.region3()
        return locations
    }
    
    func allLocationsAsDictionaries() -> [[String:Any]] {
        return self.allLocations().map{$0.dictionaryRepresentation()}
    }
    
    func test1 () {
//        let locationDictionary = self.allLocationsAsDictionaries().first!
//        let data1 = Data(
//        let locations = try JSONDecoder().decode([Location].self, from: data!)
//            .sorted{ $0.name < $1.name }
        
    }
}

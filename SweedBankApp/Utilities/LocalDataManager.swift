//
//  LocalDataManager.swift
//  SweedBankApp
//
//  Created by andresgerace on 18/8/18.
//  Copyright © 2018 andresgerace. All rights reserved.
//

import Foundation

class LocalDataManager {
    
    func write(_ countryLocations: [Location], onFile fileName: String) {

        guard let documentDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileUrl = documentDirectoryUrl.appendingPathComponent("\(fileName).json")
        
        do {
            let data = try JSONSerialization.data(withJSONObject: countryLocations.compactMap{$0.dictionaryRepresentation()}, options: [])
            try data.write(to: fileUrl, options: [])
        } catch { return }
        
    }
    
    func read(file fileName:String) -> [Location]? {
        guard let documentsDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let fileUrl = documentsDirectoryUrl.appendingPathComponent("\(fileName).json")
        
        do {
            let data = try Data(contentsOf: fileUrl, options: [])
            return JSONParser.locationsFromData(data)
        } catch { return nil }
    }
    
}

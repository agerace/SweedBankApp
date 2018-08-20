//
//  LocalDataManager.swift
//  SweedBankApp
//
//  Created by andresgerace on 18/8/18.
//  Copyright © 2018 andresgerace. All rights reserved.
//

import Foundation

class LocalDataManager {
    
    enum LocalError: Error {
        case readError
        case writeError
    }
    
    func write(_ countryLocations: [Location], onFile fileName: String) throws {

        guard let documentDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { throw LocalError.writeError }
        let fileUrl = documentDirectoryUrl.appendingPathComponent("\(fileName).json")
        
            let data = try JSONSerialization.data(withJSONObject: countryLocations.compactMap{$0.dictionaryRepresentation()}, options: [])
            try data.write(to: fileUrl, options: [])
        
    }
    
    func read(file fileName:String) throws -> [Location] {
        guard let documentsDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { throw LocalError.readError  }
        let fileUrl = documentsDirectoryUrl.appendingPathComponent("\(fileName).json")
        
            let data = try Data(contentsOf: fileUrl, options: [])
            return try JSONParser.defaultParser.locationsFromData(data)
    }
    
}

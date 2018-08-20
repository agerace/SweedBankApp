//
//  JSONParserTests.swift
//  SweedBankAppTests
//
//  Created by andresgerace on 17/8/18.
//  Copyright © 2018 andresgerace. All rights reserved.
//


import XCTest
@testable import SweedBankApp

class JSONParserTests: XCTestCase {

    var sut: JSONParser!
    
    override func setUp() {
        self.sut = JSONParser.default
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSuccessJSONParsing() {
        let testDictionary: [String:Any]  = ["t": 0,
                           "n": "test location",
                           "a": "test address 123",
                           "av": "12-24",
                           "r": "test region",
                           "lat": 58.85076667,
                           "lon": 26.91277778]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: [testDictionary], options: JSONSerialization.WritingOptions.prettyPrinted)
            
            let locations = sut.locationsFromData(jsonData)
            
            guard let testLocation = locations?.first else {
                XCTFail()
                return
            }
            
            XCTAssert(testLocation.address == "test address 123")
            XCTAssert(testLocation.name == "test location")
            XCTAssert(testLocation.type == .location)
            XCTAssert(testLocation.region == "test region")
            
        }catch { XCTFail() }
    }
    
    func testSuccessJSONParsingWithAllFields() {
        let testDictionary: [String:Any]  = ["t": 0,
                                             "n": "test location",
                                             "a": "test address 123",
                                             "av": "12-24",
                                             "r": "test region",
                                             "i": "test info",
                                             "ncash" : 1,
                                             "cs" : 1,
                                             "lat": 58.85076667,
                                             "lon": 26.91277778]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: [testDictionary], options: JSONSerialization.WritingOptions.prettyPrinted)
            
            let locations = sut.locationsFromData(jsonData)
            
            guard let testLocation = locations?.first else {
                XCTFail()
                return
            }
            
            XCTAssert(testLocation.address == "test address 123")
            XCTAssert(testLocation.name == "test location")
            XCTAssert(testLocation.type == .location)
            XCTAssert(testLocation.type.rawValue == "Location")
            XCTAssert(testLocation.region == "test region")
            XCTAssert(testLocation.info == "test info")
            XCTAssertNotNil(testLocation.hasNoCash)
            XCTAssert(testLocation.hasNoCash!.0 == true )
            XCTAssert(testLocation.hasNoCash!.1 == "No cash location." )
            XCTAssert(testLocation.hasCoinStation!.0 == true )
            XCTAssert(testLocation.hasCoinStation!.1 == "Has coin station." )
            
        }catch { XCTFail() }
    }
    
    func testFailJSONParsingWithMissingRegion() {
        let testDictionary: [String:Any] = ["t": 0,
                           "n": "test location",
                           "a": "test address 123",
                           "av": "12-24",
                           "lat": 58.85076667,
                           "lon": 26.91277778]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: [testDictionary], options: JSONSerialization.WritingOptions.prettyPrinted)
            
            guard let locations = JSONParser.locationsFromData(jsonData) else {
                XCTFail()
                return
            }
            
            XCTAssert(locations.count == 0)
            
        }catch { XCTFail() }
    }
    
    func testFailJSONParsingWithNilData() {
        let locations = JSONParser.locationsFromData(nil)
        
        XCTAssertNil(locations)
    }
    
}


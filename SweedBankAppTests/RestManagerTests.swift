//
//  RestManagerTests.swift
//  SweedBankAppTests
//
//  Created by andresgerace on 18/8/18.
//  Copyright © 2018 andresgerace. All rights reserved.
//


import XCTest
@testable import SweedBankApp

class RestManagerTests: XCTestCase {
    
    var sut: RestManager!
    
    
    override func setUp() {
        super.setUp()
        self.sut = RestManager(session: URLSession(configuration:.default))
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSuccessCookiesSet() {
        let expect = expectation(description: "Set Cookies to the URL should succeed")
        
        let url = URL(string: "https://www.swedbank.ee/finder.json")!
        
        sut.get(url: url, httpMethod: "GET", callback: {(data, response, error) in
            if let cookie = HTTPCookieStorage.shared.cookies(for: url)?.first {
                XCTAssert(cookie.name == Constants.CookieName)
                XCTAssert(cookie.value == Constants.CookieValue)
            }
            expect.fulfill()
        })
        waitForExpectations(timeout: 10, handler: { error in
            XCTAssertNil(error)
        })
    }
    
    func testSuccessGetEstoniaJSONData() {
        
        let expect = expectation(description: "Jsons download should succeed")
        
        let url = URL(string: "https://www.swedbank.ee/finder.json")!
        
        sut.get(url: url, httpMethod: "GET", callback: {(data, response, error) in
            XCTAssertNil(error)
            XCTAssertNotNil(data)
            expect.fulfill()
        })
        waitForExpectations(timeout: 10, handler: { error in
            XCTAssertNil(error)
        })

    }
    
    func testSuccessGetLatviaJSON() {
        
        let expect = expectation(description: "Jsons download should succeed")
    
        let url = URL(string: "https://ib.swedbank.lv/finder.json")!
        
        sut.get(url: url, httpMethod: "GET", callback: {(data, response, error) in
            XCTAssertNil(error)
            XCTAssertNotNil(data)
            expect.fulfill()
        })
        
        waitForExpectations(timeout: 10, handler: { error in
            XCTAssertNil(error)
        })
        
    }
    
    func testSuccessGetLithuaniaJSON() {
        
        let expect = expectation(description: "Jsons download should succeed")
        
        let url = URL(string: "https://ib.swedbank.lt/finder.json")!
        
        sut.get(url: url, httpMethod: "GET", callback: {(data, response, error) in
            XCTAssertNil(error)
            XCTAssertNotNil(data)
            expect.fulfill()
        })
        
        waitForExpectations(timeout: 10, handler: { error in
            XCTAssertNil(error)
        })
    
    }
    
}

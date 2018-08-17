//
//  RestManager.swift
//  SweedBankApp
//
//  Created by andresgerace on 17/8/18.
//  Copyright © 2018 andresgerace. All rights reserved.
//

import Foundation

class RestManager {
    
    typealias completeClosure = ( _ data: Data?, _ error: Error?)->Void
    func get( url: URL, callback: @escaping completeClosure ) {
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "GET"
        let session = URLSession(configuration: .default)
        
        let jar = HTTPCookieStorage.shared
        let cookieHeaderField = ["Set-Cookie": "Swedbank-Embedded=iphone-app"]
        let cookies = HTTPCookie.cookies(withResponseHeaderFields: cookieHeaderField, for: url)
        jar.setCookies(cookies, for: url, mainDocumentURL: url)
        
        let task = session.dataTask(with: url, completionHandler: {(data, response, error) in
            callback(data, error)
        })
    
        task.resume()
    }
    
}

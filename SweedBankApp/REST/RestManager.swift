//
//  RestManager.swift
//  SweedBankApp
//
//  Created by andresgerace on 17/8/18.
//  Copyright © 2018 andresgerace. All rights reserved.
//

import Foundation

class RestManager {
    
    typealias completeClosure = ( _ data: Data?, _ urlResponse: URLResponse?,  _ error: Error?)->Void
    private let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    func get(url: URL, httpMethod: String, callback: @escaping completeClosure ) {
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.cachePolicy = .reloadIgnoringCacheData
        
        self.addCookies(cookiesDictionary: ["Set-Cookie": "\(Constants.CookieName)=\(Constants.CookieValue)"], toUrl: url)
        
        let task = self.session.dataTask(with: request, completionHandler: {(data, response, error) in
            callback(data, response, error)
            //In case the Latvia call fails because of redirection, summon The Great Gaita to make everything work again.
        })
    
        task.resume()
    }
    
    private func addCookies(cookiesDictionary: [String:String], toUrl url: URL) {
        let jar = HTTPCookieStorage.shared
        let cookieHeaderField = cookiesDictionary
        let cookies = HTTPCookie.cookies(withResponseHeaderFields: cookieHeaderField, for: url)
        jar.setCookies(cookies, for: url, mainDocumentURL: url)
    }
    
}

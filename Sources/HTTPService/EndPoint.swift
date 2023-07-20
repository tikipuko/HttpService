//
//  File.swift
//  
//
//  Created by Correia, Jose Bastos on 12/07/2023.
//

import Foundation

open class EndPoint {
    
    private var host: String
    private var path: String
    private var queryItems: [URLQueryItem] = []
    
    private var httpMethod: String? = nil
    private var httpKey: String? = nil
    private var httpHeader: String? = nil

    
    public init(host: String,
                path: String) {
        self.host = host
        self.path = path
    }
    
//    public init(host: String,
//                path: String,
//                httpMethod: String? = nil,
//                httpKey: String? = nil,
//                httpHeader: String? = nil) {
//        self.host = host
//        self.path = path
//        guard let httpMethod else { return }
//        self.httpMethod = httpMethod
//        guard let httpKey else { return }
//        self.httpKey = httpKey
//        guard let httpHeader else { return }
//        self.httpHeader = httpHeader
//    }
    
    public var httpRequest: URLRequest {
        var urlRequest = URLRequest(url: self.url)
        
        guard let newHttpMethod = self.httpMethod else { return urlRequest}
        urlRequest.httpMethod = newHttpMethod
        
        guard let newHttpKey = self.httpKey,
              let newHttpHeader = self.httpHeader else { return urlRequest }
        urlRequest.setValue(newHttpKey, forHTTPHeaderField: newHttpHeader)
        return urlRequest
    }
    
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = self.host
        components.path = "/\(self.path)"
        components.queryItems = self.queryItems
        
        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }
        return url
    }
    
    public func urlSetQueryString(_ newItems: [URLQueryItem]?) -> Self {
        guard let newItems = newItems else {
            return self
        }
        self.queryItems = newItems
        return self
    }
}

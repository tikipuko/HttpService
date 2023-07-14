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
    
    var httpMethod: String  = "GET"
    var queryItems: [URLQueryItem] = []
    var httpKey: String  { get { "" }}
    var httpHeader: String { get { "" }}
    
    public init(host: String,
                path: String) {
        self.host = host
        self.path = path
    }
    
    public var httpRequest: URLRequest {
        var urlRequest = URLRequest(url: self.url)
        urlRequest.httpMethod = self.httpMethod
        urlRequest.setValue(self.httpKey, forHTTPHeaderField: self.httpHeader)
        return urlRequest
    }
    
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = self.host
        components.path = "/\(path)"
        components.queryItems = queryItems
        
        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }
        
        return url
    }
    
    public func urlSetQueryString(_ newItems: [URLQueryItem]) -> Self {
        queryItems = newItems
        return self
    }
}

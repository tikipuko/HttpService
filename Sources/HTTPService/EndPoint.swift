//
//  File.swift
//  
//
//  Created by Correia, Jose Bastos on 12/07/2023.
//

import Foundation

open class EndPoint {
    
    private var host: String
    private var environment: String
    private var path: String
    
    var httpMethod: String  = "GET"
    var queryItems: [URLQueryItem] = []
    var httpKey: String  { get { "" }}
    var httpHeader: String { get { "" }}
    
    init(host: String,
         path: String,
         environment: String) {
        self.host = host
        self.path = path
        self.environment = environment
    }
    
    var httpRequest: URLRequest {
        var urlRequest = URLRequest(url: self.url)
        urlRequest.httpMethod = self.httpMethod
        urlRequest.setValue(self.httpKey, forHTTPHeaderField: self.httpHeader)
        return urlRequest
    }
    
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = self.host
        components.path = "/\(environment)/\(path)"
        components.queryItems = queryItems
        
        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }
        
        return url
    }
    
    func urlSetQueryString(_ newItems: [URLQueryItem]) -> Self {
        queryItems = newItems
        return self
    }
}

open class AmazonEndpoint: EndPoint {
    
    public init(path: String) {
        super.init(host: "cf5dxst1y4.execute-api.eu-west-1.amazonaws.com",
                   path: path,
                   environment: "develop")
    }
    
    override var httpKey: String {
        return "I2tgdBezVY5rakqSWB3eo1Q8V8Sk0myg7rkYQFBV"
    }
    
    override var httpHeader: String {
        return "x-api-key"
    }
}

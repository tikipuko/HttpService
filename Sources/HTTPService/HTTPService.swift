//
//  File.swift
//
//
//  Created by Correia, Jose Bastos on 30/06/2023.
//

import Foundation
import Combine

/// Core class HTTPService
final public class HTTPService {
        
    /// initializer
    public init() {}
    
}

/// Extension to build URL's
extension HTTPService {
    
    /// Method to build your URL from an absolute string
    /// - Parameter url: Absolute URL:  String
    /// - Returns: URL that enables you to build your URLRequest
    public func urlBuilder(url: String) -> URL {
        let url = URL(string: url)
        return url!
    }
    
    /// Method to build your custom URL
    /// - Parameters:
    ///   - scheme: "https"
    ///   - host: "amazonAPI.com
    ///   - path: "/user/1", if needed
    ///   - queryItems: "Key : Value pairs that you want to search, if needed
    /// - Returns: URL that enables you to build your URLRequest
    public func urlBuilder(scheme: String, host: String, path: String = "", queryItems: [URLQueryItem] = []) -> URL {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        components.queryItems = queryItems
        
        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }
        return url
    }
}

/// Extension to build URLRequest's
extension HTTPService {
    
    /// Method to build your custom request with the parameters that you need.
    /// - Parameters:
    ///   - url: URL from where you pretend to make your request.
    ///   - method: request method like "GET", "POST, "PUT"..,  if needed.
    ///   - key: API secret key, if needed.
    ///   - header: API request message, if needed.
    /// - Returns: URLRequest to enable you request.
    public func requestBuilder(url: URL, method: String? = nil, key: String? = nil, header: String? = nil) -> URLRequest {
        var urlRequest = URLRequest(url: url)
        
        guard let method = method else {
            return urlRequest
        }
        
        guard let key = key, let header = header else {
            urlRequest.httpMethod = method
            return urlRequest
        }
        
        urlRequest.setValue(key, forHTTPHeaderField: header)
        
        return urlRequest
    }
}

/// Extension to process HTTPService
extension HTTPService {
    
    /// Method that handle any HTTP Request
    /// - Parameter urlRequest: urlRequest setted that enable you to make your request
    /// - Returns: Return a Publisher that could be of type Data or Error if there is any connection problem, that Data still needs to be transformed on the cliente side.
    public func processRequest<T>(endPoint: RouteEndPoint<T>) -> AnyPublisher<T, Error> {
        let decoder = endPoint
//        decoder.endPoint = .products
        return RequestService.makeRequest(decoder)
            .map { data in
                return data }
            .eraseToAnyPublisher()
    }
}

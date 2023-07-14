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

/// Extension to process HTTPService
extension HTTPService {
    
    /// Method that handle any HTTP Request
    /// - Parameter urlRequest: urlRequest setted that enable you to make your request
    /// - Parameter routeEndPoint: your instance of type RouteEndPoint that will parse the data.
    /// - Returns: Return a Publisher that could be of type Data or Error if there is any connection problem, that Data still needs to be transformed on the cliente side.
    public func processRequest<T>(_ routeEndPoint: RouteEndPoint<T>) -> AnyPublisher<T, Error> {
        return RequestService.makeRequest(routeEndPoint)
            .map { data in
                return data }
            .eraseToAnyPublisher()
    }
}

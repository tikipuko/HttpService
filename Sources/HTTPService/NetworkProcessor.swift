//
//  File.swift
//  
//
//  Created by Correia, Jose Bastos on 30/06/2023.
//

import Foundation
import Combine

/// Class to execute Network Engine
final class RequestService {
    
    ///  Method to return any Data or Error from any request.
    /// - Parameter request: URLRequest to execute the connection.
    /// - Returns: Pretended Data or Error
    
    internal static func makeRequest<ResponseDataType>(_ request: RouteEndPoint<ResponseDataType>) -> AnyPublisher<ResponseDataType, Error> {
        return URLSession.shared.dataTaskPublisher(for: request.endPoint!.request)
                .tryMap { (data, _) -> ResponseDataType in
                    guard let parser = request.parser else {
                        return URLError.cannotParseResponse as! ResponseDataType
                    }
                    return try parser.parse(data: data)
                }
                .mapError { error -> Error in
                    switch error {
                    case URLError.badURL:
                        print(request.endPoint!.request.url!.absoluteString)
                    case URLError.cannotFindHost, URLError.notConnectedToInternet:
                        print(error.localizedDescription)
                    default:
                        print("Unkown Error")
                    }
                    return error
                }
                .eraseToAnyPublisher()
        }
}



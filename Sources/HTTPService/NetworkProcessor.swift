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
    internal static func makeRequest(request: URLRequest) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: request)
                .tryMap { (data, _) -> Data in
                    return data
                }
                .mapError { error -> Error in
                    switch error {
                    case URLError.badURL:
                        print(request.url!.absoluteString)
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



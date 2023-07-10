//
//  File.swift
//  
//
//  Created by Correia, Jose Bastos on 30/06/2023.
//

import Foundation
import Combine

class RequestService {
    internal func makeRequest(request: URLRequest) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: request)
                .tryMap { (data, _) -> Data in
                    return data
                }
                .mapError { error -> Error in
                    switch error {
                    case URLError.cannotFindHost:
                        print(error.localizedDescription)
                        return URLError.badURL as! Error
                    default:
                        return error.self
                    }
                }
                .eraseToAnyPublisher()
        }
}



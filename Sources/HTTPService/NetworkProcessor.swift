//
//  File.swift
//  
//
//  Created by Correia, Jose Bastos on 30/06/2023.
//

import Foundation
import UIKit
import Combine



///ask about protocols
protocol RequestServiceProtocol {
    func makeRequest(request: URLRequest) -> AnyPublisher<Data, Error>
}

class RequestService: RequestServiceProtocol {
    func makeRequest(request: URLRequest) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: request)
                .tryMap { (data, _) -> Data in
                    print("trymap")
                    return data
                }
                .mapError { error -> Error in
                    switch error {
                    case URLError.cannotFindHost:
                        return error.localizedDescription as! Error
                    default:
                        return error.self
                    }
                }
                .eraseToAnyPublisher()
        }
}



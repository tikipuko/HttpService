//
//  File.swift
//  
//
//  Created by Correia, Jose Bastos on 30/06/2023.
//

import Foundation
import UIKit
import Combine

//class RouteEndPoint<Response> {
//    var endPoint: URLRequest?
//    var parser: ((Data) -> Response)!
//}

//class ImageLoader: RouteEndPoint<UIImage?> {
//
//    override init() {
//        super.init()
//        self.parser = {(data: Data) -> UIImage in
//            return UIImage(data: data) ?? UIImage()
//        }
//    }
//}
//
//class ServiceLoader<T: Codable>: RouteEndPoint<T> {
//    override init() {
//        super.init()
//        self.parser = {(data: Data) -> T in
//            return try! JSONDecoder().decode(T.self, from: data)
//        }
//    }
//}

protocol RequestServiceProtocol {
    func makeRequest(request: URLRequest) -> AnyPublisher<Data, HttpError>
}

class RequestService: RequestServiceProtocol {
    
    func makeRequest(request: URLRequest) -> AnyPublisher<Data, HttpError> {
        return URLSession.shared.dataTaskPublisher(for: request)
                .tryMap { (data, _) -> Data in
                    print("trymap")
                    return data
                }
                .mapError { error -> HttpError in
                    switch error {
                    case URLError.cannotFindHost:
                        return HttpError.generic(error.localizedDescription)
                    default:
                        return HttpError.noData
                        
                    }
                }
                .eraseToAnyPublisher()
        }
}



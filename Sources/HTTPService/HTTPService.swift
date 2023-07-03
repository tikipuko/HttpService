import Foundation
import UIKit
import Combine

public class HTTPService {
    
    var cancellables = Set<AnyCancellable>()
    
    public init() {
        
    }
    
    public func loadImage(url: String) -> AnyPublisher<Data, Error> {
        return requestImage(url: url)  //"https://picsum.photos/200/300"
            .map { data in
                return data }
            .eraseToAnyPublisher()
    }
    
    private func requestImage(url: String) -> AnyPublisher<Data, Error> {
        let url = URL(string: url)!
        let urlRequest = URLRequest(url: url)
        let http = RequestService()
        return http.makeRequest(request: urlRequest)
    }

    public func loadJson(url: String) -> AnyPublisher<Data, Error> {
        return requestJson(url: url)
        .map { data in
            return data }
        .eraseToAnyPublisher()
        
    }
    
    private func requestJson(url: String) -> AnyPublisher<Data, Error> {
        print("requestJson")
        let url = URL(string: url)!
        let urlRequest = URLRequest(url: url)
        let http = RequestService()
        return http.makeRequest(request: urlRequest)
    }
}


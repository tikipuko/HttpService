import Foundation
import UIKit
import Combine

public class HTTPService {
    
    var cancellables = Set<AnyCancellable>()
    
    public init() {
        
    }
    
    public func loadImage(url: String) -> UIImage {
        var image: UIImage = UIImage(systemName: "camera")!
        requestImage(url: url)
            .receive(on: RunLoop.main)
            .replaceError(with: image)
            .sink { value in
                image = value!
            }
            .store(in: &cancellables)
        return image
    }
    
    private func requestImage(url: String) -> AnyPublisher<UIImage?, HttpError> {
        let url = URL(string: url)!
        let urlRequest = URLRequest(url: url)
        let route = ImageLoader()
        route.endPoint = urlRequest
        let http = RequestService()
        return http.makeRequest(route)
    }
    
    public func loadJson(url: String, responseType: Codable) -> Codable {
        let result: Codable = []
        requestJson(url: url, responseType: responseType)
            .receive(on: RunLoop.main)
            .sink { result in
                print(result)
            } receiveValue: { value in
                result = value
            }.store(in: &cancellables)
        return result
    }
    
    private func requestJson(url: String, responseType: Any) -> AnyPublisher<[Codable], HttpError> {
        let url = URL(string: url)!
        let urlRequest = URLRequest(url: url)
        let route = ServiceLoader<Mock>()
        route.endPoint = urlRequest
        let http = RequestService()
        return http.makeRequest(route)
    }
}

struct Mock: Codable {
    var id: Int
    var name: String
    var age: Int
}

class Mocks {
    let mockData: [Mock] = [
        Mock(id: 1, name: "one", age: 10),
        Mock(id: 2, name: "two", age: 20),
        Mock(id: 3, name: "three", age: 30),
    ]
}

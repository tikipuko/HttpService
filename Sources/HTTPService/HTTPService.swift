import Foundation
import UIKit
import Combine

public class HTTPService {
    
    var cancellables = Set<AnyCancellable>()
    
    public init() {
        
    }
    
//    public func loadImage() -> Data {
//        var image: Data
//        requestImage(url: "https://picsum.photos/200/300")
//            .receive(on: RunLoop.main)
//            .replaceError(with: image)
//            .sink { value in
//                image = value
////                print("DEBUG ----- \(value.size.with)")
//            }
//            .store(in: &cancellables)
//        return image
//    }
    
//    private func requestImage(url: String) -> AnyPublisher<Data, HttpError> {
//        let url = URL(string: url)!
//        let urlRequest = URLRequest(url: url)
//        let http = RequestService()
//        return http.makeRequest(urlRequest)
//    }

    public func loadJson(url: String) -> Data {
        var result: Data? = nil
        requestJson(url: url)
            .receive(on: RunLoop.main)
            .sink { result in
                sleep(3)

                print("result")
                print(result)
            } receiveValue: { value in
                result = value
            }.store(in: &cancellables)
//        sleep(3)

        return result!
    }
    
    private func requestJson(url: String) -> AnyPublisher<Data, HttpError> {
        print("requestJson")
        let url = URL(string: url)!
        let urlRequest = URLRequest(url: url)
        let http = RequestService()
        return http.makeRequest(request: urlRequest)
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

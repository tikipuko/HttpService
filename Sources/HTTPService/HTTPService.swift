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

    public func loadJson(url: String) -> Data? {
        var result: Data?
        requestJson(url: url)
            .sink { result in
                print("result")
                print(result)
            } receiveValue: { value in
                result = value
            }.store(in: &cancellables)

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


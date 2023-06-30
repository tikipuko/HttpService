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
    
    public func requestJson() {
        
    }
    
    
    
    
    
    
    
    
    
}

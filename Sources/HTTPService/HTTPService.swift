import Foundation
import Combine

public class HTTPService {
    

    public init() {
        
    }
    
    public func urlBuilder(scheme: String, host: String, path: String, queryItems: [URLQueryItem] = []) -> URL {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        components.queryItems = queryItems
        
        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }
        return url
    }
    
    public func requestBuilder(url: URL, method: String?, key: String?, header: String?) -> URLRequest {
        var urlRequest = URLRequest(url: url)
        
        guard let method = method else {
            return urlRequest
        }
        
        guard let key = key, let header = header else {
            urlRequest.httpMethod = method
            return urlRequest
        }
        
        urlRequest.setValue(key, forHTTPHeaderField: header)
        
        return urlRequest
    }

    
    public func processRequest(url: URL) -> AnyPublisher<Data, Error> {
        return makeRequest(url: url)
            .map { data in
                return data }
            .eraseToAnyPublisher()
    }
    
    private func makeRequest(url: URL) -> AnyPublisher<Data, Error> {
        let urlRequest = URLRequest(url: url)
        let http = RequestService()
        return http.makeRequest(request: urlRequest)
    }
}


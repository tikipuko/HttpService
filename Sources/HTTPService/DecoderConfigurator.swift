//
//  File.swift
//  
//
//  Created by Correia, Jose Bastos on 12/07/2023.
//

import Foundation
import UIKit

open class RouteEndPoint<ResponseDataType> {
    var endPoint: URLRequest!
    var parser: ((Data) -> ResponseDataType)!
    
    public init(endPoint: URLRequest!) {
        self.endPoint = endPoint
    }
}

public class ImageLoader: RouteEndPoint<UIImage?> {
    public init(_ urlRequest: URLRequest) {
        super.init(endPoint: urlRequest)
        self.parser = { (data: Data) -> UIImage? in
            return UIImage(data: data)
        }
    }
}

public class JsonLoader<T: Codable>: RouteEndPoint<T> {
    public init(_ urlRequest: URLRequest) {
        super.init(endPoint: urlRequest)
        self.parser = {(data: Data) -> T in
            return try! JSONDecoder().decode(T.self, from: data)
        }
    }
}

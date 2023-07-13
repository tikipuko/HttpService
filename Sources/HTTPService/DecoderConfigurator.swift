//
//  File.swift
//  
//
//  Created by Correia, Jose Bastos on 12/07/2023.
//

import Foundation
import UIKit

public class RouteEndPoint<ResponseDataType> {
    var endPoint: EndPoint?
    var parser: DataParser<ResponseDataType>!
    
    public init() {}
}

class DataParser<T> {
    private let parser: (Data) throws -> T
    
    init(parser: @escaping (Data) throws -> T) {
        self.parser = parser
    }
    
    func parse(data: Data) throws -> T {
        return try parser(data)
    }
}


//class ImageLoader: RouteEndPoint<UIImage?> {
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

//
//  File.swift
//  
//
//  Created by Correia, Jose Bastos on 12/07/2023.
//

import Foundation
import UIKit

public class RouteEndPoint<ResponseDataType> {
    var endPoint: Route?
    var parser: ((Data) -> ResponseDataType)!
}

class DataParser<ResponseDataType: Codable>: RouteEndPoint<ResponseDataType> {
    override init() {
        super.init()
        if ResponseDataType.self == UIImage.self {
            self.parser = { (data: Data) -> ResponseDataType in
                guard let image = UIImage(data: data) else {
                    return UIImage() as! ResponseDataType
                }
                return image as! ResponseDataType
            }
        } else {
            self.parser = { (data: Data) -> ResponseDataType in
                return try! JSONDecoder().decode(ResponseDataType.self, from: data)
            }
        }
    }
}



//public class RouteEndPoint<ResponseDataType> {
//    var endPoint: Route?
//    var parser: ((Data) -> ResponseDataType)!
//
//    func parseData<ResponseDataType: Decodable>(data: Data) -> ResponseDataType {
//
//            if let image = UIImage(data: data) {
//                return image as! ResponseDataType
//            }
//            else {
//                do {
//                    return try JSONDecoder().decode(ResponseDataType.self, from: data)
//                }
//                catch {
//                    print("Error trying JsonDecoder() for \(ResponseDataType.Type.self)")
//                }
//            }
//            return ResponseDataType.self as! ResponseDataType
//        }
//}

//public class DataParser<T> {
//    private let parser: (Data) throws -> T
//
//    init(parser: @escaping (Data) throws -> T) {
//        self.parser = parser
//    }
//
//    func parse(data: Data) throws -> T {
//        return try parser(data)
//    }
//}

//class DataParser<ResponseDataType: Codable & UIImage>: RouteEndPoint<ResponseDataType> {
//    override init() {
//        super.init()
//        if let image = UIImage(data: Data) {
//            self.parser = {(data: Data) -> UIImage in
//                return UIImage(data: data) ?? UIImage()
//            }
//        }
//        else {
//            do {
//                self.parser = {(data: Data) -> ResponseDataType in
//                    return try! JSONDecoder().decode(ResponseDataType.self, from: data)
//                }
//            }
//            catch {
//                print("Error trying JsonDecoder() for \(ResponseDataType.Type.self)")
//            }
//        }
//    }
//}


//class ImageLoader: RouteEndPoint<UIImage?> {
//    override init() {
//        super.init()
//        self.parser = {(data: Data) -> UIImage in
//            return UIImage(data: data) ?? UIImage()
//        }
//    }
//}

//class ServiceLoader<T: Codable>: RouteEndPoint<T> {
//    override init() {
//        super.init()
//        self.parser = {(data: Data) -> T in
//            return try! JSONDecoder().decode(T.self, from: data)
//        }
//    }
//}

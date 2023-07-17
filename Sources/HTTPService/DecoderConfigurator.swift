//
//  File.swift
//  
//
//  Created by Correia, Jose Bastos on 12/07/2023.
//

import Foundation
import UIKit

open class RouteEndPoint<ResponseDataType> {
    open var endPoint: EndPoint?
    open var parser: ((Data) -> ResponseDataType)!
}

public class ImageLoader: RouteEndPoint<UIImage?> {
    public override init() {
        super.init()
        self.parser = { (data: Data) -> UIImage? in
            return UIImage(data: data)
        }
    }
}

public class JsonLoader<T: Codable>: RouteEndPoint<T> {
    public override init() {
        super.init()
        self.parser = {(data: Data) -> T in
            return try! JSONDecoder().decode(T.self, from: data)
        }
    }
}

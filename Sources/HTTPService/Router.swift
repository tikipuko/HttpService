//
//  File.swift
//  
//
//  Created by Correia, Jose Bastos on 12/07/2023.
//

//import Foundation
//import UIKit
//
//public enum Route {
//    
//    case categories,
//         products,
//         search(String),
//         productByID(String),
//         image(String)
//}
//
//extension Route {
//    
//    var request: URLRequest {
//        
//        switch self {
//            
//        case .categories:
//            let product = AmazonEndpoint(path: "product/categories")
//            return product.httpRequest
//            
//        case .products:
//            let product = AmazonEndpoint(path: "product")
//            return product.httpRequest
//            
//        case .image(let url):
//            return URLRequest(url: URL(string: url)! )
//            
//        case .productByID(let id):
//            let product = AmazonEndpoint(path: "product/\(id)")
//            return product.httpRequest
//            
//        case .search(let searchTerm):
//            let product = AmazonEndpoint(path: "product")
//            product.queryItems = [URLQueryItem(name: "searchTerm", value: searchTerm)]
//            return product.httpRequest
//        }
//    }
//}


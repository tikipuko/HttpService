//
//  File.swift
//  
//
//  Created by Correia, Jose Bastos on 30/06/2023.
//

import Foundation

enum HttpError: Error {
    case generic(String)
    case noData
    case parsing
}

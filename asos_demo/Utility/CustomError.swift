//
//  CustomError.swift
//  
//
//  Created by Surendra.
//  Copyright © 2019 Surendra. All rights reserved.
//

import Foundation

enum CustomError: Error {
    case parsing(errorDescription: String)
    case network(errorDescription: String)
    case saveData(errorDescription: String)
    case unknown(errorDescription: String)
    
}

extension CustomError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .parsing(let errorDescription): return errorDescription
        case .network(let errorDescription): return errorDescription
        case .saveData(let errorDescription): return errorDescription
        case .unknown(let errorDescription): return errorDescription
        }
    }
    
}

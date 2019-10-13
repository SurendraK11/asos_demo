//
//  DataParsing.swift
//
//
//  Created by Surendra.
//  Copyright © 2019 Surendra. All rights reserved.
//

import Foundation

protocol DataParsing {
    /// Responsible to de-serialize data into given type
    ///
    /// - Parameters:
    ///   - data: Data
    ///   - type: expected type
    /// - Returns: Result : Success(expected type) or  Result : failure(Error)
    func parse<T: Decodable>(fromData data:  Data, inType type: T.Type) ->  Result<T, Error>
    
}

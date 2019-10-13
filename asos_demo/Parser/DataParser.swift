//
//  DataParser.swift
//  
//
//  Created by Surendra.
//  Copyright © 2019 Surendra. All rights reserved.
//

import Foundation

struct DataParser {
}

extension DataParser: DataParsing {
    /// Responsible to de-serialize data into given type
    ///
    /// - Parameters:
    ///   - data: Data
    ///   - type: expected type
    /// - Returns:  Result : Success(expected type) or  Result : failure(Error)
    func parse<T>(fromData data: Data, inType type: T.Type) -> Result<T, Error> where T : Decodable {
        do {
            let object = try JSONDecoder().decode(T.self, from: data)
            return Result.success(object)
        } catch  {
            debugPrint("\(error)")
            return Result.failure(CustomError.parsing(errorDescription: "Data parsing error"))
        }
    }
    
}

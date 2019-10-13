//
//  DataRetrievingService.swift
//  
//
//  Created by Surendra.
//  Copyright © 2019 Surendra. All rights reserved.
//

import Foundation

/// Data retrieving service
struct DataRetrievingService {
    
    /// Responsible to retrieve data from server
    ///
    /// - Parameters:
    ///   - session: URLSession with default shared session
    ///   - urlComponents: URLComponents
    ///   - parser: DataParsing
    ///   - result: Result<T, Error>
    /// - Returns: URLSessionDataTask session data task
    func retrieveData<T: Decodable>(withSession session: URLSession = .shared, urlComponents: URLComponents, parser: DataParsing, result: @escaping (Result<T, Error>) -> Void) -> URLSessionDataTask? {
        guard let url = urlComponents.url else {
            result(.failure(CustomError.network(errorDescription: "URL error")))
            return nil
        }
        
        let task = session.dataTask(with: URLRequest(url: url)) { (data, response, error) in
            if let error = error {
                result(.failure(CustomError.network(errorDescription: error.localizedDescription)))
            }
            
            if let data = data {
                let parsedResult = parser.parse(fromData: data, inType: T.self)
                switch parsedResult {
                case .success(let objects):
                    result(.success(objects))
                case .failure(let error):
                    result(.failure(error))
                }
            }
        }
        task.resume()
        return task
    }
}

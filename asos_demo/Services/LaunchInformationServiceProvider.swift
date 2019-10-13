//
//  LaunchInformationServiceProvider.swift
//  asos_demo
//
//  Created by Surendra on 06/10/2019.
//  Copyright © 2019 Surendra. All rights reserved.
//

import Foundation

/// Responsible to retrieve data (Launch Information)
struct LaunchInformationServiceProvider: LaunchInformationServiceProviding {
    func fetchLaunchInformation(_ result: @escaping (Result<LaunchInfo, Error>) -> Void, completionQueue queue: DispatchQueue) {
        
        var company: Company?
        var launches: [Launch]?
        
        let dispatchGroup = DispatchGroup()
        var receivedError: Error?
        var companyDataTask: URLSessionDataTask?
        var launchesDataTask: URLSessionDataTask?
        
        cancelTask(companyDataTask)
        dispatchGroup.enter()
        companyDataTask = DataRetrievingService().retrieveData(urlComponents: URLComponents(string: "https://api.spacexdata.com/v3/info")!, parser: DataParser()) { (result: Result<Company, Error>) in
            
            defer {
                dispatchGroup.leave()
            }
            
            switch result {
            case .success(let companyInfo):
                company = companyInfo
            case .failure(let error):
                receivedError = error
            }
        }
        
        
        cancelTask(launchesDataTask)
        dispatchGroup.enter()
        launchesDataTask = DataRetrievingService().retrieveData(urlComponents: URLComponents(string: "https://api.spacexdata.com/v3/launches")!, parser: DataParser()) { (result: Result<[Launch], Error>) in
            
            defer {
                dispatchGroup.leave()
            }
            
            switch result {
            case .success(let launchList):
                launches = launchList
            case .failure(let error):
                receivedError = error
            }
        }
        
        dispatchGroup.notify(queue: queue) {
            if let error = receivedError {
                queue.async {
                    result(.failure(error))
                }
            } else {
                queue.async {
                    result(.success(LaunchInfo(company: company!, launches: launches!)))
                }
            }
        }
        
    }
    
    
    private func cancelTask(_ task: URLSessionDataTask?) {
        if let _ = task {
            task!.cancel()
        }
    }
    
}

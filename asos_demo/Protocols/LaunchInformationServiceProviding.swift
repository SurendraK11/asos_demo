//
//  LaunchInformationServiceProviding.swift
//  asos_demo
//
//  Created by Surendra on 06/10/2019.
//  Copyright © 2019 Surendra. All rights reserved.
//

import Foundation

/// Responsible to provide data for UI
protocol LaunchInformationServiceProviding {
    /// Responsible to get launch information
    ///
    /// - Parameters:
    ///   - result: expected Result<LaunchInfo, Error>
    ///   - queue: DispatchQueue - expected result must be processed in given queue
    func fetchLaunchInformation(_ result: @escaping (Result<LaunchInfo, Error>) -> Void, completionQueue queue: DispatchQueue)
    
}

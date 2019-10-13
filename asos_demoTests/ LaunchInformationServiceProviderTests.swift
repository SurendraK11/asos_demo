//
//   LaunchInformationServiceProviderTests.swift
//  asos_demoTests
//
//  Created by Surendra on 13/10/2019.
//  Copyright © 2019 Surendra. All rights reserved.
//

import XCTest
@testable import asos_demo

class  LaunchInformationServiceProviderTests: XCTestCase {
    
    let dataProvider = LaunchInformationServiceProvider()

    func testFetchLaunchInformation() {
        let expectation = XCTestExpectation(description: "Download data")
        dataProvider.fetchLaunchInformation({ result in
            XCTAssert(Thread.isMainThread, "current thread must be main thread")
            switch result {
            case .success(let launchInfo):
                XCTAssertNotNil(launchInfo.company, "there must be company")
                XCTAssertGreaterThan(launchInfo.launches.count, 0, "There must be some launches data")
            case .failure(let error):
                 XCTAssertNotNil(error, "found error: \(error)")
            }
            expectation.fulfill()
            
        }, completionQueue: .main)
        
        wait(for: [expectation], timeout: 10.0)
    
    }
    
}

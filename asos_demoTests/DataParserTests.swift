//
//  DataParserTests.swift
//  asos_demoTests
//
//  Created by Surendra.
//  Copyright © 2019 Surendra. All rights reserved.
//

import XCTest
@testable import asos_demo

class DataParserTests: XCTestCase {

    let dataParser: DataParsing = DataParser()
    
    func testLaunchResponseParsing() {
        self.testReturnedType(forFile: "Launch", ofType: "json", expectedReturnedType: [Launch].self)
        
    }
    
    func testCompanyResponseParsing() {
        self.testReturnedType(forFile: "Company", ofType: "json", expectedReturnedType: Company.self)

    }
    
    // MARK: - Private methods
    private func testReturnedType<T: Decodable>(forFile fileName: String, ofType fileType: String, expectedReturnedType returnedType: T.Type) {
        if let data = TestHelper.data(ofFile: fileName, ofType: fileType) {
            typealias expectedType = T
            let result = dataParser.parse(fromData: data, inType: expectedType.self)
            
            var returnedType: expectedType?
            var parseError: Error?
            switch result {
            case .success(let type):
                returnedType = type
            case .failure(let error):
                parseError = error
            }
            
            XCTAssertNotNil(returnedType, "Parsing should return data of \(expectedType.self)")
            XCTAssertNil(parseError, "parsing erorr must be nil")
        }
    }
}

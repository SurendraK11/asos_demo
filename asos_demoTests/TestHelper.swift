//
//  TestHelper.swift
//  coople_demoTests
//
//  Created by Surendra.
//  Copyright © 2019 Surendra. All rights reserved.
//

import Foundation
struct TestHelper {
    static func data(ofFile fileName: String, ofType type: String) -> Data? {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: type), let data = try? Data(contentsOf: url) else {
            return nil
        }
        return data
        
    }
}

//
//  Company.swift
//  asos_demo
//
//  Created by Surendra.
//  Copyright © 2019 Surendra. All rights reserved.
//

import Foundation

struct Company: Decodable {
    let companyName: String
    let founderName: String
    let fundedYear: Int
    let numberOfEmployees: Int
    let numberOflaunchSites: Int
    let valuation: Int
    
    enum CodingKeys: String, CodingKey {
        case companyName = "name"
        case founderName = "founder"
        case fundedYear = "founded"
        case numberOfEmployees = "employees"
        case numberOflaunchSites = "launch_sites"
        case valuation = "valuation"
    }
    
}

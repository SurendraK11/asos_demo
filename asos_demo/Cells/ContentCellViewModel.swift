//
//  ContentCellViewModel.swift
//  asos_demo
//
//  Created by Surendra on 07/10/2019.
//  Copyright © 2019 Surendra. All rights reserved.
//

import Foundation

struct ContentCellViewModel: ContentCellViewModelProtocol {
    
    private let company: Company
    
    init(withCompany company: Company) {
        self.company = company
    }
    
    func informaiton() -> String {
        return "\(company.companyName) was founded by \(company.founderName) in \(company.fundedYear). It has now \(company.numberOfEmployees) employees, \(company.numberOflaunchSites) launch sites, and is valued at USD \(company.valuation)"
    }
}

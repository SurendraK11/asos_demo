//
//  LaunchListViewModel.swift
//  asos_demo
//
//  Created by Surendra on 06/10/2019.
//  Copyright © 2019 Surendra. All rights reserved.
//

import Foundation

class LaunchListViewModel: LaunchListViewModelProtocol {
    
    var onErrorHandling: ((Error) -> Void)?
    var activateFilerOption: (() -> Void)?
    
    private(set) var filterOption: ObservableValue<FilterRange>
    private(set) var isLoading: ObservableValue<Bool>
    
    private(set) var dataSource: LaunchInfDataSourceProtocol
    let launchInformationService: LaunchInformationServiceProviding

    let ascOrder = { (l1: Launch, l2: Launch) -> Bool in
        l1.launchYear < l2.launchYear
    }
    
    let descOrder = { (l1: Launch, l2: Launch) -> Bool in
        l1.launchYear > l2.launchYear
    }
    
    /// internal cache to store data returned from server
    private var originalData: LaunchInfo?
    
    init(withDataSource dataSource: LaunchInfDataSourceProtocol, launchInformationService: LaunchInformationServiceProviding) {
        self.dataSource = dataSource
        self.launchInformationService = launchInformationService
        filterOption = .init(withValue: nil)
        isLoading = .init(withValue: false)
    }
    
    func fetchLaunchInfo() {
        isLoading.value = true
        launchInformationService.fetchLaunchInformation({ [weak self] result in
            guard let self = self else {
                return
            }
            
            defer {
                self.isLoading.value = false
            }
            
            switch result {
            case .success(let launchInfo):
                // Considering default sorting order is asc order
                let sortedLaunches = launchInfo.launches.sorted(by: self.ascOrder)
                
                /// update internal cache (original data returned from server)
                self.originalData = LaunchInfo(company: launchInfo.company, launches: sortedLaunches)
                
                if sortedLaunches.count > 0 {
                    //prepare filter option by setting up min/ max value and default
                    //sort option
                    let firstLaunchYear = sortedLaunches[0].launchYear
                    let lastLaunchYear = sortedLaunches[sortedLaunches.count-1].launchYear
                    self.filterOption.value = FilterRange(minValue: firstLaunchYear, maxValue: lastLaunchYear, selectedMinValue: firstLaunchYear, selectedMaxValue: lastLaunchYear, sortOption: .ASC)
                    self.activateFilerOption?()
                    self.setupObserver()
                }
                
                self.dataSource.data.value = self.originalData
            
            case .failure(let error):
                self.onErrorHandling?(error)
            }
        }, completionQueue: DispatchQueue.main)

    }
    
    //MARK: - Private methods
    
    /// setup observer for filter option
    private func setupObserver() {
        filterOption.addObserver() { [weak self] in
            guard let self = self else {
                return
            }
            if let filter = self.filterOption.value, let origitalData = self.originalData {
                let filteredLaunches = origitalData.launches.filter({ (lauch) -> Bool in
                    (lauch.launchYear >= filter.selectedMinValue && lauch.launchYear <= filter.selectedMaxValue)
                })
                let sortOrder = filter.sortOption == .ASC ? self.ascOrder : self.descOrder
                let sorted = filteredLaunches.sorted(by: sortOrder)
                
                self.dataSource.data.value = LaunchInfo(company: origitalData.company, launches: sorted)
            }
            
        }
    }
}

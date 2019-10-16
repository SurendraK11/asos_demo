//
//  LaunchListViewModelProtocol.swift
//  asos_demo
//
//  Created by Surendra on 13/10/2019.
//  Copyright © 2019 Surendra. All rights reserved.
//

import Foundation

protocol LaunchListViewModelProtocol {
    var onErrorHandling : ((Error) -> Void)? {get set}
    var showFilerOption:(() -> Void)? {get set}
    var filterOption: ObservableValue<FilterRange> {get}
    var dataSource : LaunchInfDataSourceProtocol {get}
    var isLoading: ObservableValue<Bool> {get}
    
    func fetchLaunchInfo()
}

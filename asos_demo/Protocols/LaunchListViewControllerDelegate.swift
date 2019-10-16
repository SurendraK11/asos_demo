//
//  LaunchListViewControllerDelegate.swift
//  asos_demo
//
//  Created by Surendra on 13/10/2019.
//  Copyright © 2019 Surendra. All rights reserved.
//

import Foundation

protocol LaunchListViewControllerDelegate: class {
    func launchListViewControllerDidSelectLaunch(_ launch: Launch)
    func launchListViewControllerShowFilterForFilterRange(_ filterRange: FilterRange, changeFilterClosure filterClosure: @escaping ((FilterRange) -> ()))
}

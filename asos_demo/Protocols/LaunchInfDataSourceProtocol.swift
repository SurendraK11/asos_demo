//
//  LaunchInfDataSourceProtocol.swift
//  asos_demo
//
//  Created by Surendra on 13/10/2019.
//  Copyright © 2019 Surendra. All rights reserved.
//

import Foundation
import UIKit

protocol LaunchInfDataSourceProtocol: GenericDataSource<LaunchInfo>, UITableViewDataSource, UITableViewDelegate  {
    var didSelectLaunch: ((Launch) -> Void)? {get set}
    
}

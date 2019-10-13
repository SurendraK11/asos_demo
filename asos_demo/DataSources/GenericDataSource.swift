//
//  GenericDataSource.swift
//  asos_demo
//
//  Created by Surendra.
//  Copyright © 2019 Surendra. All rights reserved.
//

import Foundation

class GenericDataSource<T>: NSObject {
    
    var data: ObservableValue<T> = ObservableValue(withValue: nil)

}



//
//  FilterOptionPresenting.swift
//  asos_demo
//
//  Created by Surendra on 12/10/2019.
//  Copyright © 2019 Surendra. All rights reserved.
//

import Foundation
import UIKit

protocol FilterOptionPresenting where Self: UIViewController {
    
    func presentFilter(_ filter: FilterRange, forViewController viewController: UIViewController, changeFilterClosure filterClosure: @escaping ((FilterRange) -> ()))
    
}

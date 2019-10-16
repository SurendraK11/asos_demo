//
//  Showable.swift
//  asos_demo
//
//  Created by Surendra on 13/10/2019.
//  Copyright © 2019 Surendra. All rights reserved.
//

import Foundation
import UIKit

protocol Showable {
    
    func toShowable() -> UIViewController
    
}

extension UIViewController: Showable {
    public func toShowable() -> UIViewController {
        return self
    }
}

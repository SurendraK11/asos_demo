//
//  AlertMessaging.swift
//
//
//  Created by Surendra
//  Copyright © 2019 Surendra. All rights reserved.
//

import Foundation
import UIKit

/// Helper class to show different kind of message
protocol ShowMessaging where Self: UIViewController {
    
    /// Responsible to show error message
    ///
    /// - Parameters:
    ///   - error: Error
    ///   - completionHandler: (() -> Void) - optional
    func showError(_ error: Error, completionHandler: (() -> Void)?)

}

//
//  UIViewController+AlertMessaging.swift
//
//
//  Created by Surendra.
//  Copyright © 2019 Surendra. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController: ShowMessaging {
    func showError(_ error: Error, completionHandler: (() -> Void)?) {
        var errorMessage =  (error as NSError).localizedDescription
        if let customError = error as? CustomError {
            errorMessage = customError.localizedDescription
        }
        let alertController = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler:nil))
        self.present(alertController, animated: true, completion: completionHandler)
    }
    
    func showConfirmAction(title: String?, message: String?, actions: [UIAlertAction]?, style: UIAlertController.Style = .alert) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        if let alertActions = actions {
            for action in alertActions {
                alertController.addAction(action)
            }
        }
        self.present(alertController, animated: true, completion: nil)
    }
}


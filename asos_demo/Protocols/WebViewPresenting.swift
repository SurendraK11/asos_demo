//
//  WebViewPresenting.swift
//  asos_demo
//
//  Created by Surendra on 13/10/2019.
//  Copyright © 2019 Surendra. All rights reserved.
//

import Foundation
import UIKit

protocol WebViewPresenting where Self: UIViewController {
    
    func loadURL(_ url: URL, withTitle title: String, forViewController viewController: UIViewController)

}

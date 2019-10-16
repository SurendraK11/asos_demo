//
//  ApplicationCoordinator.swift
//  asos_demo
//
//  Created by Surendra on 13/10/2019.
//  Copyright © 2019 Surendra. All rights reserved.
//

import Foundation
import UIKit

class ApplicationCoordinator: Coordinator {
    
    let window: UIWindow
    let rootViewController: UINavigationController
    let launchRouter: LaunchRouter
    let launchListCoordinator: LaunchListCoordinator
    
    init(withWindow window: UIWindow) {
        self.window = window
        rootViewController = UINavigationController()
        launchRouter = LaunchRouter(navigationController: rootViewController)
        launchListCoordinator = LaunchListCoordinator(withPresenter: launchRouter)
    }
    
    
    func start() {
        window.rootViewController = launchRouter.toShowable()
        launchListCoordinator.start()
        window.makeKeyAndVisible()
    }
    
}

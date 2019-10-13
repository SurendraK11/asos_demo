//
//  AppDelegate.swift
//  asos_demo
//
//  Created by Surendra.
//  Copyright © 2019 Surendra. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow.init(frame: UIScreen.main.bounds)
        
        window?.rootViewController = LaunchListViewController(withViewModel: LaunchListViewModel(withDataSource: LaunchInfDataSource(), launchInformationService: LaunchInformationServiceProvider()),  filterOptionPresenter: FilterOptionPresenter(), webViewPresenter: WebViewPresenter())
        
        window?.makeKeyAndVisible()
        return true
    }

}


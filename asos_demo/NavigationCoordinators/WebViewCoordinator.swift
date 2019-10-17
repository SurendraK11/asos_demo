//
//  WebViewCoordinator.swift
//  asos_demo
//
//  Created by Surendra on 17/10/2019.
//  Copyright © 2019 Surendra. All rights reserved.
//

import Foundation

class WebViewCoordinator: Coordinator {
    
    private let presenter: Router
    private let url: URL
    private let pageName: String
    
    init(withPresenter presenter: Router, url: URL, pageName: String) {
        self.presenter = presenter
        self.url = url
        self.pageName = pageName
    }
    
    func start() {
        let webViewPresenter = WebViewViewController(withURL: url, pageName: pageName)
        presenter.present(webViewPresenter.toShowable(), animated: true)
    }
    
}

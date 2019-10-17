//
//  LaunchListCoordinator.swift
//  asos_demo
//
//  Created by Surendra on 13/10/2019.
//  Copyright © 2019 Surendra. All rights reserved.
//

import Foundation
import UIKit

class LaunchListCoordinator: Coordinator {
    private let presenter: Router
    private var launchListViewController: LaunchListViewController?
    
    init(withPresenter presenter: Router) {
        self.presenter = presenter
    }
    
    func start() {
        let launchListViewController = LaunchListViewController(withViewModel: LaunchListViewModel(withDataSource: LaunchInfDataSource(), launchInformationService: LaunchInformationServiceProvider()))
        launchListViewController.title = "SpaceX"
        launchListViewController.delegate = self
        presenter.push(launchListViewController, animated: true, completion: nil)
        self.launchListViewController = launchListViewController
    }

}

extension LaunchListCoordinator: LaunchListViewControllerDelegate {
    
    /// Showing filter view
    ///
    /// - Parameters:
    ///   - filterRange: FilterRange
    ///   - filterClosure: filterClosure
    func launchListViewControllerShowFilterForFilterRange(_ filterRange: FilterRange, changeFilterClosure filterClosure: @escaping ((FilterRange) -> ())) {
        let filterOptionCoordinator = FilterOptionCoordinator(withPresenter: presenter, filterRange: filterRange, changeFilterClosure: filterClosure)
        filterOptionCoordinator.start()
    }

    
    /// showing option to user to choose open wiki or play
    ///
    /// - Parameter launch: Launch
    func launchListViewControllerDidSelectLaunch(_ launch: Launch) {
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) {_ in}
        
        /// play video alert action
        let playVideo = UIAlertAction(title: "Play Video", style: .default) { _ in
            guard let videoUrl = launch.links.videoLink, let videoId = launch.links.youtubeId, let url = URL(string: "\(videoUrl)/\(videoId)") else {
                self.showAlertMessage("Sorry, video not found")
                return
            }
            self.presentWebView(forURL: url, pageName: "Video")
        }
        
        /// show wiki alert action
        let openWiki = UIAlertAction(title: "Open Wiki", style: .default) { _ in
            guard let wikipediaLink = launch.links.wikipedia, let url = URL(string: wikipediaLink) else {
                self.showAlertMessage("Sorry, wiki page not found")
                return
            }
            self.presentWebView(forURL: url, pageName: "Wiki")
        }
        
        let alertController = UIAlertController(title: "Choose Option", message: nil, preferredStyle: .actionSheet)
        alertController.addAction(playVideo)
        alertController.addAction(openWiki)
        alertController.addAction(cancel)
        presenter.present(alertController.toShowable(), animated: true)
    }
    
    
    private func showAlertMessage(_ message: String) {
        let ok = UIAlertAction(title: "OK", style: .default) {_ in}
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertController.addAction(ok)
        self.presenter.present(alertController, animated: true)
    }
    
    private func presentWebView(forURL url: URL, pageName: String) {
        let webViewCoordinator = WebViewCoordinator(withPresenter: presenter, url: url, pageName: pageName)
        webViewCoordinator.start()
    }
}

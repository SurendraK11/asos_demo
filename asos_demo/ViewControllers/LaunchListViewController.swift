//
//  LaunchListViewController.swift
//  asos_demo
//
//  Created by Surendra
//  Copyright © 2019 Surendra. All rights reserved.
//

import UIKit

class LaunchListViewController: UIViewController {
    
    @IBOutlet private var filterButton: UIBarButtonItem!
    @IBOutlet private var tableView: UITableView!
    
    private let filterOptionPresenter: FilterOptionPresenting
    private let webViewPresenter: WebViewPresenting
    private var viewModel: LaunchListViewModelProtocol
    
    lazy private var spinnerView: SpinnerView = {
        return Bundle.main.loadNibNamed("\(SpinnerView.self)",
            owner: self, options: nil)?.first as! SpinnerView
    }()
    
    init(withViewModel viewModel:LaunchListViewModelProtocol, filterOptionPresenter: FilterOptionPresenting, webViewPresenter: WebViewPresenting) {
        self.filterOptionPresenter = filterOptionPresenter
        self.webViewPresenter = webViewPresenter
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        
        setupViewModel()
        
        viewModel.fetchLaunchInfo()
    }
    
    
    // this will be called when user taps on filter (right navigation button)
    @IBAction func showFilter(_ sender: UIBarButtonItem) {
        guard let _ = viewModel.filterOption.value else {
            return
        }
        filterOptionPresenter.presentFilter(viewModel.filterOption.value!, forViewController: self) {
            [weak self] (range) in
            self?.viewModel.filterOption.value = range
        }
    }
    
    //MARK: - Private methods
    private func setupTableView() {
        tableView.dataSource = viewModel.dataSource
        tableView.delegate = viewModel.dataSource
        var nibName = UINib(nibName: "\(ContentTableViewCell.self)", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "\(ContentTableViewCell.self)")
        
        nibName = UINib(nibName: "\(LaunchTableViewCell.self)", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "\(LaunchTableViewCell.self)")
        
        viewModel.dataSource.didSelectLaunch = { [weak self] launch in
            self?.showOptions(forLaunch: launch)
        }
        
        viewModel.dataSource.data.addObserver(withCompletionHandler: { [weak self] in
            self?.tableView.reloadData()
        })
    }
    
    
    
    /// showing option to user to choose open wiki or play
    ///
    /// - Parameter launch: Launch
    private func showOptions(forLaunch launch: Launch) {
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) {_ in}
        let ok = UIAlertAction(title: "OK", style: .default) {_ in}
        
        /// play video alert action
        let playVideo = UIAlertAction(title: "Play Video", style: .default) { _ in
            guard let videoUrl = launch.links.videoLink, let videoId = launch.links.youtubeId, let url = URL(string: "\(videoUrl)/\(videoId)") else {
                self.showConfirmAction(title: "", message: "Sorry, video not found", actions: [ok], style: .alert)
                return
            }
            self.webViewPresenter.loadURL(url, withTitle: "Video", forViewController: self)
            
        }
        
        /// show wiki alert action
        let openWiki = UIAlertAction(title: "Open Wiki", style: .default) { _ in
            guard let wikipediaLink = launch.links.wikipedia, let url = URL(string: wikipediaLink) else {
                self.showConfirmAction(title: "", message: "Sorry, wiki page not found", actions: [ok], style: .alert)
                return
            }
            self.webViewPresenter.loadURL(url, withTitle: "Wiki", forViewController: self)
  
        }
        
        self.showConfirmAction(title: "Choose Option", message: nil, actions: [playVideo, openWiki, cancel], style: .actionSheet)
    }
    
    /// setup view model
    private func setupViewModel() {
        
        // added observer to show/ hide spinner view when data loading started/ finished by view model
        viewModel.isLoading.addObserver() { [weak self] in
            guard let self = self else {
                return
            }
            if self.viewModel.isLoading.value == true {
                // show spinnerView while loading
                self.spinnerView.showSpinner(inVeiw: self.view, withInformation: "Please wait, data loading...")
            } else {
                // hide spinnerView when laoding finished
                self.spinnerView.hideSpinner()
            }
        }
        
        // add data loaded successfully
        self.viewModel.activateFilerOption = { [weak self] in
            guard let self = self else {
                return
            }
            self.filterButton.isEnabled = true
        }
        
        // add error handling
        self.viewModel.onErrorHandling = { [weak self] error in
            // display error
            self?.showError(error, completionHandler: nil)
        }
        
    }
}

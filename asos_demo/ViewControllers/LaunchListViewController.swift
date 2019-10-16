//
//  LaunchListViewController.swift
//  asos_demo
//
//  Created by Surendra
//  Copyright © 2019 Surendra. All rights reserved.
//

import UIKit

class LaunchListViewController: UIViewController {
    
    @IBOutlet private var tableView: UITableView!
    
    weak var delegate: LaunchListViewControllerDelegate?
    private var viewModel: LaunchListViewModelProtocol
    
    lazy private var spinnerView: SpinnerView = {
        return Bundle.main.loadNibNamed("\(SpinnerView.self)",
            owner: self, options: nil)?.first as! SpinnerView
    }()
    
    init(withViewModel viewModel:LaunchListViewModelProtocol) {
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
    @objc func showFilter() {
        guard let _ = viewModel.filterOption.value else {
            return
        }
        
        self.delegate?.launchListViewControllerShowFilterForFilterRange(viewModel.filterOption.value!, changeFilterClosure: { [weak self] (range) in
            self?.viewModel.filterOption.value = range
        })
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
            self?.delegate?.launchListViewControllerDidSelectLaunch(launch)
        }
        
        viewModel.dataSource.data.addObserver(withCompletionHandler: { [weak self] in
            self?.tableView.reloadData()
        })
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
        self.viewModel.showFilerOption = { [weak self] in
            guard let self = self else {
                return
            }
            let rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "filter"), style: .plain, target: self, action:#selector(self.showFilter) )
            self.navigationItem.rightBarButtonItem = rightBarButtonItem
        }
        
        // add error handling
        self.viewModel.onErrorHandling = { [weak self] error in
            // display error
            self?.showError(error, completionHandler: nil)
        }
        
    }
}

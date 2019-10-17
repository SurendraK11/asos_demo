//
//  FilterOptionCoordinator.swift
//  asos_demo
//
//  Created by Surendra on 17/10/2019.
//  Copyright © 2019 Surendra. All rights reserved.
//

import Foundation

class FilterOptionCoordinator: Coordinator {
    
    private let presenter: Router
    private let filterRange: FilterRange
    private let filterClosure: (FilterRange) -> ()
    
    init(withPresenter presenter: Router, filterRange: FilterRange, changeFilterClosure filterClosure: @escaping ((FilterRange) -> ())) {
        self.presenter = presenter
        self.filterRange = filterRange
        self.filterClosure = filterClosure
    }
    
    func start() {
        let filterOptionPresenter = FilterOptionViewController(withFilterRange: filterRange, changeFilterClosure: filterClosure)
        presenter.present(filterOptionPresenter.toShowable(), animated: true)
    }

}

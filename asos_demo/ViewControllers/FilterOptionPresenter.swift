//
//  FilterOptionPresenter.swift
//  asos_demo
//
//  Created by Surendra on 07/10/2019.
//  Copyright © 2019 Surendra. All rights reserved.
//

import UIKit
import RangeSeekSlider

class FilterOptionPresenter: UIViewController {
    
    @IBOutlet private var sortOrder: UISwitch!
    @IBOutlet private var rangeSlider: RangeSeekSlider!
    
    private let selectedFilterOption: ObservableValue<FilterRange> = .init(withValue: nil)
    private var filterRange: FilterRange?
    
    @IBAction func close(_ sender: UIBarButtonItem) {
        disposeAndClose()
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let _ = filterRange {
            setupViews(usingFilterRange: filterRange!)
        }
        
    }

    @IBAction func viewLaunchesTapped(_ sender: UIButton) {
        disposeAndClose()
    }
    
    @IBAction func sortingOrderChanged(_ sender: UISwitch) {
        combineLatestChange()
    }
    
    //MARK: - Private method
    private func setupViews(usingFilterRange filterRange: FilterRange) {
        rangeSlider.delegate = self
        rangeSlider.minValue = CGFloat(filterRange.minValue)
        rangeSlider.maxValue = CGFloat(filterRange.maxValue)
        rangeSlider.selectedMinValue = CGFloat(filterRange.selectedMinValue)
        rangeSlider.selectedMaxValue = CGFloat(filterRange.selectedMaxValue)
        rangeSlider.enableStep = true
        rangeSlider.minDistance = 1
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        rangeSlider.numberFormatter = formatter
        
        sortOrder.isOn = (filterRange.sortOption == .ASC)
    }
    
    private func combineLatestChange() {
        guard let _ = filterRange else {
            return
        }
        selectedFilterOption.value = FilterRange(minValue: filterRange!.minValue, maxValue: filterRange!.maxValue, selectedMinValue: Int(rangeSlider.selectedMinValue), selectedMaxValue: Int(rangeSlider.selectedMaxValue), sortOption: sortingOrder())
    }
    
    private func sortingOrder() -> SortOption {
        return sortOrder.isOn ? .ASC : .DESC
    }
    
    private func disposeAndClose() {
        selectedFilterOption.disposeBag()
        self.dismiss(animated: true, completion: nil)
    }
}

extension FilterOptionPresenter: RangeSeekSliderDelegate {
    func didEndTouches(in slider: RangeSeekSlider) {
        combineLatestChange()
    }
}

extension FilterOptionPresenter: FilterOptionPresenting {
    func presentFilter(_ filter: FilterRange, forViewController viewController: UIViewController, changeFilterClosure filterClosure: @escaping ((FilterRange) -> ())) {
        filterRange = filter
        selectedFilterOption.addObserver {
            [weak self] in
            guard let self = self, let filterRange = self.selectedFilterOption.value else {
                return
            }
            filterClosure(filterRange)

        }
        viewController.present(self, animated: true, completion: nil)
    }
}



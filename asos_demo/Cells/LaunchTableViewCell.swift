//
//  LaunchTableViewCell.swift
//  asos_demo
//
//  Created by Surendra on 07/10/2019.
//  Copyright © 2019 Surendra. All rights reserved.
//

import UIKit
import Kingfisher

class LaunchTableViewCell: UITableViewCell {
    
    @IBOutlet private var launchSuccessful: UIImageView!
    @IBOutlet private var missionPatch: UIImageView!
    @IBOutlet private var missionName: UILabel!
    @IBOutlet private var dateTime: UILabel!
    @IBOutlet private var rocketNameAndType: UILabel!
    @IBOutlet private var daySinceFromLabel: UILabel!
    @IBOutlet private var days: UILabel!
    
    /// Setup cell using view model
    ///
    /// - Parameter viewModel: LaunchCellViewModel
    func setup(withViewModel viewModel: LaunchCellViewModel) {
        missionName.text = viewModel.missionName
        dateTime.text = viewModel.dateAndTime
        rocketNameAndType.text = viewModel.rocketNameAndType
        launchSuccessful.image = viewModel.launchSuccessful
        if let _ = viewModel.missionPatchImageURL {
            missionPatch.kf.setImage(with: viewModel.missionPatchImageURL)
        } else {
            missionPatch.image = #imageLiteral(resourceName: "fallback")
        }
        days.text = "\(viewModel.days)"
        daySinceFromLabel.text = viewModel.daysLabel
    }
}

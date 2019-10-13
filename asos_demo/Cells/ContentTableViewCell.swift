//
//  ContentTableViewCell.swift
//  asos_demo
//
//  Created by Surendra on 07/10/2019.
//  Copyright © 2019 Surendra. All rights reserved.
//

import UIKit

class ContentTableViewCell: UITableViewCell {
    @IBOutlet private var information: UILabel!
    
    /// Setup cell using given view model
    ///
    /// - Parameter viewModel: ContentCellViewModelProtocol
    func setup(usingViewModel viewModel: ContentCellViewModelProtocol) {
        information.text = viewModel.informaiton()
    }
}

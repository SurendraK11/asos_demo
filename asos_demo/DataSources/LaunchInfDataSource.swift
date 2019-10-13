//
//  LaunchInfDataSource.swift
//  asos_demo
//
//  Created by Surendra.
//  Copyright © 2019 Surendra. All rights reserved.
//

import Foundation
import UIKit

class LaunchInfDataSource: GenericDataSource<LaunchInfo>, LaunchInfDataSourceProtocol {
    var didSelectLaunch: ((Launch) -> Void)?
}

extension LaunchInfDataSource : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let _ = data.value else {
            return 0
        }
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let _ = data.value else {
            return 0
        }
        return section == 0 ? 1 : data.value!.launches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        if indexPath.section == 0 {
            let contentCell = tableView.dequeueReusableCell(withIdentifier: "\(ContentTableViewCell.self)", for: indexPath) as! ContentTableViewCell
            
            // safe to force unwrap this as if there is value then surely there will be company
            contentCell.setup(usingViewModel: ContentCellViewModel(withCompany: data.value!.company))
            cell = contentCell
        } else {
             let launchCell = tableView.dequeueReusableCell(withIdentifier: "\(LaunchTableViewCell.self)", for: indexPath) as! LaunchTableViewCell
            
            // safe to force unwrap this as if there is value then surely there will be launches
            launchCell.setup(withViewModel: LaunchCellViewModel(withLaunch: data.value!.launches[indexPath.row]))
            cell = launchCell
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let frame = CGRect(origin: .zero, size: CGSize(width: tableView.frame.width, height: 35))
        let headerView = sectionHeaderView(withFrame: frame)
        headerView.text = section == 0 ? "Company" : "Launches"
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.section == 1 else {
            return
        }
        self.didSelectLaunch?(data.value!.launches[indexPath.row])
    }
    
    //Mark: - Private method
    private func sectionHeaderView(withFrame frame: CGRect) -> UILabel {
        let headerView = UILabel(frame: frame)
        headerView.textColor = .white
        headerView.font = .boldSystemFont(ofSize: 20)
        headerView.backgroundColor = .gray
        return headerView
    }
    
}

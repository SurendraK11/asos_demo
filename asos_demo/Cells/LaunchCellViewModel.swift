//
//  LaunchCellViewModel.swift
//  asos_demo
//
//  Created by Surendra on 07/10/2019.
//  Copyright © 2019 Surendra. All rights reserved.
//

import Foundation
import UIKit

/// ViewModel provides data for cell, it's responsibe to compute data for
/// cell to represent
struct LaunchCellViewModel {
    
    private let launch: Launch
    
    init(withLaunch launch: Launch) {
        self.launch = launch
    }
    
    var missionName : String {
        get {
            return launch.missionName
        }
    }
    
    var dateAndTime : String {
        get {
            let date = DateTimeFormatter.UTCToLocal(date: "\(launch.launchDateTime)", expectedFormat: "dd-MM-yyyy")
            let time = DateTimeFormatter.UTCToLocal(date: "\(launch.launchDateTime)", expectedFormat: "HH:mm:ss")
            return "\(date) and \(time)"
        }
    }
    
    var rocketNameAndType: String {
        get {
            return "\(launch.rocket.name) / \(launch.rocket.type)"
        }
    }
    
    var launchSuccessful: UIImage {
        get {
            guard let _ = launch.launchSuccess else {
                return #imageLiteral(resourceName: "cross")
            }
            return launch.launchSuccess! ? #imageLiteral(resourceName: "tick") : #imageLiteral(resourceName: "cross")
        }
    }
    
    var missionPatchImageURL: URL? {
        get {
            guard let _ = launch.links.missionPatchImage else {
                return nil
            }
            return URL(string: launch.links.missionPatchImage!)
        }
    }
    
    var days: Int {
        get {
            return daysFromLaunchDate()
        }
    }
    
    var daysLabel: String {
        get {
            return "Days \n\(daysFromLaunchDate() < 0 ? "since" : "from") now:"
        }
    }
    
    private func daysFromLaunchDate() -> Int {
        return Calendar.current.dateComponents([.day], from: Date(), to: launch.launchDateTime).day ?? 0
    }
}

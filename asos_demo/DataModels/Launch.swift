//
//  Launch.swift
//  asos_demo
//
//  Created by Surendra.
//  Copyright © 2019 Surendra. All rights reserved.
//

import Foundation

struct Launch: Decodable {
    
    struct Rocket: Decodable {
        let name: String
        let type: String
        
        enum CodingKeys: String, CodingKey {
            case name = "rocket_name"
            case type = "rocket_type"
        }
    }
    
    struct Links: Decodable {
        let missionPatchImage: String?
        let wikipedia: String?
        let videoLink: String?
        let youtubeId: String?
        
        enum CodingKeys: String, CodingKey {
            case missionPatchImage = "mission_patch_small"
            case wikipedia = "wikipedia"
            case videoLink = "video_link"
            case youtubeId = "youtube_id"
        }
    }
    
    let missionName: String
    let launchDateTime: Date
    let launchYear: Int
    let launchSuccess: Bool?
    let rocket: Rocket
    let links: Links
    
    
    init(withMissionName missionName: String, launchDateTime: Date, launchYear: Int, launchSuccess: Bool?, rocket: Rocket, links: Links) {
        self.missionName = missionName
        self.launchDateTime = launchDateTime
        self.launchYear = launchYear
        self.launchSuccess = launchSuccess
        self.rocket = rocket
        self.links = links
        
    }
    
    enum CodingKeys: String, CodingKey {
        case missionName = "mission_name"
        case localDateTime = "launch_date_local"
        case launchYear = "launch_year"
        case launchSuccess = "launch_success"
        case rocket = "rocket"
        case links = "links"
        case launchDateTimeInUnix = "launch_date_unix"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let missionName: String = try container.decode(String.self, forKey: .missionName)
        let dateInUnix: Double = try container.decode(Double.self, forKey: .launchDateTimeInUnix)
        let launchDateTime = Date(timeIntervalSince1970: dateInUnix)
        let launchYear: Int = try Int(container.decode(String.self, forKey: .launchYear)) ?? 1900 //just to avoid force unwarpping
        let launchSuccess: Bool? = try? container.decode(Bool.self, forKey: .launchSuccess)
        let rocket: Rocket = try container.decode(Rocket.self, forKey: .rocket)
        let links: Links = try container.decode(Links.self, forKey: .links)
        
        self.init(withMissionName: missionName, launchDateTime: launchDateTime, launchYear: launchYear, launchSuccess: launchSuccess, rocket: rocket, links: links)

    }
    
    
}


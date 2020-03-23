//
//  Launch.swift
//  EVGo
//
//  Created by Hoof on 3/12/20.
//  Copyright © 2020 Retinal Media. All rights reserved.
//

import UIKit

internal struct Launch: Codable {

    let missionName: String
    let launchDate: Date
    let rocket: Rocket
    let links: Links
    
    
    var yearStr: String {
        let formatter = Dependencies.yearFormatter
        return formatter.string(from: launchDate)
    }
    
    
    public enum CodingKeys: String, CodingKey {
        case missionName = "mission_name"
        case rocket
        case launchDate = "launch_date_utc"
        case links
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        missionName = try container.decode(String.self, forKey: .missionName)
        launchDate = try container.decode(Date.self, forKey: .launchDate)
        links = try container.decode(Links.self, forKey: .links)
        rocket = try container.decode(Rocket.self, forKey: .rocket)
    }
}

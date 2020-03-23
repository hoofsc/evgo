//
//  Rocket.swift
//  EVGo
//
//  Created by Hoof on 3/12/20.
//  Copyright © 2020 Retinal Media. All rights reserved.
//

import UIKit

internal struct Rocket: Codable {

    let name: String
    
    public enum CodingKeys: String, CodingKey {
        case name = "rocket_name"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
    }
}

//
//  Links.swift
//  EVGo
//
//  Created by Hoof on 3/12/20.
//  Copyright © 2020 Retinal Media. All rights reserved.
//

import UIKit

internal struct Links: Codable {

    let videoURLStr: String?
    
    var videoURL: URL? {
        guard let videoURLStr = videoURLStr else { return nil }
        return URL(string: videoURLStr)
    }
    
    
    public enum CodingKeys: String, CodingKey {
        case videoURLStr = "video_link"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        videoURLStr = try container.decodeIfPresent(String.self, forKey: .videoURLStr)
    }
}

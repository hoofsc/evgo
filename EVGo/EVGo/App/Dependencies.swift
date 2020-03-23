//
//  Dependencies.swift
//  EVGo
//
//  Created by Hoof on 3/23/20.
//  Copyright © 2020 Retinal Media. All rights reserved.
//

import Foundation
import UIKit

internal class Dependencies: NSObject {

    private(set) static var dateDecodeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        return formatter
    }()
    private(set) static var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, YYYY HH:mm:ss"
        return formatter
    }()
    private(set) static var yearFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY"
        return formatter
    }()
    
    
    var app: UIApplication { return UIApplication.shared }
    var appDelegate: AppDelegate {
        if let appDel = appContext?.appDelegate as? AppDelegate {
            return appDel
        } else {
            fatalError("AppDelegate is nil!")
        }
    }
    
    // Services
    var launchService = LaunchService()

    private(set) weak var appContext: AppContext?


    init(appContext: AppContext?) {
        self.appContext = appContext
    }


    func updateAppContext(appContext: AppContext?) {
        self.appContext = appContext
    }
}

//
//  SearchContext.swift
//  EVGo
//
//  Created by Hoof on 3/19/20.
//  Copyright © 2020 Retinal Media. All rights reserved.
//

import UIKit
import Foundation

internal class SearchContext: DCIContext, ContextUI {

    typealias VC = SearchNVC

    let isRoot: Bool = true

    var parentContext: DCIContext?
    var dependencies: Dependencies
    var ui: VC? { return uiNVC }
    var launches = [Launch]()

    
    private(set) var uiNVC: SearchNVC?
    private(set) var searchVC: SearchVC?


    init(parent: DCIContext, dependencies deps: Dependencies) {
        parentContext = parent
        dependencies = deps
    }
    

    func constructUI() -> VC? {
        if let alreadyUI = ui {
            return alreadyUI
        }
        let vc = SearchVC(context: self)
        let navVC = SearchNVC(context: self, rootViewController: vc)
        uiNVC = navVC
        searchVC = vc
        return uiNVC
    }

    func destroyUI() {
        uiNVC = nil
        searchVC = nil
    }

    func fetchLaunches(completion: @escaping ((APIResult<[Launch]>) -> Void)) {
        dependencies.launchService.fetchLaunches { [weak self] result in
            switch result {
            case let .success(launches):
                self?.launches = launches
            case let .failure(error):
                print("error: \(String(describing: error))")
            }
            completion(result)
        }
    }
    
    func presentDetail(for launch: Launch) {
        let vc = DetailVC()
        vc.title = launch.missionName
        vc.update(missionNameStr: launch.missionName,
                  rocketNameStr: launch.rocket.name,
                  launchDateStr: Dependencies.dateFormatter.string(from: launch.launchDate),
                  videoURL: launch.links.videoURL)
        uiNVC?.pushViewController(vc, animated: true)
    }
}

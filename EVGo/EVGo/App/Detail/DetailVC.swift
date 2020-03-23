//
//  DetailViewController.swift
//  EVGo
//
//  Created by Hoof on 3/16/20.
//  Copyright © 2020 Retinal Media. All rights reserved.
//

import UIKit

internal class DetailVC: UIViewController {
    
    var contentView: DetailCV {
        return view as? DetailCV ?? DetailCV()
    }
    var ytPlayerVC: YTPlayerViewController?
    

    override func loadView() {
        view = DetailCV()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavBar()
        setUpVideoPlayer()
    }
    
    deinit {
        ytPlayerVC = nil
    }
    
    
    func update(missionNameStr: String, rocketNameStr: String, launchDateStr: String, videoURL: URL?) {
        contentView.update(missionNameStr: missionNameStr,
                           rocketNameStr: rocketNameStr,
                           launchDateStr: launchDateStr)
        guard let videoURL = videoURL else {
            contentView.empty.isHidden = false
            return
        }
        ytPlayerVC?.url = videoURL
    }
    
    
    private func setUpNavBar() {
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func setUpVideoPlayer() {
        let vc = YTPlayerViewController()
        vc.willMove(toParent: self)
        addChild(vc)
        contentView.videoPlayerContainerView.addSubview(vc.view)
        vc.view.frame = contentView.videoPlayerContainerView.bounds
        vc.didMove(toParent: self)
        ytPlayerVC = vc
    }
}

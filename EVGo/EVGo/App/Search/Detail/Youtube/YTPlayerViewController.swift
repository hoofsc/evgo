//
//  YTPlayerViewController.swift
//  EVGo
//
//  Created by Hoof on 3/18/20.
//  Copyright © 2020 Retinal Media. All rights reserved.
//

import UIKit

internal class YTPlayerViewController: UIViewController {

    var url: URL? {
        didSet {
            loadVideoPlayer()
            setUpConstraints()
        }
    }
    
    
    private var player: YTSwiftyPlayer?
    private var ytVideoID: String? {
        guard let url = url else { return nil }
        if let ID = url.query?.components(separatedBy: "=").last {
            return ID
        } else {
            return url.pathComponents.last
        }
    }
    
    
    deinit {
        player?.cleanUp()
        player?.delegate = nil
        player?.removeFromSuperview()
        player = nil
    }
    
    
    private func loadVideoPlayer() {
        guard let ytVideoID = ytVideoID else {
            print("No ytVideoID.")
            return
        }
        player = YTSwiftyPlayer(frame: CGRect.zero, playerVars: [ .playsInline(true), .videoID(ytVideoID)] )
        guard let player = player else { return }
        player.autoplay = false
        view.addSubview(player)
        player.delegate = self
        player.loadPlayer()
    }
    
    private func setUpConstraints() {
        guard let player = player else { return }
        var constraints = [NSLayoutConstraint]()
        constraints += [
            player.topAnchor.constraint(equalTo: view.topAnchor),
            player.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            player.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            player.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}


extension YTPlayerViewController: YTSwiftyPlayerDelegate {
    
    func playerReady(_ player: YTSwiftyPlayer) {
       print(#function)
       // After loading a video, player's API is available.
       // e.g. player.mute()
   }
   
   func player(_ player: YTSwiftyPlayer, didUpdateCurrentTime currentTime: Double) {
       print("\(#function): \(currentTime)")
   }
   
   func player(_ player: YTSwiftyPlayer, didChangeState state: YTSwiftyPlayerState) {
       print("\(#function): \(state)")
   }
   
   func player(_ player: YTSwiftyPlayer, didChangePlaybackRate playbackRate: Double) {
       print("\(#function): \(playbackRate)")
   }
   
   func player(_ player: YTSwiftyPlayer, didReceiveError error: YTSwiftyPlayerError) {
       print("\(#function): \(error)")
   }
   
   func player(_ player: YTSwiftyPlayer, didChangeQuality quality: YTSwiftyVideoQuality) {
       print("\(#function): \(quality)")
   }
   
   func apiDidChange(_ player: YTSwiftyPlayer) {
       print(#function)
   }
   
   func youtubeIframeAPIReady(_ player: YTSwiftyPlayer) {
       print(#function)
   }
   
   func youtubeIframeAPIFailedToLoad(_ player: YTSwiftyPlayer) {
       print(#function)
   }
}

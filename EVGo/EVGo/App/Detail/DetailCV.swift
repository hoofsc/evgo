//
//  DetailCV.swift
//  EVGo
//
//  Created by Hoof on 3/23/20.
//  Copyright © 2020 Retinal Media. All rights reserved.
//

import UIKit

internal class DetailCV: UIView {

    private(set) lazy var videoPlayerContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private(set) lazy var empty: UILabel = {
        let lbl = UILabel()
        lbl.text = NSLocalizedString("Video Unavailable", comment: "Video unavailable.")
        lbl.isHidden = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    private(set) lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private(set) lazy var missionNameLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 16.0)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    private(set) lazy var rocketNameLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    private(set) lazy var launchDateLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    
    required init?(coder aDecoder: NSCoder) {
        let msg = String(describing: type(of: self)) + " cannot be used with a nib file"
        fatalError(msg)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
        setUpCustomSpacing()
        setUpConstraints()
    }
    
    
    func update(missionNameStr: String, rocketNameStr: String, launchDateStr: String) {
        missionNameLabel.text = "Mission: " + missionNameStr
        rocketNameLabel.text = "🚀 " + rocketNameStr
        launchDateLabel.text = "Launch Date: " + launchDateStr
    }


    private func setUpCustomSpacing() {
        stackView.setCustomSpacing(5.0, after: missionNameLabel)
        stackView.setCustomSpacing(5.0, after: rocketNameLabel)
    }
    
    private func setUpViews() {
        addSubview(videoPlayerContainerView)
            videoPlayerContainerView.addSubview(empty)
        addSubview(stackView)
            stackView.addArrangedSubview(missionNameLabel)
            stackView.addArrangedSubview(rocketNameLabel)
            stackView.addArrangedSubview(launchDateLabel)
    }

    private func setUpConstraints() {
        var constraints = [NSLayoutConstraint]()
        constraints += [
            videoPlayerContainerView.widthAnchor.constraint(equalTo: videoPlayerContainerView.heightAnchor,
                                                            multiplier: 16.0 / 9.0),
            videoPlayerContainerView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            videoPlayerContainerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            videoPlayerContainerView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ]
        constraints += [
            empty.centerXAnchor.constraint(equalTo: videoPlayerContainerView.centerXAnchor),
            empty.centerYAnchor.constraint(equalTo: videoPlayerContainerView.centerYAnchor)
        ]
        constraints += [
            stackView.topAnchor.constraint(equalTo: videoPlayerContainerView.bottomAnchor, constant: 20.0),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20.0),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -1.0 * 20.0)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

//
//  LaunchCell.swift
//  EVGo
//
//  Created by Hoof on 3/16/20.
//  Copyright © 2020 Retinal Media. All rights reserved.
//

import UIKit

internal class LaunchCell: UITableViewCell {

    static let identifier = String(describing: type(of: self)) + "ID"

    private(set) lazy var  stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private(set) lazy var  missionNameLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 16.0)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    private(set) lazy var  rocketNameLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    private(set) lazy var  launchDateLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    private(set) lazy var videoImage: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "videoIcon"))
        iv.tintColor = .black
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()


    required init?(coder aDecoder: NSCoder) {
        let msg = String(describing: type(of: self)) + " cannot be used with a nib file"
        fatalError(msg)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
        setUpConstraints()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        missionNameLabel.text = nil
        rocketNameLabel.text = nil
        launchDateLabel.text = nil
        videoImage.isHidden = true
    }
    
    
    func update(missionName: String, rocketName: String, launchDate: Date, videoURL: URL?) {
        missionNameLabel.text = missionName
        rocketNameLabel.text = "🚀 " + rocketName
        launchDateLabel.text = Dependencies.dateFormatter.string(from: launchDate)
        videoImage.isHidden = (videoURL == nil)
    }

    
    private func setUpViews() {
        contentView.addSubview(stackView)
            stackView.addArrangedSubview(missionNameLabel)
            stackView.addArrangedSubview(rocketNameLabel)
            stackView.addArrangedSubview(launchDateLabel)
        contentView.addSubview(videoImage)
    }

    private func setUpConstraints() {
        var constraints = [NSLayoutConstraint]()
        constraints += [
            contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 54.0)
        ]
        constraints += [
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20.0),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20.0),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -1.0 * 20.0),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -1.0 * 20.0)
        ]
        constraints += [
            videoImage.widthAnchor.constraint(equalToConstant: 32.0),
            videoImage.heightAnchor.constraint(equalToConstant: 32.0),
            videoImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -1.0 * 20.0),
            videoImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -1.0 * 20.0)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

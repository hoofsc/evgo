//
//  SearchCV.swift
//  EVGo
//
//  Created by Hoof on 3/23/20.
//  Copyright © 2020 Retinal Media. All rights reserved.
//

import UIKit

internal class SearchCV: UIView {

    private(set) lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    private(set) lazy var activity: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        if #available(iOS 13.0, *) {
            view.style = .medium
        } else {
            view.style = .gray
        }
        view.hidesWhenStopped = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private(set) lazy var refreshControl: UIRefreshControl = {
        let rc = UIRefreshControl()
        if #available(iOS 10.0, *) {
            tableView.refreshControl = rc
        } else {
            tableView.addSubview(rc)
        }
        rc.translatesAutoresizingMaskIntoConstraints = false
        return rc
    }()

    required init?(coder aDecoder: NSCoder) {
        let msg = String(describing: type(of: self)) + " cannot be used with a nib file"
        fatalError(msg)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
        setUpConstraints()
    }

    
    func startActivity() {
        activity.startAnimating()
        tableView.isHidden = true
    }
    
    func stopActivity() {
        activity.stopAnimating()
        tableView.isHidden = false
        refreshControl.endRefreshing()
    }
    

    private func setUpViews() {
        addSubview(tableView)
        addSubview(activity)
    }

    private func setUpConstraints() {
        var constraints = [NSLayoutConstraint]()
        constraints += [
            tableView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ]
        constraints += [
            activity.centerXAnchor.constraint(equalTo: centerXAnchor),
            activity.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

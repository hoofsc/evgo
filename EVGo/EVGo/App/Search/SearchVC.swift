//
//  SearchVC.swift
//  EVGo
//
//  Created by Hoof on 3/23/20.
//  Copyright © 2020 Retinal Media. All rights reserved.
//

import UIKit

internal class SearchVC: UIViewController {

    var contentView: SearchCV {
        return view as? SearchCV ?? SearchCV()
    }

    
    private var launches: [Launch] {
        return context.launches
    }
    private var filteredLaunches = [Launch]()
    private var launchesCount: Int {
        let launchDataSource = (searchController?.isActive ?? false) ? filteredLaunches : launches
        return launchDataSource.count
    }
    private var searchController: UISearchController?


    private let context: SearchContext


    init(context: SearchContext) {
        self.context = context
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        let msg = String(describing: type(of: self)) + " cannot be used with a nib file"
        fatalError(msg)
    }

    override func loadView() {
        view = SearchCV()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSearchController()
        setUpNavBar()
        setUpTableView()
        setUpActions()
        fetchLaunches(showActivity: true)
    }

    
    @objc
    private func refreshData() {
        fetchLaunches(showActivity: false)
    }
    

    private func fetchLaunches(showActivity: Bool) {
        if showActivity { contentView.startActivity() }
        context.fetchLaunches { result in
            DispatchQueue.main.async { [weak self] in
                self?.contentView.stopActivity()
                if case .success = result {
                    self?.contentView.tableView.reloadData()
                }
                if case let .failure(error) = result {
                    self?.handle(error: error as NSError)
                }
            }
        }
    }
    
    private func handle(error: NSError) {
        let alert = UIAlertController(title: "Oops", message: "An error occurred. Please try again.", preferredStyle: .alert)
        let ok = UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
        })
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }

    private func setUpNavBar() {
        navigationItem.title = NSLocalizedString("Launches", comment: "Title of Launches list screen")
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.searchController = searchController
    }

    private func setUpSearchController() {
        searchController = {
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.obscuresBackgroundDuringPresentation = false
            controller.searchBar.placeholder = NSLocalizedString("Search by mission, rocket, or year",
                                                                 comment: "Search placeholder")
            return controller
        }()
    }

    private func setUpTableView() {
        contentView.tableView.dataSource = self
        contentView.tableView.delegate = self
        contentView.tableView.estimatedRowHeight = 64.0
        contentView.tableView.rowHeight = UITableView.automaticDimension
        contentView.tableView.register(LaunchCell.self, forCellReuseIdentifier: LaunchCell.identifier)
    }
    
    private func setUpActions() {
        contentView.refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
    fileprivate func search(text: String) {
        let missionFiltered = launches.filter { $0.missionName.lowercased().contains(text.lowercased()) }
        let rocketNameFiltered = launches.filter { $0.rocket.name.lowercased().contains(text.lowercased()) }
        let yearFiltered = launches.filter { $0.yearStr.contains(text) }
        filteredLaunches = missionFiltered + rocketNameFiltered + yearFiltered
        filteredLaunches.sort {
            $0.launchDate > $1.launchDate
        }
        contentView.tableView.reloadData()
    }
}


// MARK: UITableViewDataSource

extension SearchVC: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return launchesCount
    }
}


// MARK: UITableViewDelegate

extension SearchVC: UITableViewDelegate {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LaunchCell.identifier, for: indexPath)
        let launchDataSource = (searchController?.isActive ?? false) ? filteredLaunches : launches
        if indexPath.row < launchDataSource.count,
           let cell = cell as? LaunchCell {
                let launch = launchDataSource[indexPath.row]
                cell.update(missionName: launch.missionName,
                            rocketName: launch.rocket.name,
                            launchDate: launch.launchDate,
                            videoURL: launch.links.videoURL)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let launchDataSource = (searchController?.isActive ?? false) ? filteredLaunches : launches
        guard indexPath.row < launchDataSource.count else { return }
        let launch = launchDataSource[indexPath.row]
        context.presentDetail(for: launch)
    }
}


// MARK: UISearchResultsUpdating

extension SearchVC: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        let searchText = (searchController.searchBar.text ?? "")
        search(text: searchText)
    }
}

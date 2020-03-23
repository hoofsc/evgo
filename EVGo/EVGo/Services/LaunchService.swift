//
//  LaunchService.swift
//  EVGo
//
//  Created by Hoof on 3/12/20.
//  Copyright © 2020 Retinal Media. All rights reserved.
//

import UIKit

typealias LaunchList = LaunchListQuery.Data.Launch


internal class LaunchService: NSObject {

    func fetchLaunches(completion: @escaping ((APIResult<[Launch]>) -> Void)) {
        Network.shared.apollo.fetch(query: LaunchListQuery()) { result in
            var thisResult: APIResult<[Launch]>
            switch result {
            case .success(let graphQLResult):
                print("Success! Result: \(graphQLResult)")
                guard let launches = graphQLResult.data?.resultMap["launches"] as? [[String: Any]],
                      let launchesData = try? JSONSerialization.data(withJSONObject: launches, options: .fragmentsAllowed) else {
                        return
                }
                do {
                    let decoder = JSONDecoder()
                    let df = Dependencies.dateDecodeFormatter
                    let dateDecoding = JSONDecoder.DateDecodingStrategy.formatted(df)
                    decoder.dateDecodingStrategy = dateDecoding
                    var launches = try decoder.decode([Launch].self, from: launchesData)
                    launches.sort {
                        $0.launchDate > $1.launchDate
                    }
                    thisResult = .success(launches)
                } catch {
                    thisResult = .failure(error as NSError)
                }
            case .failure(let error):
                print("Failure! Error: \(error)")
                thisResult = .failure(error as NSError)
            }
            completion(thisResult)
        }
    }
}

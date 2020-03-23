//
//  Network.swift
//  EVGo
//
//  Created by Hoof on 3/12/20.
//  Copyright © 2020 Retinal Media. All rights reserved.
//

import Foundation
import Apollo

// MARK: - Singleton Wrapper

internal class Network {
    static let shared = Network()

    // Configure the network transport to use the singleton as the delegate.
    private lazy var networkTransport: HTTPNetworkTransport = {
        let transport = HTTPNetworkTransport(url: URL(string: baseURLStr)!)
        transport.delegate = self
        return transport
    }()

    // Use the configured network transport in your Apollo client.
    private(set) lazy var apollo = ApolloClient(networkTransport: self.networkTransport)
}

// MARK: - Pre-flight delegate

extension Network: HTTPNetworkTransportPreflightDelegate {

  func networkTransport(_ networkTransport: HTTPNetworkTransport,
                          shouldSend request: URLRequest) -> Bool {
    // If there's an authenticated user, send the request. If not, don't.
    return true
  }
  
  func networkTransport(_ networkTransport: HTTPNetworkTransport,
                        willSend request: inout URLRequest) {
  }
}

// MARK: - Task Completed Delegate

extension Network: HTTPNetworkTransportTaskCompletedDelegate {
  func networkTransport(_ networkTransport: HTTPNetworkTransport,
                        didCompleteRawTaskForRequest request: URLRequest,
                        withData data: Data?,
                        response: URLResponse?,
                        error: Error?) {
    print("Raw task completed for request: \(request)")
                        
    if let error = error {
      print("Error: \(error)")
    }
    
    if let response = response {
      print("Response: \(response)")
    } else {
      print("No URL Response received!")
    }
    
    if let data = data {
      print("Data: \(String(describing: String(bytes: data, encoding: .utf8)))")
    } else {
      print("No data received!")
    }
  }
}

// MARK: - Retry Delegate

extension Network: HTTPNetworkTransportRetryDelegate {

    func networkTransport(_ networkTransport: HTTPNetworkTransport,
                            receivedError error: Error,
                            for request: URLRequest,
                            response: URLResponse?,
                            retryHandler: @escaping (_ shouldRetry: Bool) -> Void) {

        retryHandler(false)
    }
}

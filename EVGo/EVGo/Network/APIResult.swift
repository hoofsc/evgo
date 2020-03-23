//
//  APIResult.swift
//  EVGo
//
//  Created by Hoof on 3/12/20.
//  Copyright © 2020 Retinal Media. All rights reserved.
//

import Foundation

public enum APIResult<Value> {
    case success(Value)
    case failure(Error)
    
    public var value: Value? {
        switch self {
        case .success(let value):
            return value
        case .failure:
            return nil
        }
    }
    
    public var error: Error? {
        switch self {
        case .success:
            return nil
        case .failure(let error):
            return error
        }
    }
}


extension APIResult: CustomStringConvertible {
    public var description: String {
        switch self {
        case .success:
            return "Success"
        case .failure:
            return "Failure"
        }
    }
}


extension APIResult: CustomDebugStringConvertible {
    public var debugDescription: String {
        switch self {
        case .success(let value):
            return "Success: \(String(describing: value))"
        case .failure(let error):
            return "Failure: \(String(describing: error))"
        }
    }
}
